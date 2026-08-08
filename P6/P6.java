import syntaxtree.*;
import visitor.*;

public class P6 {
   public static void main(String [] args) {
      try {
         Node root = new MiniRAParser(System.in).Goal();
        //  System.out.println("Program parsed successfully");
        GJNoArguDepthFirst<String> visitor1 = new GJNoArguDepthFirst<>();
         root.accept(visitor1); 
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 


