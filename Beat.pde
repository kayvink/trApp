// In this tab I created a class which I used to create all the different beat options. You can use a class when all the 
// objects will have the same structure. They can have different variables though.
class Beat {
  color c;
  int beatX;
  int beatY;
  int bSide;
  boolean switchState;
  
  
  Beat(int _beatX, int _beatY, int _bSide) {
      beatX = _beatX;
      beatY = _beatY;
      bSide = _bSide;
      switchState = false;
  }

  void display() {
    if (switchState == false) {
      stroke(255);
      if( mouseX >= beatX && mouseX <= beatX+bSide 
        && mouseY >= beatY && mouseY <= beatY+bSide ){
          fill(175);
        } else{
            fill(125);
        }
      rect(beatX, beatY, bSide, bSide);
    } else if(switchState == true){ 
      stroke(255);
      fill(200, 0, 0);
      rect(beatX, beatY, bSide, bSide);
    }

  }

  // This draws the timeline, I unfortunately haven't found out to get it to reset the colour after a position has passed.
  void timelineDisplay() {
    if (switchState == false) {
      stroke(255);
      fill(125);
      rect(beatX, beatY+140, bSide, (bSide/2));
      }
    if(switchState == true){ 
      stroke(255);
      fill(200, 0, 0);
      rect(beatX, beatY+140, bSide, (bSide/2));
    }


  }  
  
  // This changes the switchState of a pressed beat button on the tracks. 
  void beatSwitch() {
        if( mouseX >= beatX && mouseX <= beatX+bSide 
        && mouseY >= beatY && mouseY <= beatY+bSide ){
            switchState();
            //println("switchState is" + switchState);
        }
  }
  void switchState() {
    if(switchState) {
      switchState = false;
    } else if (!switchState) {
      switchState = true;
    }
  }
  
  

}
