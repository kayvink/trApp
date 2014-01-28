/*
For this week I made a drum sequencer focused on the music genre trap. It is made up out of
4 tracks. A kickdrum, open hihat, snare drum and clap track. It also comes with the cult
trap samples "Damn son, where'd you find this", an air horn and heys. I used the Maxim
library to work with audio and I got the sliders out of the GUI library. As far as I know both
are a product of the Goldsmiths coursera course which you can find 
here: https://class.coursera.org/digitalmedia-001/class . I found the logic needed to create 
a moving loop in the video Basic drum sequencer video out of week 6. I then expanded it by adding
for loops and creating a class for the Beat squares.
*/

// This is where all variables, arrays, sliders and the audio environment are created. 
// We will need an AudioPlayer for every different sound.
Maxim maxim;
PImage background;
PFont button;
boolean looping = true;
float tempoDivide;
float bpm;
float volume = 1;
int bpmShow;
int playHead;
int kckSeqPos;
int trackX;
int textY;

AudioPlayer kick;
AudioPlayer kick1;
AudioPlayer kick2;
AudioPlayer kick3;
AudioPlayer kick4;
AudioPlayer kick5;

AudioPlayer openHi;
AudioPlayer openHi1;
AudioPlayer openHi2;
AudioPlayer openHi3;
AudioPlayer openHi4;
AudioPlayer openHi5;


AudioPlayer snare;
AudioPlayer snare1;
AudioPlayer snare2;
AudioPlayer snare3;
AudioPlayer snare4;
AudioPlayer snare5;

AudioPlayer clap;
AudioPlayer damn;
AudioPlayer airHorn;
AudioPlayer hey;

Slider tempo;
Slider volumeControl;

int tempoLevel;

Slider kickSlider;
float kickLevel;

Slider snareSlider;
float snareLevel;

Slider openHiSlider;
float openHiLevel;

Beat[] kickTrack;
int kickX;
int kickY;
int bSide;
int TrackPos;


Beat[] openHiTrack;
int openHiX;
int openHiY;

Beat[] snareTrack;
int snareX;
int snareY;

Beat[] clapTrack;
int clapX;
int clapY;

Beat[] timeline;
int timelineX;
int timelineY;

void setup() {
  size(1024, 600);
  frameRate(30);
  
  // loadImage loads the image used for the background. You can find more on images in the learning processing book on page
  // 255.
  background = loadImage("Blur.jpg");

  // I used the playHead variable to keep track of how many frames of a second have passed. I will go into further
  // details later.
  playHead = 0;
  
  // This initiates the audio environment.
  maxim = new Maxim(this);

  // Here all the different audio files have to be loaded individually. Looping has to be set to false, because otherwise
  // audiofiles will keep looping in maxim. We want to only play every sound once.

  kick1 = maxim.loadFile("KickDrum0001.wav");
  kick1.setLooping(false);
  kick2 = maxim.loadFile("KickDrum0002.wav");
  kick2.setLooping(false);
  kick3 = maxim.loadFile("KickDrum0003.wav");
  kick3.setLooping(false);
  kick4 = maxim.loadFile("KickDrum0004.wav");
  kick4.setLooping(false);
  kick5 = maxim.loadFile("KickDrum0005.wav");
  kick5.setLooping(false);
  openHi1 = maxim.loadFile("Open Hihat0003.wav");
  openHi1.setLooping(false);
  openHi2 = maxim.loadFile("Open Hihat0004.wav");
  openHi2.setLooping(false);
  openHi3 = maxim.loadFile("Open Hihat0005.wav");
  openHi3.setLooping(false);
  openHi4 = maxim.loadFile("Open Hihat0006.wav");
  openHi4.setLooping(false);
  openHi5 = maxim.loadFile("Open Hihat0007.wav");
  openHi5.setLooping(false);
  snare1 = maxim.loadFile("SnareDrum0041.wav");
  snare1.setLooping(false);
  snare2 = maxim.loadFile("SnareDrum0042.wav");
  snare2.setLooping(false);
  snare3 = maxim.loadFile("SnareDrum0043.wav");
  snare3.setLooping(false);
  snare4 = maxim.loadFile("SnareDrum0044.wav");
  snare4.setLooping(false);
  snare5 = maxim.loadFile("SnareDrum0045.wav");
  snare5.setLooping(false);
  clap = maxim.loadFile("clap.wav");
  clap.setLooping(false);
  damn = maxim.loadFile("DAMN SON!.wav");
  damn.setLooping(false);
  airHorn = maxim.loadFile("air horn.wav");
  airHorn.setLooping(false);
  hey = maxim.loadFile("hey.wav");
  hey.setLooping(false);
  button = loadFont("Damn.vlw");
  
  // This creates a slider that will allow us to control the tempo.
  tempo = new Slider("", 8, 0, 15, 375, 100, 400, 100, HORIZONTAL);
  
// This creates a slider that will allow us to control the volume
  volumeControl = new Slider("Volume", 0.5, 0, 1, 925, 80, 50, 190, UPWARDS);
  

  
  
  // This slider lets us control the amount of decau on the kick.
  kickSlider = new Slider("Kick\nDecay", 50, 1, 50, 50, 100, 250, 50, HORIZONTAL);

  // This initiates the array that forms the kick track. It's and array of 16 beats
  kickTrack = new Beat[16];
  kickX = 100;
  kickY = int((height/2)+50);
  bSide = 50;
  TrackPos = 15;

  // This for loop loops through the array and creates a new Beat object for every spot of the array. Find more information
  // on page 87 of learning processing.  "\n" creates a line break.
  for (int i = 0; i < 16; i++) {
    kickTrack[i] = new Beat(kickX, kickY, bSide);
    kickX += bSide;
  }

  // This does the same as the kick slider, but for the open hi hat.
  openHiSlider = new Slider("O Hi\nDecay", 50, 1, 50, 50, 160, 250, 50, HORIZONTAL);
  
  // Again, this is the same as the kick array.
  openHiTrack = new Beat[16];
  openHiX = 100;
  openHiY = (kickY+bSide);

  for (int i = 0; i < 16; i++) {
    openHiTrack[i] = new Beat(openHiX, openHiY, bSide);
    openHiX += bSide;
  }
  
  // The same as the kick and openhi sliders.
  snareSlider = new Slider("Snare\nDecay", 50, 1, 50, 50, 220, 250, 50, HORIZONTAL);
  
  // The same as the kick and open hi arrays.
  snareTrack = new Beat[16];
  snareX = 100;
  snareY = (openHiY+bSide);

  for(int i = 0; i < 16; i++) {
    snareTrack[i] = new Beat(snareX, snareY, bSide);
    snareX += bSide;
  }
  
  // Same
  clapTrack = new Beat[16];
  clapX = 100;
  clapY = (snareY+bSide);

  for(int i = 0; i < 16; i++) {
    clapTrack[i] = new Beat(clapX, clapY, bSide);
    clapX += bSide;
  }
  
  //Same
  timeline = new Beat[16];
  timelineX = 100;
  timelineY = 175;
  
  for (int i = 0; i < 16; i++){
    timeline[i] = new Beat(timelineX, timelineY, bSide);
    timelineX += bSide;
  }


  
}

void draw() {
  // Every frame 1 is added to the playHead, this means the playhead keeps track of the amount of frames that have passed.
  playHead ++;
  
  // This draws the images, be placing it above all the other code, it functions as a background.
  image(background, 0, 0);


  // By running a for loop through all the arrays I can make them display the objects defined inside and make them function.
  // .dsplay and .beatswitch are both methods that exist whitin the Beat class you can find in the other tab.
  for (int i = 0; i < 16; i++) {
     kickTrack[i].display();
    openHiTrack[i].display();
    snareTrack[i].display();
    clapTrack[i].display();
    timeline[i].timelineDisplay();
    if(i>0) timeline[i-1].timelineDisplay();
  }
  
  // This creates the descriptive texts in front of the tracks.
  fill(255);
  textY = (kickY+35);
  textFont (button, 30);
  text("Kick", 25, textY);
  textFont (button, 30);
  text("O Hi", 25, textY+50);
  textFont (button, 30);
  text("Snare", 8, textY+100);
  textFont (button, 30);
  text("Clap", 23, textY+150);  

  // These methods make the decay sliders visible, I added textFont to make the font a different size form the sample buttons.
  textFont (button, 21);
  kickSlider.display();
  openHiSlider.display();
  snareSlider.display();
  volumeControl.display();
  
  // This makes the tempo slider visible. I calculated the bpm as (frameRate)/(playHead divider)*60. Say you have 30 
  // frames per second and you have one beat after every 30 frames (deviding by 30). You would have 1 beat per second,
  // = 60 beats per minute. If you multiple 60 by the frameRate/divide ratio you get the bpm.
  textFont (button, 30);
  text(bpmShow + " BPM ", 490, 80);  
  tempo.display();
  tempoLevel = int(tempo.get());
  tempoDivide = (2*(23-tempoLevel));
  bpm = ((30/tempoDivide)*60);
  bpmShow = int(bpm);

  // This calls the update function which can be found lower down.
  Update();

  // .get() returns the value given by in this case a slider. Based on that value the if statement decides which file to play
  // every file has a different amount of decay.
  float kickLevel = kickSlider.get();
//  println("kickLevel is" + kickLevel);
  if (kickLevel <= 10){
    kick = kick1;
  }else if (kickLevel <= 20){
    kick = kick2;
  }else if (kickLevel <= 30){
    kick = kick3;
  }else if (kickLevel <= 40){
    kick = kick4;
  }else if (kickLevel <= 50){
    kick = kick5;
  }
  
  float openHiLevel = openHiSlider.get();
//  println("openHiLevel is" + openHiLevel);
  if (openHiLevel <= 10){
    openHi = openHi1;
  }else if (openHiLevel <= 20){
    openHi = openHi2;
  }else if (openHiLevel <= 30){
    openHi = openHi3;
  }else if (openHiLevel <= 40){
    openHi = openHi4;
  }else if (openHiLevel <= 50){
    openHi = openHi5;
  }  
  
 
  float snareLevel = snareSlider.get();
//  println("snareLevel is" + snareLevel);
  if (snareLevel <= 10){
    snare = snare1;
  }else if (snareLevel <= 20){
    snare = snare2;
  }else if (snareLevel <= 30){
    snare = snare3;
  }else if (snareLevel <= 40){
    snare = snare4;
  }else if (snareLevel <= 50){
    snare = snare5;
  }
  
  // These draw the sample buttons.
  stroke(255);
  if(mouseX >= 800 && mouseX <= 800+100 && mouseY >= 100 && mouseY <= 150){
    fill(175);
    if(mousePressed){
    fill(60, 60, 100);
    }
  }else{
    fill(125);
  }
  rect(800, 100, 100, 50);
  fill(255);
  textFont (button, 21);
  text("Damn son", 803, 135);
  
  if(mouseX >= 800 && mouseX <= 800+100 && mouseY >= 160 && mouseY <= 210){
    fill(175);
    if(mousePressed){
    fill(60, 60, 100);
    }
  } else{
    fill(125);
  }
  rect(800, 160, 100, 50);
  fill(255);
  textFont (button, 21);
  text("Air Horn", 810, 195);
  
  if(mouseX >= 800 && mouseX <= 800+100 && mouseY >= 220 && mouseY <= 270){
    fill(175);
    if(mousePressed){
    fill(60, 60, 100);
    }
  } else{
    fill(125);
  }
  rect(800, 220, 100, 50);
  fill(255);
  textFont (button, 21);
  text("Hey", 835, 255);
  
  if(mouseX >= 925 && mouseX <= 925+75 && mouseY >= ((snareY-100)) && mouseY <= ((snareY-100)+bSide)){
    fill(175);
    if(mousePressed){
      fill(60, 60, 100);
      reset();
    }
  } else{
    fill(125);
  }
  rect(925, (snareY-100), 75, 50);
  fill(255);
  textFont (button, 21);
  text("Reset", 940, 385);
  
  if(mouseX >= 925 && mouseX <= 925+75 && mouseY >= (snareY+bSide) && mouseY <= (snareY+bSide)+50){
    fill(175);
    if(mousePressed){
      looping = !looping;
      fill(60, 60, 100);
    }
  } else{
    fill(125);
  }
  rect(925, (snareY+bSide), 75, 50);
  fill(255);
  textFont (button, 21);
  text("Start", 940, 535);
  
  volume = volumeControl.get();
  println(volume);
  kick.masterVolume = volume;
  openHi.masterVolume = volume;
  snare.masterVolume = volume;
  clap.masterVolume = volume;

}

void Update() {
  // When playHead is divided by tempoDivide and rest amount is 0, this if statement resets the playHead. After one 
  // cycle has passed the loop continues to the next beat (TrackPos ++). By changing the tempoDivide you can change 
  // the tempo (as done in the bpm calculation). By clicking any beat you change the switchState boolean to true. If
  // the cycle reaches that position and the boolean is set to true it will play the chosen audio file. Many if
  // if statemens are needed becaus you need to be able to play multiple sounds at a time.
  if (playHead % tempoDivide == 0) {
    if (looping == true){
      TrackPos ++;
      if (TrackPos == kickTrack.length) {
        TrackPos = 0;
      }
      if (kickTrack[(TrackPos)].switchState == true) {
        kick.cue(0);
        kick.play();
      }    
      if (openHiTrack[(TrackPos)].switchState == true) {
        openHi.cue(0);
        openHi.play();
      }
      if (snareTrack[(TrackPos)].switchState == true) {
        snare.cue(0);
        snare.play();
      }
      if (clapTrack[(TrackPos)].switchState == true) {
        clap.cue(0);
        clap.play();
      }
      
      // This sets the current timeline positions switchState to true, thus making it red. Unfortunately I haven't found out 
      // how to make it go back to grey again. This would be an addition in a update.
          timeline[TrackPos].switchState();
    if(TrackPos > 0){
      timeline[TrackPos - 1].switchState();
    }
    if(TrackPos == 0 && timeline[15].switchState == true) {
      timeline[15].switchState();}
      // println("beat pos " + TrackPos);
    }
  }
}

void mousePressed(){
  
  
  // These if statements check whether the mouse is over any of the sample buttons when the mouse is pressed.
  if(mouseX >= 800 && mouseX <= 800+100 && mouseY >= 100 && mouseY <= 150){
  damn.cue(0);
  damn.play();
  }
  if(mouseX >= 800 && mouseX <= 800+100 && mouseY >= 160 && mouseY <= 210){
  airHorn.cue(0);
  airHorn.play();
  }
  if(mouseX >= 800 && mouseX <= 800+100 && mouseY >= 220 && mouseY <= 270){
  hey.cue(0);
  hey.play();
  }
  for (int i = 0; i < 16; i++) {
    kickTrack[i].beatSwitch();
    openHiTrack[i].beatSwitch();
    snareTrack[i].beatSwitch();
    clapTrack[i].beatSwitch();
  }
}

// These methods make it possible to move the sliders around.
void mouseReleased() {
  kickSlider.mouseReleased();
  snareSlider.mouseReleased();
  openHiSlider.mouseReleased();
  tempo.mouseReleased();
  volumeControl.mouseReleased();
}

void reset(){
  for(int i = 0; i < 16; i++){
    kickTrack[i].switchState = false;
    openHiTrack[i].switchState = false;
    snareTrack[i].switchState = false;
    clapTrack[i].switchState = false;    
    timeline[i].switchState = false;
  } 
  TrackPos = 15;

}


