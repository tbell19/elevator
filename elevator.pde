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
SoundFile basement;
SoundFile groundFloor;
SoundFile secondFloor;
SoundFile thirdFloor;
SoundFile doorsOpen;
SoundFile doorsClose;
SoundFile goingUpS;
SoundFile goingDown;
SoundFile music;
//song by Steinberg Cubase 8.5 and EastWest Hollywood Orchestra.
SoundFile alarm;
SoundFile phoneout;

Controller controller;


void setup(){
  basement = new SoundFile(this, "assets/sounds/announcer/basement.wav");
  basement.amp(1);
  groundFloor = new SoundFile(this, "assets/sounds/announcer/groundFloor.wav");
  secondFloor = new SoundFile(this, "assets/sounds/announcer/secondFloor.wav");
  thirdFloor = new SoundFile(this, "assets/sounds/announcer/thirdFloor.wav");
  doorsOpen = new SoundFile(this, "assets/sounds/announcer/doorsOpening.wav");
  doorsClose = new SoundFile(this, "assets/sounds/announcer/doorsClosing.wav");
  goingUpS = new SoundFile(this, "assets/sounds/announcer/goingUp.wav");
  goingDown = new SoundFile(this, "assets/sounds/announcer/goingDown.wav");
  music = new SoundFile(this, "assets/sounds/music.wav");
  alarm = new SoundFile(this, "assets/sounds/alarm.wav");
  phoneout = new SoundFile(this, "assets/sounds/phoneout.wav");
  
  
  bgImg = loadImage("assets/steel.jpg");
  litButton = loadImage("assets/button-lit.png");
  darkButton = loadImage("assets/button-dark.png");
  
  braile = loadFont("assets/Braille2.vlw");
  defaultFont = loadFont("assets/DejaVuSans-48.vlw");
  
  size(500,1000);
  floors = new Floor[4];
  buttons = new Button[8];
  
  
  buttons[0] = new Button(100,875,"B","B");
  floors[0] = new Floor("B",buttons[0], new String[]{"ATLC","Crossroads Studio","Instruction Labs 16 & 17"},basement);

  buttons[1] = new Button(100,820,"G","G");
  floors[1] = new Floor("G",buttons[1], new String[]{"Service Desks","Document Delivery"},groundFloor);
  
  buttons[2] = new Button(100,765,"2","#2");
  floors[2] = new Floor("2",buttons[2], new String[]{"Dynamic Media Services","3D Animation Lab","Anatomy Models","Makerspace","Virtual Reality Lab"},secondFloor);
  
  buttons[3] = new Button(100,710,"3","#3");
  floors[3] = new Floor("3",buttons[3], new String[]{"Administrative Offices","Room 309","Office of Pragmaticism"},thirdFloor);
  
  buttons[4] = new Button(250,875,"<|>","");
  buttons[4].tempButton = true;
  buttons[5] = new Button(320,875,">|<","");
  buttons[5].tempButton = true;
  
  buttons[6] = new Button(250,765,"Alarm","Alarm");
  buttons[6].tempButton = true;
  
  buttons[7] = new Button(250,820,"Help","Help");
  
  controller = new Controller();
  
  music.amp(0.1);
  music.loop();
}

void startController(){
  this.controller.run(floors);
}

void draw(){
  background(bgImg);
  for(int i = 0; i < buttons.length; i++){
    if(buttons[i].tempButton && buttons[i].lit){
      buttons[i].lit = buttons[i].checkClick();
    }
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
  
  textSize(22);
  fill(255, 255, 255);
  text("On this floor:",102,200); 
  for(int i =0; i < floors[this.controller.currentFloor].details.length; i++){
    text("· "+floors[this.controller.currentFloor].details[i],105,225+(24*i)); 
  }
  textSize(15);
  text(controller.statusText,105,520);
  textSize(22);
}

void mousePressed(){
  
  for(int i = 0; i < buttons.length; i++){
    if(buttons[i].checkClick() == true){
      buttons[i].lit = true;
      if(!this.controller.running){
         thread("startController");
      }
    }
  }
}
