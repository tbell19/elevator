public class Floor{
  String text;
  boolean selected = false;
  Button button;
  String[] details;
  
  Floor(String Text, Button Button, String[] details){
    this.text = Text;
    this.button = Button;
    this.details = details;
  }
  
  void arrive(){
    this.button.lit = false;
    this.selected = false;
  }
}
