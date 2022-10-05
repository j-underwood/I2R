import processing.pdf.*;

CubeImage cubes;

boolean doPDF = false;

PDFCards cards;

void settings() {
  if (doPDF)
  {
    size(850, 1100, PDF, "test.pdf");
  }
  else
    size(1800, 1800);
}

void setup() {
  background(255);
  cubes = new CubeImage("firework19.jpg", doPDF);
  cubes.resizeImage(cubes.getImage().width, cubes.getImage().width);
  // Set the image to have the potential to be 25 cubes by 25 cubes.
  cubes.setSize(25);
  // Pixelate in such a way that makes the image 25 cubes by 25 cubes.
  cubes.pixelate();
  // Recolor the image using only good Rubik's cube colors.
  cubes.doColoration();
  cubes.doGrid();
  cubes.resizeImage(int(cubes.getImage().width * 0.5), int(cubes.getImage().height * 0.5));
  
  if (doPDF)
    cards = new PDFCards(cubes.getCublets());
}

/*void setup() {
  // int amountX = 100;
  // int amountY = 100;
  
  img = loadImage("monalisa1.jpg");
  original = img.copy();
  // img.resize(amountX * 10, amountY * 10);
  colorMode(HSB, 360, 100, 100);
  
  color p;
  float h, s, b;
  
  int size = 5;
  
  boolean doGrid = true;
  
  ArrayList<Float> cube = new ArrayList<Float>();
  
  
  for (int x = 0; x < img.width; x++)
    for (int y = 0; y < img.height; y++)
      {
        System.out.println(int(x) / 5);
      }
  
  
  int[] sum = new int[3];
  // int r = int(sqrt(sqrt(img.width * img.height)));
  // int r = 27;
  int cubeAmountX = 25;
  int r = img.width / cubeAmountX / 3;
  img.resize(img.width / r * r, img.width / r * r);
  System.out.println(img.width / r / 3 + ", " + img.height / r / 3);
  System.out.println(r);
  for (int c = 0; c < ceil((float) img.width / r) * ceil((float) img.height / r); c++)
   {
     sum[0] = 0;
     sum[1] = 0;
     sum[2] = 0;
     for (int i = 0; i < r * r; i++)
     {
       x = (c * r) % img.width;
       y = (c / (img.width / r)) * r;
       x += (i % r);
       y += (i / r);
       p = img.get(x, y);
       sum[0] += hue(p);
       sum[1] += saturation(p);
       sum[2] += brightness(p);
       color np = color(sum[0] / r / r, sum[1] / r / r, sum[2] / r / r);
       img.set(x, y, np);
       x -= (i % r);
       y -= (i / r);
       for (int rv = i; rv >= 0; rv--)
       {
         img.set(x + (rv % r), y + (rv / r), np);
       }
     }
   }
  
  for (int x = 0; x < img.width; x++)
  {
    for (int y = 0; y < img.height; y++)
    {
      p = img.get(x, y);
      h = hue(p);
      s = saturation(p);
      b = brightness(p);
      
      if (s > 30)
        if (h < 15 || h >= 295)
          p = color(6, 79, 95); // red
        else if (15 <= h && h < 42)
          p = color(39, 79, 95); // orange
        else if (42 <= h && h < 72)
          p = color(56, 79, 95); // yellow
        else if (72 <= h && h < 154)
          p = color(114, 79, 95); // green
        else if (154 <= h && h < 295)
          p = color(241, 79, 95); // blue
        else
          System.out.println(h + ", " + s + ", " + b);
      else
        p = color(241, 0, 97); // white
      
      img.set(x, y, p);
    }
  }
  
  for (int x = 0; x < img.width; x++)
  {
    for (int y = 0; y < img.height; y++)
    {
      p = img.get(x, y);
      b = brightness(p);
      
      if (b < 0)
        p = color(185, 92, 93); // blue
      else if (b < 25)
        p = color(359, 76, 95); // red
      else if (b < 50)
        p = color(30, 99, 99); // orange
      else if (b < 75)
        p = color(58, 99, 99); // yellow
      else
        p = color(0, 0, 99); // white
      
      img.set(x, y, p);
    }
  }
  
  if (doGrid) {
    int offsetX = 0;
    int offsetY = 0;
    PImage withGrid = new PImage(width + width / 2 / r, height + height / 2 / r);
    for (int x = 0; x < withGrid.width; x++)
      for (int y = 0; y < withGrid.height; y++)
        {
          if ((x % (3 * r) == 0) || (y % (r * 3) == 0)) {
            withGrid.set(x, y, color(0, 0, 0));
            // withGrid.set(x + 1, y, color(0, 0, 0));
            // offsetX += 1;
            // System.out.println("here");
          } else {
            withGrid.set(x, y, img.get((x + offsetX) % withGrid.width, (y + offsetY) % withGrid.height));
            // System.out.println("there");
          }
        }
    img = withGrid;
  }
  
  // img.resize(int(img.width * 0.5),int(img.height * 0.5));
}
*/

/*
public static void imgIns(PImage i, int atX, int atY, color c) {
  PImage o = new PImage(i.width + 1, i.height + 1);
  int offsetX = 0;
  int offsetY = 0;
  
  for (int x = 0; x < i.width; x++)
    for (int y = 0; y < i.height; y++)
    {
      if (atX == x && atY == y)
      {
        o.set(x, y, c);
      }
      else
      {
        
      }
    }
}
*/

void draw() {
  //background(255);
  //cubes.display();
  
  if (doPDF)
  {
    cards.cards(frameCount - 1);
    PGraphicsPDF pdf = (PGraphicsPDF) g;
    //println(frameCount, cubes.getCublets().size() * cubes.getCublets().get(0).size()/ 30);
    //if (frameCount == cubes.getCublets().size() * cubes.getCublets().get(0).size() / 30)
    if (frameCount == ceil(cubes.getSize() * cubes.getSize() / 30.0))
    {
      exit();
    }
    else
    {
      pdf.nextPage();
    }
  }
  else
  {
    background(255);
    cubes.display();
  }
}
