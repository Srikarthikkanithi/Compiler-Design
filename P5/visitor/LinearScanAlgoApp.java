package visitor;
import java.util.*;
public class LinearScanAlgoApp {
       // int maxtemps = 0;
       public Vector<Pair<Integer,Integer>> intervalinfo = new Vector<Pair<Integer,Integer>>();
       // public Map<String,Funcallinfo> funcallsinfo = new HashMap<String,Funcallinfo>();
       int no_of_functions = 0;
       public Map<String,Integer> fun_argcnt = new HashMap<String,Integer>(); //fns argument count
       public Map<String,Integer> fun_maxtemp = new HashMap<String,Integer>(); //max X in TEMP x
       public Map<String,Integer> funcallsinfo = new HashMap<String,Integer>(); //max of argumentcount of all funcalls in a particular function 
       public Map<String,RegAllocMap> regallocinfo = new HashMap<String,RegAllocMap>();
       public  Map<String,FuncStackinfo> tempinfo = new HashMap<String,FuncStackinfo>();
       public Map<String,Boolean> is_caller = new HashMap<String,Boolean>();
       public void Checkspillings(){
          for(Map.Entry<String,Integer> entry:fun_maxtemp.entrySet()){
            int maxtemps = entry.getValue();
            String fun_labelname = entry.getKey();
           
            RegAllocMap rallocmap = new RegAllocMap();
            for(int i=0;i<=maxtemps;i++){
              if(i<=7){
                rallocmap.smapping.put(i,i);
              }else {
                if(i<=17){
                     rallocmap.tmapping.put(i,i-8);
                }else{
                     rallocmap.spilledvars.add(i);
                     // int presentstackcount = tempinfo.get(fun_labelname).stackcount;
                     // tempinfo.get(fun_labelname).spilledreginfo.put(i,presentstackcount);
                     // tempinfo.get(fun_labelname).stackcount++;
                }
              }
            }
            regallocinfo.put(fun_labelname,rallocmap);
       }
       }
       public void print_temp_info(){
              for(Map.Entry<String,RegAllocMap> entry:regallocinfo.entrySet()){
              System.out.println(entry.getKey() + " : ");
              entry.getValue().printalloc();
       }
       }
       public void Init_Stacks(){
              for(Map.Entry<String,Integer> entry:funcallsinfo.entrySet()){
                     String funlabelinfo = entry.getKey();
                     Integer maxargs = entry.getValue();
                     boolean iscaller1 = is_caller.get(funlabelinfo);
                     int argcnt1 = fun_argcnt.get(funlabelinfo);
                     // System.out.println(funlabelinfo+ ":-> " + Integer.toString(argcnt1));
                     FuncStackinfo f = new FuncStackinfo(funlabelinfo,maxargs,iscaller1,argcnt1);
                     tempinfo.put(funlabelinfo,f);
              }
       }
       public void print_Stacks(){
              //  System.out.println("hi");
              for(Map.Entry<String,FuncStackinfo> entry:tempinfo.entrySet()){
                     String funlabelinfo = entry.getKey();
                     FuncStackinfo f = entry.getValue();
                     System.out.println(funlabelinfo + " :");
                     f.print_Stack();

              }
       }
}
