package visitor;
import java.util.*;
public class Functioninfo {
      String labelname = new String();
       String name = new String();
       String rettype = new String();
       Map<String,Varinfo> func_varinfo = new HashMap<String,Varinfo>(); 
       Vector<Varinfo> func_param = new Vector<Varinfo>();
       Vector<String> func_paramname = new Vector<String>();
       Vector<String> func_paramtype = new Vector<String>();
       int total_temp_count=0;
       int param_no = 1;
       Map<String,Integer> param_no_map = new HashMap<String,Integer>();
       Map<String,Integer> var_temp_no_map = new HashMap<String,Integer>();
    //    Map<String,NewLambdaType> func_lambdavarinfo = new HashMap<String,NewLambdaType>();
    //    Vector<NewLambdaType> lambda_param = new Vector<NewLambdaType>();
    //    Vector<String> lambda_param_names = new Vector<String>();
         Functioninfo(String rettype1, String name1){
                    rettype = rettype1;
                  name = name1;

         }
          Functioninfo(String rettype1, String name1,String label1){
                    labelname =label1;
                    rettype = rettype1;
                  name = name1;

         }
        //  Functioninfo(String rettype1 , String name1 ,String arg){
        //   rettype = rettype1;
        //   name = name1;
        //   Varinfo temp = new Varinfo("String[]",arg);
        //   func_param.add(temp);
        //   func_paramtype.add("String[]");
        //   func_paramname.add(arg);
        //  }
}
