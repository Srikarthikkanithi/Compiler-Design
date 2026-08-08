import syntaxtree.*;
import visitor.*;

public class P4 {
   public static void main(String [] args) {
      try {
         Node root = new MiniIRParser(System.in).Goal();
         DepthFirstVisitor visitor1 = new DepthFirstVisitor();
         root.accept(visitor1);
         // System.out.println("Program parsed successfully");
         // System.out.println(visitor1.maxtemp + 1 + " is the number of temps required");
         GJNoArguDepthFirst<String> visitor2 = new GJNoArguDepthFirst<>(visitor1.maxtemp+1);
         root.accept(visitor2); // Your assignment part is invoked here.
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 


