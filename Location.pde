class Location implements Drawable{
  protected float x,y;
  protected String name;
  PImage loc;
  
  Location(XML xml){
    x=parseFloat(xml.getChild("x").getContent());
    y=parseFloat(xml.getChild("y").getContent());
    name = xml.getString("name");
    loc = loadImage("loc.png");
  }
  
  //Overloading
  Location(float x, float y){
    this.x=x; this.y=y;
  }
  
  float getX(){return x;}
  float getY(){return y;}
  void setX(float x){this.x =x;}
  void setY(float y){this.y =y;}
  
  void draw(){
    image(loc,c.getCalcX(x)-width/60,c.getCalcY(y),width/30,width/20);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text(name,c.getCalcX(x), c.getCalcY(y)-width/150);
  }
  
}

class MyLocation extends Location{
  MyLocation(float x, float y){
    super(x,y);
    name="Me";
    loc = loadImage("my.png");
  }
}