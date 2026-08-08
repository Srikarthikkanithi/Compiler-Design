import syntaxtree.*;
import visitor.*;


public class P2{
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         // System.out.println("Program parsed successfully");

        DepthFirstVisitor visitor1 = new DepthFirstVisitor();
         root.accept(visitor1);
        GJDepthFirst<Boolean,Void > visitor2 = new GJDepthFirst<>(visitor1.classesinfoMap);
      //   visitor2.printClasses();
         root.accept(visitor2,null); 
         System.out.println("Program type checked successfully");
      }
      catch (ParseException e) {
         
         System.out.println(e.toString());
         // System.out.println("Type error");
      }
      // catch (NullPointerException e)
      // {
      //    System.out.println("Type error");
      // }
   }
} 




