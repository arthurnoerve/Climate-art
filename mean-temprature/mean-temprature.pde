
import processing.pdf.*;

// DATA:
// monthly.csv
// type,date,temp
// http://data.okfn.org/data/core/global-temp#readme




Table table;
int N;

float[] temps;

float LRPadding; //Padding on sides
float yZero; //distance from top for zero deviation
float yscale; //squeeze factor for temprature


void setup() {
  
  beginRecord(PDF, "temprature.pdf");     // Start writing to PDF
  
  
  /* FETCH DATA */
  table = loadTable("annual.csv","header");
  println(table.getRowCount() + " total rows in table"); 
  
  /* SETUP */
  size(1500,500);
  stroke(200,0,0);
  background(40);
  strokeWeight(2);
  strokeCap(SQUARE);
  
  temps = new float[0];
  LRPadding = 80;
  yZero = 70*height/100;
  yscale = 250;
  
  
  /* EXTRACT */
  for (TableRow row : table.rows()) {
    if ( row.getString("Source").equals("GISTEMP") ) {
      float temp = row.getFloat("Mean");
      temps = append(temps, temp);
    }
  }
  
  temps = reverse(temps);
  //temps = subset(temps,temps.length/2);
  
  N = temps.length;
  

           
  /* GRAPH */
  float t,j;
  float M = max(temps);
  float m = min(temps);
  for (int i=0; i < N; i++) {
    
    j = map(i, 0,N, LRPadding,width-LRPadding);
    t = temps[i]*yscale;
    
    line(j,yZero, j,yZero-t);
    
  }
  
  
  //Baseline
  //strokeWeight(0.5);
  //line(0,yZero,width,yZero);
  
  endRecord();    
  
}

void draw() {
  
  
  
}