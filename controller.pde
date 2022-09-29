public class Controller{
   public Boolean goingUp = null;
   int currentFloor = 0;
   public int direction = 0;
   public boolean running = false;
   // 0 = none 1 = up 2 = down
   public String statusText = "";
   
   void run(Floor[] floors){
     running = true;
     while(true){
        
       if(buttons[6].lit){
        alarm.loop();
        while(buttons[6].lit){
         delay(2); 
        }
        alarm.stop();
      }
      
      if(buttons[7].lit){
        music.stop();
        this.statusText = "Dialing emergency services....";
        phoneout.play();
        delay(16000);
        this.statusText = "Unable to reach emergency services.";
        delay(2000);
        this.statusText = "";
        buttons[7].lit = false;
        music.loop();
      }
       
       
      if(buttons[4].lit){
        print("\nOpening doors");
        this.statusText = "Holding Open Doors";
        doorsOpen.play();
        while(buttons[4].lit){
         delay(2); 
        }
        this.statusText = "";
        print("\nClosing doors");
        doorsClose.play();
      }
      
       
       
      boolean demandAbove = false;
      boolean demandBelow = false;
      for(int i = 0; i < floors.length; i++){
        if(floors[i].button.lit){
          if(i < currentFloor){
            demandBelow = true;
          }else if(i > currentFloor){
            demandAbove = true;
          }else{
            floors[i].button.lit = false;
          }
        }
      }
      
      if(!demandAbove && !demandBelow){
        running = false;
        direction = 0;
        break;
      }
      
      if(direction == 1){
        if(demandAbove == false && demandBelow == true){
          direction = 2; 
          goingDown.play();
          print("\nGoing down");
        }
      }else if(direction == 2){
        if(demandAbove == true && demandBelow == false){
          direction = 1; 
          goingUpS.play();
          print("\nGoing Up");
        }
      }else if(direction == 0){
        if(demandAbove){
          direction = 1;
          print("\nGoing Up");
          goingUpS.play();
        }else if(demandBelow){
          direction = 2;
          print("\nGoing Down");
          goingDown.play();
        }
      }
      
      
      if(direction != 0){
        if(direction == 1){
          delay(2000);
          currentFloor = currentFloor + 1;
        }else if(direction == 2){
          delay(2000);
          currentFloor = currentFloor - 1;
        }
      }
      if(floors[currentFloor].button.lit){
        floors[currentFloor].arrive();
        print("\nOpening doors");
        delay(1200);
        doorsOpen.play();
        delay(6000);
        if(!buttons[4].lit){
          print("\nClosing doors");
          doorsClose.play();
        }else{
          while(buttons[4].lit){
           delay(2); 
          }
          print("\nClosing doors");
          doorsClose.play();
        }
        delay(1200);
      }
     }
   }
}
