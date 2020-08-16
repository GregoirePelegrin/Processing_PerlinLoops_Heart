float amplitude;
float perlinAnim;
float perlinCoeff;

Heart heart;

void setup() {
  size(600, 600);
  frameRate(50);
  background(255);
  stroke(0, 5);
  
  amplitude = 30;
  perlinAnim = 0.05;
  perlinCoeff = 0.01;
  
  heart = new Heart(100000);
}

void draw() {
  translate(width/2, height/2-40);
  
  heart.update();
  heart.display();
}
