/*
  Author: Amay Kataria
  Description: This is called, "Luka", an interactive abstract art generator.
  
  Features: 
  a) 1 - 9: Colors 
  b) Tab: Shapes
  c) Arrow Up (Alpha up), Arrow Down (Alpha down)
  d) Arrow Left (stroke down), Arrow Right (stroke up)
  e) Space: To begin
  f) Mouse left click: Clear canvas
  g) Scale: s
  h) Rotate: r
  
  Needed features:
  - rotate these shapes (only in click mode)
  - Use a PShape to store the rectangle after 
  - scale these shapes (only in click mode) 
  - implement mouse modes
    - Click mode
    - Hover mode 
  - have a preview of the shape i just chose in a small window
  ** ability to undo these shapes ** golden feature
*/

enum Shape {
  ellipse,
  square,
  rectangle,
  line
};

enum MouseModes {
  hover,
  click
};

color fillVal = #6BFFCB;
float alpha = 100;
boolean start = false;
float stroke = 1;
boolean rotate = false;
boolean scale = false;
int numOfShapes = 4;
Shape [] shapes = { Shape.ellipse, Shape.square, Shape.rectangle, Shape.line };
// index of the current shape
// cycle through this index when tabbing between shapes
int currentShapeIdx = 0;

void setup() {
  background(#D6FFFE);
  size(800, 800, P3D);
}

void draw() {
  strokeWeight(stroke);
  
  fill(fillVal, alpha);
  
  Shape currentShape = shapes [currentShapeIdx]; 
  //print ("current shape is" + currentShape);
  // only draw the ellipse if start is true
  if (start) {
    
     // rotating the shape?
     if (rotate) {
       // save the coordinate system
       pushMatrix();
       // new origin is at mouseX, mouseY
       translate(mouseX, mouseY);
       rotate(radians(45));
     }
     
     if (scale) {
       pushMatrix();
       translate(mouseX, mouseY);
       scale(2.0);
     }  
       
     // Draw the shape
     switch (currentShape) {
       case ellipse:
         ellipse(mouseX, mouseY, 80, 80);
         break;
         
       case square:
         rect(mouseX, mouseY, 80, 80);
         break;
         
       case rectangle:
         rect(mouseX, mouseY, 40, 80);
         break;
        
       case line:
         line(mouseX, mouseY, mouseX + 40, mouseY);
         break;
         
       default:     
         break;
     }
     
     if (rotate || scale) {
       popMatrix(); 
     }
  }
}

// Capture the keypressed event
void keyPressed() {
 
 // CODED keys, alpha and stroke
 if (key == CODED) {
     switch (keyCode){
       case UP: 
         alpha+=10;
         break;
       
       case DOWN:
         alpha-=10;
         break;
       
       case LEFT:
         if (stroke - 0.5 >= 0) {
            stroke-= 0.5;
         }
         break;
       
       case RIGHT:
         stroke+= 0.5;
         break;
         
       default:
         break;
     }
 }

// Colors
 switch (key){
   case '1':
     fillVal = #F70000;
     break;
     
   case '2':
     fillVal = #F700EF;
     break;
   case '3':   
     fillVal = #6F00F7;
     break;

   case '4':
     fillVal = #0C00F7;
     break;
     
   case '5':
     fillVal = #0078F7;
      break;
     
   case '6':
     fillVal = #00EBF7;
     break; 
     
   case '7':
     fillVal = #00F790;
     break; 
     
   case '8':
     fillVal = #3EF700;
     break;  
     
   case '9':
     fillVal = #C6F700;
     break;  
    
   case ' ':
     print("start");
     start = !start;
     break;
     
   // switch between 
   case TAB:   
     setNextShape();
     break;
     
   case 'r':
     rotate = !rotate;
     break;
   
   case 's':
     scale = !scale;
     break;
   
   default: 
     print("Sorry, command not supported");
     break;
 } 
}

void mousePressed() {
  background(#D6FFFE);
}

// Helper Method to set the next shape
void setNextShape(){
  currentShapeIdx += 1;
  if (currentShapeIdx == numOfShapes){
    currentShapeIdx = 0;
  }
  return;
}