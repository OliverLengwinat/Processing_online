int colors = 20; //different color values, compare 8bit

PImage img;
PGraphics pg_art, pg_invisible;
double old_error = 10000000;
int shapes_used, shapes_total =0;


double compare(PImage p1, PGraphics p2) {
  long difference = 0;
  for (int i=0; i<p1.pixels.length; i++){
    float h1 = brightness(p1.pixels[i]);
    float h2 = brightness(p2.pixels[i]);
    
    //version 1: absolute
    difference += abs(h1-h2);
    
    //version 2: squared
    //difference += abs(h1-h2)/255*abs(h1-h2)/255;
    
    //version 3: divided
    //if (h1>h2) difference+=h1/(h2+1);
    //else difference+=h2/(h1+1);
  }
  return difference;
}

void setup() {
	size(400, 200);

  	noStroke();
  	textAlign(CENTER);
  	textSize(11);
  
  	ellipseMode(CENTER);

	//load image
	img = createImage(200, 200, RGB);
	img.loadPixels();
	for (int i = 0; i < img.pixels.length; i++) {
	  img.pixels[i] = color(input_image_data[i*4+0],input_image_data[i*4+1],input_image_data[i*4+2]); 
	}
	img.updatePixels();  
	println ("input width: "+img.width+", height: "+img.height);
  
  //show original image
  //image(img, 0,0, width/2,height);
  
  	pg_art = createGraphics(img.width,img.height);
  	pg_invisible = createGraphics(img.width,img.height);
}

void draw() {
  
  background(100);
  image(img, 0,0);
   
  color random_color = int(random(colors))*256/colors;
  int size = int(random(img.width));
  int posx = int(random(img.width));
  int posy = int(random(img.height));
  //float[] newshape = {random(img.width), random(img.height), random(img.width), random(img.height), random(img.width), random(img.height)};
  pg_invisible.beginDraw();
  pg_invisible.fill(random_color);
  pg_invisible.noStroke();
  //pg_invisible.triangle(newshape[0],newshape[1],newshape[2],newshape[3],newshape[4],newshape[5]);
  pg_invisible.ellipse(posx,posy,size,size);
  pg_invisible.endDraw();
  
  //image(pg_invisible, width/2,0);
  
  shapes_total ++;
  //double new_error = compare(img,pg_invisible);
  double new_error = old_error-1000;
  if (new_error < old_error){
    println("new error: "+new_error);
    old_error = new_error;
    //pg_art = createGraphics(img.width,img.height);
    pg_art.beginDraw();
    pg_art.loadPixels();
    arrayCopy(pg_invisible.pixels, pg_art.pixels);
    pg_art.updatePixels(); 
    pg_art.endDraw();
    //image(pg_art, width/2,0, width/2,height);
    shapes_used++;
  }
  else {
    //set back
    //pg_invisible = createGraphics(img.width,img.height);
    pg_invisible.beginDraw();
    pg_invisible.loadPixels();
    arrayCopy(pg_art.pixels, pg_invisible.pixels);
    pg_invisible.updatePixels(); 
    pg_invisible.endDraw();
  }
  
  //show original image
  image(pg_art, width/2,0);
  
  //show how many shapes were used
  String s = shapes_used + " / " + shapes_total; 
  text(s, width/2, height-10);
  
  //draw last try, successful or not
  noFill();
  stroke(random_color);
  ellipse(posx+width/2,posy,size,size);
  //triangle(newshape[0]+width/2,newshape[1],newshape[2]+width/2,newshape[3],newshape[4]+width/2,newshape[5]);
  
}
