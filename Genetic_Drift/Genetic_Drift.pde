/// Last Modified: September 30, 2020

/// Values you can change ///
int n = 10; 
int numRings = round(n/2.0);
int padding = 100;
int gapBetweenRings = 20; // Gap between adjacent square-shaped rings of cells
int frameRate = 7;


PFont f;
float cellSize;
String[][] cellsNow = new String[n][n]; 
String[][] cellsNext = new String[n][n];
String[] alleleChoices = {"A","a"}; // Genes that determine the cell's genotype 
                                    // The genotype determines if a cell is green or yellow
// "A" is the dominant allele while "a" is the recesive allele
// Each cell's genotype is a combination of two alleles (ex. "Aa", "aa", "AA")
// Genotypes with at least one "A" (dominant) allele produce a green cell (ex. "AA" or "Aa")
// Genotypes with two "a" (recessive) alleles produce yellow cell


float[] cellSizeExtension = new float[round(n/2.0)]; // How much each cell's width or height
                                                    // needs to be extended by to acommodate 
                                                    // the gap between the rings

float  startingX, startingY, endingX,endingY; 
// startingX --> x value of the left side of a given square-shaped ring
// startingY --> y value of the top side of a given square-shaped ring
// endingX --> x value of the right side of a given square-shaped ring
// endingY --> y value of the bottom side of a given square-shaped ring

RingColony[] ringList = new RingColony[numRings];

void setup () {  
 size(800,800);
 background(166,140,99);
 frameRate(frameRate);
 instructionText();
  
 computeCellSizeExtension();
 cellSize = (float) (height-2*padding-(n-1)*cellSizeExtension[0])/n;

 createRings();
 //setCellValuesRandomly();
   
 

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
  
  for (int i=round(n/2.0)-1; i>=0; i--) {
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

void instructionText() {
 f = createFont("Cambria",25);
 textFont(f); 
 fill(0);
 text("Each square-shaped ring represents an isolated colony of organisms",12,30);
 text("One cell = One organism",12,60);
 text("AA or Aa genotype = Green", 12,height-45);
 text("aa genotype = Yellow", 12, height-15);
}

void draw() {
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


/// Assigns each offspring cell a random spot (index) inside the colony ///

void shuffleNextGen(int startingIndex, int endingIndex, int constantIndex, String isRowOrColumnConstant ) {
  int r,c;
  for (int i=startingIndex; i<endingIndex; i++) {
     int x = round(random(startingIndex,endingIndex-1));

    if (isRowOrColumnConstant == "Row") {
      r = constantIndex;
      c = i;

    }
    else  {
      r = i;
      c = constantIndex;
    }
    
    String currentCell = cellsNext[r][c];
    
    if (isRowOrColumnConstant == "Row") {
      cellsNext[r][c] = cellsNext[r][x];
      cellsNext[r][x] = currentCell;
    }
    else {
     cellsNext[r][c] = cellsNext[x][c];
     cellsNext[x][c] = currentCell;

    }
     
  }  
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

void overWrite() {
     /// Overwrites current generation with its offspring
    for (int r=0; r<n; r++) {
      for (int c=0; c<n; c++) {
        cellsNow[r][c] = cellsNext[r][c]; 
      }
    } 
}
