public class Floor{
  String text;
  boolean selected = false;
  Button button;
  String[] details;
  SoundFile announcer;
  
  Floor(String Text, Button Button, String[] details, SoundFile announcer){
    this.text = Text;
    this.button = Button;
    this.details = details;
    this.announcer = announcer;
  }
  
  void arrive(){
    announcer.play();
    this.button.lit = false;
    this.selected = false;
  }
}
