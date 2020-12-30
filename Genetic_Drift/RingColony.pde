class RingColony {
  
  int number, startingRow, startingCol, ringSize;
  ArrayList <Cell> cells = new ArrayList<Cell>();
  
  RingColony(int number, int startingRow, int startingCol, int ringSize) {
    this.number = number;
    this.startingRow = startingRow;
    this.startingCol = startingCol;
    this.ringSize = ringSize;
  }
  
  void populateRing() {
     if (number==0) {
      startingX = cellSize*startingCol + padding;
      startingY = cellSize*startingRow + padding;
      endingX =  startingX + (ringSize-1)*(cellSize+cellSizeExtension[number]);
      endingY = startingY + (ringSize-1)*(cellSize+cellSizeExtension[number]);        
      }
    else {
      startingX =  (cellSize+gapBetweenRings)*startingCol + padding;
      startingY = (cellSize+gapBetweenRings)*startingRow + padding;
      endingX = startingX + (ringSize-1)*(cellSize+cellSizeExtension[number]);
      endingY = startingY + (ringSize-1)*(cellSize+cellSizeExtension[number]);
    }
    
    if (ringSize>1) {        
      // Fills in the cell colours of the top side of the ring, from left to right
      for (int j=startingCol; j<(startingCol+ringSize-1); j++) {
        float x = startingX + (cellSize+cellSizeExtension[number])*(j-startingCol);
        float y = startingY;
        PVector xy = new PVector(x,y); 
        Cell cell = new Cell(xy, cellSizeExtension[number], "horizontal");
        cells.add(cell);     
      }
      
      // Fills in the cell colours of the right side of the ring, from top to bottom
      for (int k=startingRow; k<(startingRow+ringSize-1); k++) {
        float x = endingX;
        float y = startingY + (cellSize+cellSizeExtension[number])*(k-startingRow);
        PVector xy = new PVector(x,y); 
        Cell cell = new Cell(xy, cellSizeExtension[number], "vertical");
        cells.add(cell);              
      }
      
      // Fills in the cell colours of the bottom side of the ring, from right to left
      for (int  l=startingCol+ringSize-1; l>startingCol; l--) {
        float x = endingX - (cellSize+cellSizeExtension[number])*(startingCol+ringSize-1-l);
        float y = endingY;
        PVector xy = new PVector(x-cellSizeExtension[number],y); 
        Cell cell = new Cell(xy, cellSizeExtension[number], "horizontal");
        cells.add(cell); 
      }
      
      // Fills in the cell colours of the left side of the ring, from bottom to top
      for (int m=startingRow+ringSize-1; m>startingRow; m--) {
        float x = startingX;
        float y = endingY  - (cellSize+cellSizeExtension[number])*(startingRow+ringSize-1-m);
        PVector xy = new PVector(x,y-cellSizeExtension[number]); 
        Cell cell = new Cell(xy, cellSizeExtension[number], "vertical");
        cells.add(cell);                              
      }   
    }
    
    else {
      float x = startingX;
      float y = startingY;
      PVector xy = new PVector(x,y); 
      Cell cell = new Cell(xy, 0, "horizontal");
      cells.add(cell);           
      rect(x,y,cellSize,cellSize);      
    }    
  }
  
  
  
}
