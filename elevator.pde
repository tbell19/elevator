import processing.sound.*;

PImage bgImg;
PImage litButton;
PImage darkButton;
int buttonSize = 50;

PFont braile;
PFont defaultFont;


Floor[] floors;
Button[] buttons;

//floor sounds from https://freetts.com/
SoundFile firstFloor;
SoundFile secondFloor;
SoundFile thirdFloor;
SoundFile doorsOpen;
Controller controller;


void setup(){
  firstFloor = new SoundFile(this, "assets/sounds/announcer/ground.mp3");
  doorsOpen = new SoundFile(this, "assets/sounds/announcer/floors/open.mp3");
  
  bgImg = loadImage("assets/steel.jpg");
  litButton = loadImage("assets/button-lit.png");
  darkButton = loadImage("assets/button-dark.png");
  
  braile = loadFont("assets/Braille2.vlw");
  defaultFont = loadFont("assets/Ubuntu-Light-48.vlw");
  
  size(500,1000);
  floors = new Floor[4];
  buttons = new Button[6];
  
  
  buttons[0] = new Button(100,875,"B","B");
  floors[0] = new Floor("B",buttons[0], new String[]{"ATLC","Crossroads Studio","Instruction Labs 16 & 17"});

  buttons[1] = new Button(100,820,"G","G");
  floors[1] = new Floor("G",buttons[1], new String[]{"Service Desks","Document Delivery"});
  
  buttons[2] = new Button(100,765,"2","#2");
  floors[2] = new Floor("2",buttons[2], new String[]{"Dynamic Media Services","3D Animation Lab","Anatomy Models","Makerspace","Virtual Reality Lab"});
  
  buttons[3] = new Button(100,710,"3","#3");
  floors[3] = new Floor("3",buttons[3], new String[]{"Administrative Offices","Room 309","Office of Pragmaticism"});
  
  buttons[4] = new Button(230,875,"< >","");
  buttons[5] = new Button(300,875,"> <","");
  
  controller = new Controller();
}

void startController(){
  this.controller.run(floors);
}

void draw(){
  background(bgImg);
  for(int i = 0; i < buttons.length; i++){
    buttons[i].draw();
  }
  fill(0, 0, 0);
  rect(100,0,300,534);
  textSize(100);
  fill(255, 255, 255);
  
  
  text(floors[this.controller.currentFloor].text,250-textWidth(floors[this.controller.currentFloor].text)/2,100); 
  if(controller.direction == 1){
      text("▲",300,100); 
  }else if(controller.direction == 2){
      text("▼",300,100); 
  }
  
  textSize(25);
  fill(255, 255, 255);
  text("On this floor:",102,200); 
  for(int i =0; i < floors[this.controller.currentFloor].details.length; i++){
    text("· "+floors[this.controller.currentFloor].details[i],105,225+(24*i)); 
  }
}

void mouseClicked(){
  
  for(int i = 0; i < buttons.length; i++){
    if(buttons[i].checkClick() == true){
      buttons[i].lit = true;
      if(!this.controller.running){
         thread("startController");
      }
    }
  }
}
