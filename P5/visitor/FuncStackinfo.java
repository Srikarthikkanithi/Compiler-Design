package visitor;
import java.util.*;
public class FuncStackinfo {
       int stackcount =0;
       Map<Integer,Integer> spilledreginfo = new HashMap<Integer,Integer>();  /*TEMP x : stack location */
       boolean storesx = false;
       boolean storetx = false;
       Vector<Integer> smappings = new Vector<Integer>();
       Vector<Integer> tmappings = new Vector<Integer>();
    //    Vector<Integer> argmapping = new Vector<Integer>();
       int max_arg_cnt = 0;
       public FuncStackinfo(int cnt){
        stackcount = cnt;
       }
       public FuncStackinfo(String fun_labelname,int maxargs1,boolean iscaller,int argcnt){
              // maxargs1 = Integer.max(argcnt,maxargs1);
              maxargs1+=argcnt;
              max_arg_cnt = maxargs1;

              if(maxargs1>4){
                 stackcount+=(maxargs1-4);
              }
              // System.out.println(stackcount + "  ::: " + fun_labelname + " ::: " + argcnt);
              if(fun_labelname.equals("MAIN")){
                if(iscaller){
                    storetx = true;
                    for(int i=0;i<10;i++){
                        tmappings.add(i+stackcount);
                    }
                        stackcount+=10;
                }
              }else{
                storesx = true;
                 for(int i=0;i<8;i++){
                     smappings.add(i+stackcount);
                 }
                     stackcount+=8;

                 if(iscaller){
                    storetx = true;
                    for(int i=0;i<10;i++){
                        tmappings.add(i+stackcount);
                    }
                        stackcount+=10;
                 }
              }
       }
       public void print_Stack(){
             if(storesx){
              System.out.println("\ns--mappings");
              for(int i=0;i<7;i++){
                System.out.print(smappings.get(i)+ "  ");
              }
            }
            if(storetx){
              System.out.println("\nt--mappings");
              for(int i=0;i<10;i++){
                System.out.print(tmappings.get(i)+ "  ");
              }
              System.out.println("\n");
            }
            for(Map.Entry<Integer,Integer> entry:spilledreginfo.entrySet()){
              System.out.println(entry.getKey() + " : : :  " + entry.getValue() );
            }
       }
       public void set_max_arg_cnt(int cnt){
             max_arg_cnt = cnt;
       }
}
