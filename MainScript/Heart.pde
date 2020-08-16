class Heart{
  int nbrVertices;
  FloatList xInitialVertices;
  FloatList yInitialVertices;
  FloatList xVertices;
  FloatList yVertices;
  
  float xOffset;
  float yOffset;
  float zOffset;
  
  float time;
  
  Heart(int v){
    this.nbrVertices = v;
    
    this.xOffset = random(10000);
    this.yOffset = random(10000);
    this.zOffset = random(10000);
    
    this.time = 0;
    
    this.initialize();
    this.update();
  }
  
  void initialize(){
    this.xInitialVertices = new FloatList();
    this.yInitialVertices = new FloatList();
    
    float mini = -10;
    float maxi = 10;
    float u = mini;
    float step = (maxi-mini)*2/nbrVertices;
    
    for(int i=0; i<nbrVertices/2; i++){
      this.xInitialVertices.append(this.x(u));
      this.yInitialVertices.append(this.y(u));
      u += step;
    }
    /*for(int i=this.xInitialVertices.size()-1; i>=0; i--){
      this.xInitialVertices.append(-this.xInitialVertices.get(i));
      this.yInitialVertices.append(this.yInitialVertices.get(i));
    }*/
  }
  
  float x(float a){
    float result;
    result = pow(1-pow(a, 2),3)/(1+pow(a, 2));
    return pow(80000*result, 0.5);
  }
  
  float y(float a){
    float result;
    result = 4*a/(1+pow(a, 2))-pow(a, 2);
    return -100*result;
  }
  
  void update(){
    this.xVertices = new FloatList();
    this.yVertices = new FloatList();
    
    float currX;
    float currY;
    float currRadius;
    float currAngle;
    float diffRadius;
    float yCenter = 0.25*cos(this.time);
    float zCenter = 0.25*cos(this.time - PI/2);
    for(int i=0; i<this.xInitialVertices.size(); i++){
      currX = this.xInitialVertices.get(i);
      currY = this.yInitialVertices.get(i);
      
      currRadius = this.getRadius(currX, currY);
      currAngle = this.getAngle(currX, currY);
      
      diffRadius = map(noise(perlinCoeff*currX+xOffset, 
                              perlinCoeff*currY+yCenter+yOffset,
                              zCenter+zOffset), 
                       0, 1, -amplitude, amplitude);
        this.xVertices.append((currRadius+diffRadius)*cos(currAngle));
        this.yVertices.append((currRadius+diffRadius)*sin(currAngle));
    }
    for(int i=this.xVertices.size()-1; i>=0; i--){
      this.xVertices.append(-this.xVertices.get(i));
      this.yVertices.append(this.yVertices.get(i));
    }
    
    this.time += perlinAnim;
    if(this.time >= TWO_PI) this.time = 0;
  }
  
  float getRadius(float x, float y){
    float radius;
    radius = pow(pow(x,2) + pow(y, 2), 0.5);
    return radius;
  }
  
  float getAngle(float x, float y){
    float angle;
    angle = acos(abs(x)/getRadius(x, y));
    if(x>0 && y<0) angle = -angle;
    if(x<0 && y>0) angle += PI/2;
    if(x<0 && y<0) angle += PI;
    return angle;
  }
  
  void display(){
    noFill();
    beginShape();
    for(int i=0; i<this.xVertices.size(); i++){
      vertex(this.xVertices.get(i), this.yVertices.get(i));
    }
    endShape();
  }
  
  void display_ini(){
    noFill();
    beginShape();
    for(int i=0; i<this.xInitialVertices.size(); i++){
      vertex(this.xInitialVertices.get(i), this.yInitialVertices.get(i));
    }
    endShape();
  }
}
