int scale = 2; // The size that the individual squares will be drawn at
int speed = 100; // How fast the program loops 
int setPointCount = 3; // How many 'set points' there are (5 is weird)
int limit = 7000; // How much detail can be drawn before resetting 
int pCount = 0; // Iterates through every loop of the program
float interpolationAmount = 0.5; // How much to interpolate by (0.75 is interesting)

PVector generatedPoint; // Vector keeping track of where to draw the current point
PVector[] setPoints; // An array of 'set point' vectors

// Generate a new array of set points
PVector[] genPoints(PVector[] array, int arraySize){
  for(int i = 0; i < arraySize; i++){
    array[i] = new PVector(floor(random(width)), floor(random(height)));
  }
  return array;
}

// Called to reset everything (redraws background, empties arrays etc)
void reset(){
  int randR = floor(random(255));
  int randG = floor(random(50, 100));
  int randB= floor(random(100, 200));
  background(255 - randR, 255 - randG, 255 - randB);
  fill(randR, randG, randB);
  setPoints = new PVector[setPointCount];
  setPoints = genPoints(setPoints, setPointCount);
  generatedPoint = new PVector(0, 0);
  pCount = 0;
}

// Setting up the screen size and initialising everything with the reset function
void setup(){
  size(800, 800);
  noStroke();
  reset();
}

void draw(){
  for(int i = 0; i < speed; i++){
    pCount++; // Iterate the loop count
    int r = floor(random(setPointCount));
    for(int j = 0; j < setPointCount; j++){
      if(r == j){
        generatedPoint.x = lerp(generatedPoint.x, setPoints[j].x, interpolationAmount); // Interpolate the next point
        generatedPoint.y = lerp(generatedPoint.y, setPoints[j].y, interpolationAmount); 
      }
      rect(generatedPoint.x, generatedPoint.y, scale, scale); // Draw the point
      }
      if(pCount > limit) reset(); // Reset once there have been enough iterations (declared as 'limit')
  }
}