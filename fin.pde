import java.net.URL;
import java.io.*;
import java.util.*;

PImage map;
World world;
Coordinate c;
MyButton b;


void setup(){
  size(600,800);
  map = loadImage("map.png");
  c = new Coordinate();
  world = new World("104", "CNU");
  Location_API api = new Location_API("http://192.168.0.6/~HSikkk",world.getMyLoc());
  b = new MyButton();
  b.addObserver(c);
}

void draw(){
  background(0);
  world.draw();
  b.draw();
}

void mousePressed(){
  b.onClick(mouseX,mouseY);
}

//void keyPressed(){
//  if(key == '='){c.zoomIn();;}
//  if(key == '-'){c.zoomOut();}
//  if(key == 'd'){c.setX(c.getX()+10);}
//  if(key == 'a'){c.setX(c.getX()-10);}
//  if(key == 's'){c.setY(c.getY()+10);}
//  if(key == 'w'){c.setY(c.getY()-10);}
//}

class World{
  private ArrayList <Location> lists;
  private Location destLoc;
  private MyLocation myLoc;
  Factory factory;
  
  World(String route, String dest){
    factory = new Factory("data.xml");
    lists = factory.getList(route);
    destLoc = factory.getDest(route, dest, 1);
    myLoc = new MyLocation(0,0);
  }
  
  void draw(){
    image(map,-c.getX(),-c.getY(),
    map.width*c.getScale(), map.height*c.getScale());
    for(Location a: lists){
      a.draw();
    }
    destLoc.draw();
    myLoc.draw();
  
    if(world.check()) background(100);
  }
  
  MyLocation getMyLoc(){
    return myLoc;
  }

  boolean check(){
    if((destLoc.getX()-myLoc.getX())*(destLoc.getX()-myLoc.getX())
    + (destLoc.getY()-myLoc.getY())*(destLoc.getY()-myLoc.getY())< 1000) return true;
    
    return false;
  }
  
}

class Factory{
  XML xml;
  
  Factory(String filename){
    xml = loadXML(filename);
  }
  
  ArrayList <Location> getList(String routeName){
    ArrayList<Location> locations = new ArrayList <Location>();
    XML[] allroutes = xml.getChildren("route");
    for(XML route : allroutes){
      if(routeName.equals(route.getString("name"))){
        XML[] allstations = route.getChildren("station");
        for(XML station : allstations){
          locations.add(new Location(station));
        }
      }
    }
    return locations;
  }
  
Location getDest(String routeName, String dest, int num){
    XML[] allroutes = xml.getChildren("route");
    for(XML route : allroutes){
      if(routeName.equals(route.getString("name"))){
        XML[] allstations = route.getChildren("station");
        
        int no=0;
        for(XML station : allstations){
          if(dest.equals(station.getString("name"))){
            no = parseInt(station.getChild("no").getContent());
            break;
          }
        }
        
        for(XML station : allstations){
          if(no - num == parseInt(station.getChild("no").getContent())){
            return new Location(station);
          }
        }
      }
    }
    return null;
  }
}

interface Drawable{
  void draw();
}