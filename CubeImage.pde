import processing.pdf.*;

public class CubeImage
{
  
  PImage ci, original;
  // size (amount of Rubik's cubes in both the x and y direction)
  int s;
  boolean isPDF;
  
  ArrayList<ArrayList<String>> cublets = new ArrayList<ArrayList<String>>();
  
  public CubeImage(PImage image, boolean isPDF)
  {
    this.isPDF = isPDF;
    ci = image;
    //if (!isPDF)
      //original = image.copy();
    //original.resize(500, 500);
  }
  
  public CubeImage(String file, boolean isPDF)
  {
    this.isPDF = isPDF;
    ci = loadImage(file);
    //if (!isPDF)
    //{
      //original = ci.copy();
      //original.resize(int(original.width * 0.6), int(original.height * 0.6));
    //}
  }
  
  public void saveImage(String file)
  {
    ci.save("images/" + file + ".jpg");
  }
  
  public PImage getImage()
  {
    return ci;
  }
  
  public void setImage(PImage image)
  {
    ci = image;
  }
  
  public void setPixel(int x, int y, color p)
  {
    ci.set(x, y, p);
  }
  
  public void resizeImage(int w, int h)
  {
    ci.resize(w, h);
  }
  
  /**
  * Displays both the unedited and edited version of the image.
  */
  public void display()
  {
    image(ci, 5, 5);
    //if (!isPDF)
      //image(original, ci.width + 10, 5);
    
    
  }
  
  public ArrayList<ArrayList<String>> getCublets()
  {
    return cublets;
  }
  
  /**
  * Changes the image to only have either red, orange, yellow, or white in order to make it possible to directly represent the
  * image via Rubik's cubes.
  */
  public void doColoration()
  {
    color p;
    float b;
    
    int r = getRatio();
    
    String clrLet = "";
    int counterX = 0;
    int counterY = 0;
    
    for (int y = 0; y < getImage().height; y++)
    {
      if (y % r == 0)
      {
        cublets.add(new ArrayList<String>());
      }
      for (int x = 0; x < getImage().width; x++)
      {
        p = getImage().get(x, y);
        b = brightness(p);
        
        if (b < 10)
        {
          p = color(185, 92, 93); // blue
          clrLet = "B";
        }
        else if (b < 35)
        {
          p = color(359, 76, 95); // red
          clrLet = "R";
        }
        else if (b < 50)
        {
          p = color(30, 99, 99); // orange
          clrLet = "O";
        }
        else if (b < 75)
        {
          p = color(58, 99, 99); // yellow
          clrLet = "Y";
        }
        else
        {
          p = color(0, 0, 99); // white
          clrLet = "W";
        }
        
        setPixel(x, y, p);
        
        if (y % r == 0 && x % r == 0)
        {
          //println(counterY + ", " + clrNum + ", " + cublets.toString());
          //cublets.get(counterX).set(clrNum);
          cublets.get(counterY).add(clrLet);
          //println(counter + ", " + clrNum);
          //println("success!");
          counterX++;
        }
      }
      if (y % r == 0)
      {
        counterY++;
        counterX = 0;
      }
    }
    //println(cublets.toString());
    
    println(ci.width + ", " + ci.height);
  }
  
  /**
  * Pixelates the image in such a way as to use the desired size (s) of the image in terms of the amount of Rubik's cubes that are in either
  * the x or y direction in order to determine and set the amount of pixels there will be in the new image.
  */
  public void pixelate()
  {
    colorMode(HSB, 360, 100, 100);
    int x, y;
    // pixel, new pixel
    color p, np;
    PImage im = getImage();
    int[] sum = new int[3];
    // Main ratio of conversion, used to make the image have the right amount of Rubik's cubes.
    int r = getRatio();
    println(r);
    println(im.width + ", " + im.height);
    
    //im.resize(im.width - im.width % (im.width / 3 / r), im.height);
    //im = im.get(0, 0, im.width - (im.width % (3 * r)), im.height);
    
    // Makes the image a square.
    //resizeImage(im.width, im.width);
    // For every cube face there will be in the image.
    for (int c = 0; c <  im.width / r * im.height / r; c++)
     {
       sum[0] = 0;
       sum[1] = 0;
       sum[2] = 0;
       // For every block inside each cube face.
       for (int i = 0; i < r * r; i++)
       {
         // Set the x and y to that of the specific block in the specific cube face.
         x = (c * r) % im.width;
         y = (c / (im.width / r)) * r;
         x += (i % r);
         y += (i / r);
         
         p = im.get(x, y);
         
         sum[0] += hue(p);
         sum[1] += saturation(p);
         sum[2] += brightness(p);
         
         // Makes a new color for the image based on the average of all of the pixels in the selected region.
         // Changes as more colors are added to the sum array.
         np = color(sum[0] / r / r, sum[1] / r / r, sum[2] / r / r);
         setPixel(x, y, np);
         
         // Remove the offset so, on the next run through of this inner for loop, a new offset can be calculated.
         x -= (i % r);
         y -= (i / r);
         
         // Set each previous pixel to the new averaged color in order to keep consistency.
         for (int rv = i; rv >= 0; rv--)
         {
           setPixel(x + (rv % r), y + (rv / r), np);
         }
       }
       // HERE
     }
     
    println(im.width + ", " + im.height);
     
  }
  
  /**
  * Ratio that takes into account the current width/height of the image, the expected size of the new image, and the amount of blocks on a Rubik's cube's face in only the x direction.
  */
  public int getRatio()
  {
    return (ci.width / s) / 3;
    // ci.width
  }
  
  public void setSize(int size)
  {
    s = size;
    ci = ci.get(0, 0, getRatio() * 3 * s, getRatio() * 3 * s);
    //resizeImage(ci.width, ci.width);
    //resizeImage(s * getRatio() * 3, s * getRatio() * 3);
  }
  
  public int getSize()
  {
    return s;
  }
  
  /*
  public void doGrid()
  {
    int r = getRatio();
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
            withGrid.set(x, y, getImage().get((x) % withGrid.width, (y) % withGrid.height));
            // System.out.println("there");
          }
        }
    setImage(withGrid);
  }
  */
  
  //public void doGrid()
  //{
  //  int aX = 0;
  //  int aY = 0;
  //  int r = getRatio();
  //  int offsetX = 0;
  //  int offsetY = 0;
  //  PImage withGrid = new PImage(ci.width + s * 5 + s * 2 * 2, ci.height + s * 5 + s * 2 * 2);
  //  for (int x = 0; x < withGrid.width; x++)
  //  {
  //    for (int y = 0; y < withGrid.height; y++)
  //    {
  //      /*if (y % (3 * r) == 0)
  //      {
  //        withGrid.set(x, y, color(0, 0, 0));
  //        offsetY += 3;
  //        // offsetY %= withGrid.height;
  //        // System.out.println("1");
  //      }*/
  //      /*else if (x % (3 * r) == 0)
  //      {
  //        withGrid.set(x, y, color(0, 0, 0));
  //        offsetX += 3;
  //        // offsetX %= withGrid.width;
  //        // System.out.println("2");
  //      }*/
  //      if (y % r == 0)
  //      {
  //        // System.out.println("here");
  //        withGrid.set(x, y, color(0, 0, 0));
  //        // System.out.println(x + ", " + y);
  //        // System.out.println("here");
  //        // System.out.println("1");
  //      }
  //      /*else if (y % (r + 2) >= r)
  //      {
  //        // withGrid.set(x, y, getImage().get(aX, aY));
  //        withGrid.set(x, y, color(0, 0, 0));
  //      }
  //      else if (x % (r + 2) >= r)
  //      {          
  //        withGrid.set(x, y, color(0, 0, 0));
  //      }*/
  //      else
  //      {
  //        // System.out.println("a: " + aX + ", " + aY);
  //        withGrid.set(x + offsetX, y + offsetY, getImage().get(aX, aY));
  //        aY++;
  //        // System.out.println("2");
  //      }
  //    }
  //    aX++;
  //  }
  //  setImage(withGrid);
  //}
  
  public void doGrid()
  {
    // x and y values on the original image
    int aX = 0;
    int aY = 0;
    
    // pixel amount / cublet
    int r = getRatio();
    
    // x-axis counters
    
    // cublet counter
    int aCounter = r;
    // spacing counter
    int bCounter = 0;
    // face counter
    int cCounter = 0;
    int turn = 0;
    
    // y-axis counters
    
    // cublet counter
    int xCounter = r;
    // spacing counter
    int yCounter = 0;
    // face counter
    int zCounter = 0;
    int yTurn = 0;
    
    // new image
    //PImage withGrid = new PImage(ci.width + s * 10 + s * 2 * 2, ci.height + (ci.height / r) * (10 + 2 * 2));
    PImage withGrid = new PImage(ci.width + s * 10 + s * 2 * 2 - 10 - 2 + 3 * 0, ci.width + s * 10 + s * 2 * 2 - 10 - 2 + 6 * 0);
    println("withGrid: " + withGrid.width + ", " + withGrid.height);
    //for (int y = 0; y < withGrid.height; y++)
    //int y = 0;
    //while (aY < ci.height) //<>//
    for (int y = 0; y < withGrid.height; y++)
    {
      //if (yCounter <= 0)
        
      
        if (xCounter > 0)
        {
          // if y needs a real pixel
          for (int x = 0; x < withGrid.width; x++)
          //int x = 0;
          //while (aX < ci.width)
          {
            if (aCounter > 0)
            {
              // add pixel from original image
              // println(x + ", " + y + ", " + aCounter + ", " + bCounter + ", " + cCounter);
              //println(1);
              withGrid.set(x, y, getImage().get(aX, aY));
              aCounter--;
              aX++;
            }
            else if (bCounter <= 0 && turn == 0)
            {
              // get spacing ready
              //println(4);
              bCounter = 1;
              if (cCounter == 2) {
                // if the spacing is at the end of a face
                bCounter += 8;
                cCounter = 0;
              }
              else
                cCounter++;
              turn = 1;
            }
            
            if (bCounter > 0)
            {
              // put spacing in the new image
              //println(2);
              withGrid.set(x, y, color(0, 0, 0));
              bCounter--;
            }
            else if (aCounter <= 0 && turn == 1)
            {
              // end of spacing, go back to putting real pixels
              //println(3);
              aCounter = r;
              turn = 0;
              //x--;
            }
              
            //x++;
          }
        // reset counters
        
        println("aX: " + aX);
        aX = 0;
        aCounter = r;
        bCounter = 0;
        cCounter = 0;
        turn = 0;
        
        aY++;
        xCounter--;
      }
      else if (yCounter <= 0 && yTurn == 0)
      {
        // setting up y-axis spacing
        yCounter = 1;
        if (zCounter == 2)
        {
          // at the end of a face, the spacing is larger
          yCounter += 8;
          zCounter = 0;
        }
        else
          zCounter++;
        yTurn = 1;
      }
      if (yCounter > 0)
      {
        // putting in blank pixels in between cublets
        for (int x = 0; x < withGrid.width; x++)
        {
          withGrid.set(x, y, color(0, 0, 0));
        }
        yCounter--;
      }
      else if (yCounter <= 0 && yTurn == 1)
      {
        // stop spacing, continue doing real pixels
        yTurn = 0;
        xCounter = r;
      }
      //y++;
    }
    //for (int y = 0; y < withGrid.height; y++)
    //{
    //  aX = 0;
    //  for (int x = 0; x < withGrid.width; x++)
    //  {
    //    if ((x % r == 0 || x % r == 1 || x % (3 * r) == 2 || x % (3 * r) == 3 || x % (3 * r) == 4)  && x > 5)
    //    {
    //      withGrid.set(x, y, color(0, 0, 0));
    //    }
    //    else
    //    {
    //      withGrid.set(x, y, getImage().get(aX, aY));
    //      aX++;
    //      // System.out.println(X);
    //    }
    //  }
    //  if ((y % r == 0 || y % r == 1 || y % (3 * r) == 2 || y % (3 * r) == 3 || y % (3 * r) == 4) && y > 5)
    //  {
    //    //System.out.println("here");
    //    for (int x = 0; x < withGrid.width; x++)
    //    {
    //      withGrid.set(x, y, color(0, 0, 0));
    //    }
    //  } else {
    //    aY++;
    //  }
    //}
    setImage(withGrid);
    println(aX + ", " + aY);
  }
  
  
}
