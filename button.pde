public class Button{
  int x;
  int y;
  public boolean lit = false;
  String text;
  String brailleText;
  public boolean tempButton = false; //whether or not the button should only stay lit while pressed
  
  
  public Button(int x,int y,String text,String brailleText){
    this.x = x;
    this.y = y;
    this.text = text;
    this.brailleText = brailleText;
  }
  
  void draw(){
    
    if(this.brailleText != ""){
      textFont(braile, 32);
      fill(0, 0, 0);
      ellipse(x+40+textWidth(this.brailleText),y+25,49,49);
      rect(x+20,y,textWidth(this.brailleText)+15,49);
      fill(255,255,255);
      text(this.brailleText, x+55, y+36); 
    }
    textFont(defaultFont, 32);
    fill(0, 0, 0);
    
    
    

    if(lit){
      image(litButton,this.x,this.y,buttonSize,buttonSize);
    }else{
      image(darkButton,this.x,this.y,buttonSize,buttonSize);
    }
    textSize(40-(this.text.length()*5));
    if(this.lit){
      fill(0, 255, 0);
    }else{
      fill(0, 0, 0);
    }
    
    text(this.text, x+25-(textWidth(this.text)/2), y+36); 



  }
  
  boolean checkClick(){
    float disX = this.x+buttonSize/2 - mouseX;
    float disY = this.y+buttonSize/2 - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < buttonSize/2 && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
