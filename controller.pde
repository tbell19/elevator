public class Controller{
   public Boolean goingUp = null;
   int currentFloor = 0;
   public int direction = 0;
   public boolean running = false;
   // 0 = none 1 = up 2 = down
   
   void run(Floor[] floors){
     running = true;
     while(true){
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
          print("\nGoing down");
        }
      }else if(direction == 2){
        if(demandAbove == true && demandBelow == false){
          direction = 1; 
          print("\nGoing Up");
        }
      }else if(direction == 0){
        if(demandAbove){
          direction = 1;
          print("\nGoing Up");
        }else if(demandBelow){
          direction = 2;
          print("\nGoing Down");
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
        print("\nOpening doors");
        doorsOpen.play();
        floors[currentFloor].button.lit = false;
        delay(5000);
        print("\nClosing doors");
      }
     }
   }
}
