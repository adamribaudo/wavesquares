import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

float lineWidth = 20;
int rows = 20;
int cols = 20;
float waveX = 0;
float waveY = 0;
Ani moveAni;
Ani waveXAni;
Ani waveYAni;

void setup()
{
  size(450, 450, P3D);
  background(0);
  fill(255);
  stroke(255);
  strokeWeight(2);
 
  waveX = (width/6);
  Ani.init(this);
  waveXAni.setDefaultEasing(Ani.QUART_IN_OUT);
  waveXAni = new Ani(this, 1.7, "waveX", width-(width/6));
  waveXAni.setPlayMode(Ani.YOYO);
  waveXAni.seek(.5);
  waveXAni.repeat();
  
  waveY = (height/6);
  waveYAni.setDefaultEasing(Ani.QUART_IN_OUT);
  waveYAni = new Ani(this, 1.7, "waveY", height-(height/6));
  waveYAni.setPlayMode(Ani.YOYO);
  waveYAni.repeat();

  colorMode(HSB, 1);
}

void draw()
{
  
  background(0);
 
 //Draw grid of boxes
  for (int c =0; c<cols; c++)
  {
    pushMatrix();
    translate(60* c, 0);
    for (int r=0; r<rows; r++)
    {
      pushMatrix();
      int offset =0;
      //offset every other row 30 pixels to the right 
      if (r%2==0)
      {
        offset = 30;
        translate(offset, 0);
    }
      translate(0, r*30);
      drawBox(r*30, 60* c + offset);
      popMatrix();
    }
    popMatrix();
  }
}

void drawBox(int y, int x)
{
  
  //Calculate X and Y movement amounts based on sinusoidal waveforms from Ani library 
  float moveAmountY;
  float moveAmountX;
  float moveAmount;
  
  float dropOff = 40;
  float maxMoveAmount = 10;
  float distanceY = abs(y - waveY);
  float invDistanceY = 1/(distanceY/dropOff);
  if(invDistanceY > 1)invDistanceY = 1;
  moveAmountY = (1-invDistanceY);
  
  float distanceX = abs(x - waveX);
  float invDistanceX = 1/(distanceX/dropOff);
  if(invDistanceX > 1)invDistanceX = 1;
  moveAmountX = (1-invDistanceX);
  
  //Final movement amoutn is the distance between the X and Y movement amounts
  moveAmount = maxMoveAmount * abs(moveAmountY - moveAmountX);
  
  //Change line color based on movement amount
  stroke(moveAmount/70+.1, 1, 1);
  
  //Draw lines
  pushMatrix();
  translate(0, moveAmount);
  line(-lineWidth/2, lineWidth/2, lineWidth/2, lineWidth/2);
  popMatrix();

  pushMatrix();
  translate(-moveAmount, 0); 
  line(-lineWidth/2, lineWidth/2, -lineWidth/2, -lineWidth/2);
  popMatrix();

  pushMatrix();
  translate(0, -moveAmount); 
  line(-lineWidth/2, -lineWidth/2, lineWidth/2, -lineWidth/2);
  popMatrix();

  pushMatrix();
  translate(moveAmount, 0); 
  line(lineWidth/2, -lineWidth/2, lineWidth/2, lineWidth/2);
  popMatrix();
}

