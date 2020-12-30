class Cell {
 
  PVector coords;
  String genotype;
  float cellSizeExtension;
  String orientation;
  int[] colour = new int[3]; // An array for the r,g, and b values of a cell
  
  Cell(PVector coords, float cellSizeExtension, String orientation) { 
    this.coords = coords;
    this.cellSizeExtension = cellSizeExtension;
    this.orientation = orientation;
    this.genotype = setInitialValues();
  }
  
  void drawCell() {
      
    getColour();
    fill(colour[0],colour[1],colour[2]);
    stroke(166,140,99);
  
    if (orientation == "vertical"){    
      rect(coords.x, coords.y, cellSize, cellSize+cellSizeExtension);      
    }
    else {    
      rect(coords.x, coords.y, cellSize+cellSizeExtension, cellSize);
    }
  }
  
  
  
  


void getColour() {
  
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

}


}
