/// v1.1 Modified December 30, 2020
import g4p_controls.*;

int n; 
int numRings = 10;
int padding = 100;
float gapBetweenRings; // Gap between adjacent square-shaped rings of cells
int frameRate = 5;

PFont f;
String[] alleleChoices = {"A","a"}; 
float cellSize;
Boolean fixation = false;
Boolean paused;
Boolean reset;
float[] cellSizeExtension;
RingColony[] ringList;


void setup () {  
 size(800,800);
 createGUI();
 reset();
}

void reset() {
  frameRate(frameRate);
  background(166,140,99);
  gapBetweenRings = -1.5*sqrt(numRings) + 12;
  if (numRings%2==0)
    n = numRings*2-1;
  else
    n = numRings*2;
 cellSizeExtension = new float[numRings]; 
 computeCellSizeExtension();
 cellSize = (float) (height-2*padding-(n-1)*cellSizeExtension[0])/n;
 ringList = new RingColony[numRings];
 createRings();
 paused = false;
 reset = false;
 pausedProcedure("normal");
}

/// Calculates how much the width or height of each square cell needs to be extended by 
/// to accomodate the gap between the rings.
void computeCellSizeExtension(){
  int ringSpan; // Length/width of a square-shaped ring (in terms of cells)
  if (n%2==0)
    ringSpan = 2;
  else
    ringSpan = 1;  
  float extension = 0;
  
  for (int i=numRings-1; i>=0; i--) {
   cellSizeExtension[i] = extension;
   ringSpan+=2;
   extension = ( (ringSpan-3)*cellSizeExtension[i] + 2*gapBetweenRings ) / float(ringSpan-1); 
   /// ^ a formula for calculating how much each cell needs to be extended by
  } 
}

void createRings() {
  int startingRow = 0;
  int startingCol = 0;
  int ringSize = n;
  
  for (int i=0; i<numRings; i++) { // For each square-shaped ring on the grid
    ringList[i] = new RingColony(i,startingRow, startingCol, ringSize);   
    ringList[i].populateRing();
    startingRow += 1;
    startingCol+=1;
    ringSize -= 2;
  }  
}


void draw() {
  fill(166,140,99);
  noStroke();
  rect(100,100,600,600);
  for (int i=0; i<numRings; i++) {  
    int ringPopulation = ringList[i].cells.size();
    for (int j=0; j<ringPopulation; j++) {
      ringList[i].cells.get(j).drawCell();
    }
    updateCellsWithNextGen(i);    
  }  
}


void updateCellsWithNextGen(int i) {
  int ringPopulation = ringList[i].cells.size();
  for (int c=0; c<ringPopulation; c++) {   
    if (c<ringPopulation-2) 
      ringList[i].cells.get(c).genotype = computeOffspring( ringList[i].cells.get(c).genotype, ringList[i].cells.get(c+1).genotype);
    else
      ringList[i].cells.get(c).genotype = computeOffspring( ringList[i].cells.get(c).genotype, ringList[i].cells.get(0).genotype);     
    } 
  shuffleNextGen(i);
}

/// Assigns each offspring cell a random spot (index) inside the colony ///
void shuffleNextGen(int i) {
  int ringPopulation = ringList[i].cells.size();
  int newIndex;
  String copy;
  for (int c=0; c<ringPopulation; c++) {
    newIndex = round(random(0,ringPopulation-1));
    copy = ringList[i].cells.get(c).genotype;
    ringList[i].cells.get(c).genotype = ringList[i].cells.get(newIndex).genotype;
    ringList[i].cells.get(newIndex).genotype = copy;
  }
}
 
/// Computes the cells colour based on its genotype ///
int[] getColour(String genotype) {
  int[] colour = new int[3];

  if (genotype.indexOf("A")==-1) {
    //Yellow
    colour[0] = 238;
    colour[1] = 225;
    colour[2] = 32;
  }
  else{
    //Green
    colour[0] = 80;
    colour[1] = 186;
    colour[2] = 46;
  }
  return colour;
}

String setInitialValues() { // assigns a random genotype to the first generation of cells.
  String allele1 = alleleChoices[round(random(1))];
  String allele2 = alleleChoices[round(random(1))];
  return allele1 + allele2;
}


/// Computes the offspring cell's genotype ///
String computeOffspring(String p1, String p2) {
  String[] possibilities = computePossibilities(p1,p2);
  String offspring = possibilities[ round(random(3)) ];
  
  return offspring;
}


/// Computes the possible genotypes that can be produced
String[] computePossibilities(String p1, String p2) {
  String[] listP1 = p1.split("");
  String[] listP2 = p2.split("");
  
  String[] possibilities = new String[4];
  
  possibilities[0] = listP1[0] + listP2[0];
  possibilities[1] = listP1[0] + listP2[1];
  possibilities[2] = listP1[1] + listP2[0];
  possibilities[3] = listP1[1] + listP2[1];
  
  return possibilities;
}

void pausedProcedure(String instruction) {
  if (instruction == "normal") {
    if (paused) {
      pauseButton.setText("Resume");
      pauseButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
      noLoop();
    }
    else {
      pauseButton.setText("Pause");
      pauseButton.setLocalColorScheme(GCScheme.RED_SCHEME);
      loop();
    }
  }
  else {
    reset(); 
  }
}
