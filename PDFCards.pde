public class PDFCards
{
  
  ArrayList<ArrayList<String>> clrList;
  
  public PDFCards(ArrayList<ArrayList<String>> clrList)
  {
    //println(clrList);
    reverseArrayList(clrList);
    //println("test");
    println(clrList);
    this.clrList = clrList;
  }
  
  public void cards(int page)
  {
    //println(clrList.toString());
    //int[] topRight, topLeft, bottomLeft, bottomRight;
    
    for (int x = 0; x < 16; x++)
    {
      if (x % 3 == 0)
      {
        strokeWeight(3);
      }
      else
      {
        strokeWeight(1);
      }
      line(x * (170 / 3), 0, x * (170 / 3), 1100);
    }
    
    for (int y = 0; y < 19; y++)
    {
      if (y % 3 == 0)
      {
        strokeWeight(3);
      }
      else
      {
        strokeWeight(1);
      }
      line(0, y * (170 / 3), 850, y * (170 / 3));
      
    }
    
    fill(0);
    
    int aX, aY;
    //int xOff = page * 30 % clrList.get(0).size();
    //int yOff = (page * 30) / clrList.get(0).size();
    int off = page * 30;
    int prevYOff;
    int pdfX, pdfY;
    for (int c = 0; c < 30; c++)
    {
      pdfX = c % 5;
      pdfY = c / 5;
      
      text(((off + c) % (clrList.get(0).size() / 3)) + ", " + ((off + c) / (clrList.get(0).size() / 3)), 85 + pdfX * 170 - 10, 85 + pdfY * 170 + 15);
      
      for (int y = 0; y < 3; y++)
      {
        for (int x = 0; x < 3; x++)
        {
          //println(x * (170 / 3) + 170 / 3 / 2 + pdfX * 170);
          //println(yOff + y, xOff + x);
          println("1", ((3 * (off + c)) / clrList.get(0).size()) * 3 + y, (3 * (off + c) + x) % clrList.get(0).size());
          println("2", 3 * (off + c) + y, 3 * (off + c) + x);
          println("3", off, c);
          println("4", x, y);
          if (((3 * (off + c)) / clrList.get(0).size()) * 3 + y < clrList.size())
            text(clrList.get(((3 * (off + c)) / clrList.get(0).size()) * 3 + y).get((3 * (off + c) + x) % clrList.get(0).size()), x * (170 / 3) + 170 / 3 / 2 + pdfX * 170, (2 - y) * (170 / 3) + 170 / 3 / 2 + pdfY * 170);
          //text("2", 50, 50);
          //int[] topLeft = {x * (170), y * (170)};
          //int[] topRight = {170 + x * (170), y * (170)};
          //int[] bottomLeft = {x * (170), 170 * (y + 1)};
          //int[] bottomRight = {170 + x * (170), 170 * (y + 1)};
          //int[] topLeftMid = {x * 170 + 57, y * 170};
          //int[] topRightMid = {x * 170 + 57 * 2, y * 170};
          //int[] leftTopMid = {x * 170, y * 170 + 57};
          //int[] leftBottomMid = {x * 170, y * 170 + 57 * 2};
          //int[] rightTopMid = {170 + 170 * x, 170 * y + 57};
          //int[] rightBottomMid = {170 + 170 * x, 170 * y + 57 * 2};
          //int[] bottomLeftMid = {170 * x + 57, 170 * (y + 1)};
          //int[] bottomRightMid = {170 * x + 57 * 2, 170 * (y + 1)};
          //int[] topLeft = {40 + x * (243 + 20), 40 + y * (243 + 16)};
          //int[] topRight = {40 + 243 + x * (243 + 20), 40 + y * (243 + 16)};
          //int[] bottomLeft = {40 + x * (243 + 20), 40 + 243 * (y + 1) + 16 * y};
          //int[] bottomRight = {40 + 243 + x * (243 + 20), 40 + 243 * (y + 1) + 16 * y};
          //strokeWeight(3);
          //line(topLeft[0], topLeft[1], topRight[0], topRight[1]);
          //line(topLeft[0], topLeft[1], bottomLeft[0], bottomLeft[1]);
          //line(topRight[0], topRight[1], bottomRight[0], bottomRight[1]);
          //line(bottomLeft[0], bottomLeft[1], bottomRight[0], bottomRight[1]);
          //strokeWeight(1);
          //line(topLeftMid[0], topLeftMid[1], bottomLeftMid[0], bottomLeftMid[1]);
          //line(topRightMid[0], topRightMid[1], bottomRightMid[0], bottomRightMid[1]);
          //line(leftTopMid[0], leftTopMid[1], rightTopMid[0], rightTopMid[1]);
          //line(leftBottomMid[0], leftBottomMid[1], rightBottomMid[0], rightBottomMid[1]);
        }
        //yOff++;
      }
    }
  }
  
  public void reverseArrayList(ArrayList<ArrayList<String>> arr)
  {
    //println(arr.toString());
    for (int c = 0; c < arr.size() / 2; c++)
    {
      ArrayList<String> temp = arr.get(arr.size() - c - 1);
      arr.set(arr.size() - c - 1, arr.get(c));
      arr.set(c, temp);
    }
    //println("!!!HERE!!!");
    //println(arr.toString());
  }
  
  
}
