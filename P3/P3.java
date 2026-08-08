// import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import syntaxtree.*;
import visitor.*;

public class P3 {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         // System.out.println("Program parsed successfully");
         DepthFirstVisitor visitor1 = new DepthFirstVisitor();
         root.accept(visitor1);
         // visitor1.printclasses();
         GJDepthFirst<String,Void> visitor2 = new GJDepthFirst<>(visitor1.classesmapinfo); 
         root.accept(visitor2,null);
         Map<String,Pair<Integer,String>> m = visitor2.method_label_info; 
         for (Map.Entry<String, Pair<Integer,String>> entry : m.entrySet()) {
         String labelname = entry.getKey();
         int param_len = entry.getValue().first;
         String code = entry.getValue().second;
         System.out.println(labelname+ "     [ " + Integer.toString(param_len) + " ]\n" + code);
         }
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 


