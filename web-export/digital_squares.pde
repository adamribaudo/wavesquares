import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

float lineWidth = 20;
float moveAmount = 0;
int rows = 20;
int cols = 20;
float waveX = 0;
float waveY = 0;
Ani moveAni;
Ani waveXAni;
Ani waveYAni;

void setup()
{
  size(600, 600, P3D);
  background(0);
  fill(255);
  stroke(255);
  strokeWeight(2);
 
  Ani.init(this);
  waveXAni.setDefaultEasing(Ani.SINE_IN_OUT);
  waveXAni = new Ani(this, 2, "waveX", width);
  waveXAni.setPlayMode(Ani.YOYO);
  waveXAni.repeat();
  
  waveYAni.setDefaultEasing(Ani.SINE_IN_OUT);
  waveYAni = new Ani(this, 2, "waveY", height);
  waveYAni.setPlayMode(Ani.YOYO);
  waveYAni.repeat();
  
  //moveAni.setDefaultEasing(Ani.SINE_IN_OUT);
  //moveAni = new Ani(this, 1, "moveAmount", 1);
  //moveAni.setPlayMode(Ani.YOYO);
  //moveAni.repeat();
  //moveAni.pause();

  colorMode(HSB, 1);
}

void draw()
{
  
  background(0);
  //translate(width/2, height/2);
  
  for (int c =0; c<cols; c++)
  {
    pushMatrix();
    translate(60* c, 0);
    for (int r=0; r<rows; r++)
    {
      pushMatrix();
      int x =0;
      if (r%2==0)
      {
        translate(30, 0);
        x = 30;
    }
      translate(0, r*30);
      drawBox(moveAmount, r*30, 60* c + x);
      popMatrix();
    }
    popMatrix();
  }
}



void drawBox(float moveAmount, int y, int x)
{
  
  
  //moveAmount = 10 * (abs(row - rowWave)/rows);
  
  //calculat distance between square and point
  //float distance = sqrt(pow((float)abs(y - waveY), 2) + pow((float)abs(x - waveX), 2));
  float distance = abs(y - waveY);
  
  float invDistance = 1/(distance/70);
  if(invDistance > 1)invDistance = 1;
  
  if(y == 30 && x == 60)
  println(invDistance);
  
  moveAmount = 10 * (1 - invDistance);
  stroke(moveAmount/70+.1, 1, 1);
    
  /*  
  if(row == int(((float)mouseY/height)*rows) && col == int(((float)mouseX/width)*cols))
  println("row = " + row + ", col = " + col + ", moveAmt = " + moveAmount);
  */
  
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


