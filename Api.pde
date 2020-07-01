class Location_API extends Thread {
  private String URL;
  private MyLocation myLoc;
  
  Location_API(String URL, MyLocation myLoc) {
    this.URL = URL;
    this.myLoc = myLoc;
    start();
  }
  
  void run() {
    URL url;
    InputStream is = null;
    while (true) {
      BufferedReader br;
      String line, result="";

      try {
        url = new URL(URL);
        is = url.openStream(); 
        br = new BufferedReader(new InputStreamReader(is));

        while ((line = br.readLine()) != null) {
          float x = parseFloat(line.split(",")[0]);
          float y = parseFloat(line.split(",")[1]);
          myLoc.setX(x); myLoc.setY(y);
          break;
        }
      } 
      catch (Exception mue) {
        mue.printStackTrace();
      } 
      finally {
        try {
          if (is != null) is.close();
        } 
        catch (IOException ioe) {
        }
      }
      
      try 
      {
        Thread.sleep (100);
      } catch (Exception e){}
    }
  }
}