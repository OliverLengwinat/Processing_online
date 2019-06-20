void setup() {
	size(200, 200);

	//printMessage(jsString + " " + processingString); //function defined in JavaScript
	if (input_image==null)	printMessage("no Image found");
	else {		
		//printMessage("input: "+input_image_data);
		
		//int pixel_amount = input_image_data.length/4;
		
		PImage img = createImage(200, 200, RGB);
		img.loadPixels();
		for (int i = 0; i < img.pixels.length; i++) {
		  img.pixels[i] = color(input_image_data[i*4+0],input_image_data[i*4+1],input_image_data[i*4+2]); 
		}
		img.updatePixels();
		image(img, 0, 0, 200, 200);

	}
	
}