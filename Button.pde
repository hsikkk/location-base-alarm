
class MyButton implements Drawable{
  private float x, y;
  PImage button;
  Coordinate c;
  
  MyButton(){
    x=7*width/8;
    y=2*height/10;
    button = loadImage("button.png");
  }
  
  void addObserver(Coordinate c){
    this.c=c;
  }
  
  void draw(){
    image(button, x,y,width/11, width/11);
  }
  
  void onClick(float mx, float my){
    if(mx < x || mx > x+width/11) return;
    if(my < y || my > y+width/11) return;
    println("1");
    c.reset();
  }
  
}