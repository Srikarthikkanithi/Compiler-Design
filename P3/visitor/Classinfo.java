package visitor;
import java.util.*;
public class Classinfo {
       String name = new String();
       String parent = null;
       int no_of_variables=1;
       int no_of_functions=0;
       Map<String,Functioninfo> class_funcinfo = new HashMap<String,Functioninfo>();
       Map<String,Varinfo> class_varinfo = new HashMap<String,Varinfo>();
       Map<String,Integer> offset_map_var = new HashMap<String,Integer>();
       Map<String,Integer> offset_map_func = new HashMap<String,Integer>(); 
    //    Map<String,NewLambdaType> class_lambdavarinfo = new HashMap<String,NewLambdaType>();
       Classinfo(String name1){
              name  = name1;
       }
       Classinfo(String name1, Classinfo c){
              name = name1;
              class_varinfo.putAll(c.class_varinfo);
              class_funcinfo.putAll(c.class_funcinfo);
       }
       Classinfo(Classinfo copyclass){
        parent = copyclass.name;
        no_of_functions = copyclass.no_of_functions;
        class_funcinfo = copyclass.class_funcinfo;
        offset_map_func = copyclass.offset_map_func;
        no_of_variables = copyclass.no_of_variables;
        class_varinfo = copyclass.class_varinfo;
        offset_map_var = copyclass.offset_map_var;
       }
}
