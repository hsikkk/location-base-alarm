class Coordinate{
  private float x_t,y_t,scale;
  Coordinate(){
    x_t=0;
    y_t=0;
    scale=1;
  }
    
  float getX(){return x_t;}
  float getY(){return y_t;}
  float getScale(){return scale;}
  float getCalcX(float x){return x*scale-x_t;}
  float getCalcY(float y){return y*scale-y_t;}
  float getOriginalX(float x){return (x+x_t)/scale;}
  float getOriginalY(float y){return (y+y_t)/scale;}

  void setX(float x){
    x_t = x;
    if(x_t< 0) x_t = 0;
    if(x_t>map.width*scale - width) x_t = map.width*scale - width;
  }
  void setY(float y){
    y_t = y;
    if(y_t< 0) y_t = 0;
    if(y_t>map.height*scale - height) y_t = map.height*scale - height;
  }
  void zoomIn(){
    scale *=1.1;
    if (scale>pow(1.1,10)) scale = pow(1.1,10);
    else{
      x_t += 0.1*(width/2+x_t);
      y_t += 0.1*(width/2+y_t);
    }
  }
  
  void zoomOut(){
    scale*=0.9; 
    if (scale<0.81) scale = 0.81;
    else{
      setX(x_t-0.1*(width/2+x_t));
      setY(y_t-0.1*(width/2+y_t));
    }
  }
  
  void reset(){
    setX(x_t+getCalcX(world.getMyLoc().getX())-width/2);
    setY(y_t+getCalcY(world.getMyLoc().getY())-height/2);
  }
 
}