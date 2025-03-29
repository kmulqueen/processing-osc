import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
float amplitude = 0;
float smoothedAmplitude = 0;
float smoothingFactor = 0.2; // Lower = smoother, higher = more responsive

void setup() {
  size(400,400);
  frameRate(30);
  
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12001);
}

void draw() {
  background(0);
  
  // Visualize amplitude
  float diameter = map(smoothedAmplitude, 0, 127, 10, 300);
  fill(255,0,0);
  ellipse(width/2, height/2, diameter, diameter);
  
  // Display value of amplitude
  fill(255);
  textAlign(CENTER);
  text("Amplitude: " + smoothedAmplitude, width/2, height - 20);
}

void oscEvent(OscMessage myMessage) {
  if (myMessage.checkAddrPattern("/amplitude")) {
    amplitude = myMessage.get(0).floatValue();
    smoothedAmplitude = smoothedAmplitude * (1-smoothingFactor) + amplitude * smoothingFactor;
  }
}
