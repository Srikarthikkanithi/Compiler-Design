import syntaxtree.*;
import visitor.*;
import java.util.*;

public class P5 {
   public static void main(String [] args) {
      try {
         Node root = new microIRParser(System.in).Goal();
         // System.out.println("Program parsed successfully");
         DepthFirstVisitor visitor1 = new DepthFirstVisitor();
         root.accept(visitor1);


         // System.out.println(visitor1.maxtemp);
         //  Map<String,Integer> maxargs = visitor1.lsa.funcallsinfo;
         //  for(Map.Entry<String,Integer> entry:maxargs.entrySet()){
         //    System.out.println(entry.getKey() + "  :  "  + entry.getValue());
         //  }


         LinearScanAlgoApp presentinfo = visitor1.lsa;
         presentinfo.Init_Stacks();

         presentinfo.Checkspillings();


         // presentinfo.print_temp_info();


         // System.out.println("hi");

         // presentinfo.print_Stacks();
         // System.out.println("hello");
         // Map<String,Integer> p = presentinfo.fun_argcnt;
         // for(Map.Entry<String,Integer> entry:p.entrySet()){
         //    System.out.println(entry.getKey()+ "   " + entry.getValue());
         // }
         GJNoArguDepthFirst<String> visitor2 = new GJNoArguDepthFirst<>(presentinfo);

         root.accept(visitor2);
         // System.out.println("hello1");
         // Map<String,FuncStackinfo> f = visitor2.finalinfo.tempinfo;
         // for(Map.Entry<String,FuncStackinfo> entry:f.entrySet()){
         //    System.out.println(entry.getKey() + ": ");
         //    entry.getValue().print_Stack();
         // }

      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 


