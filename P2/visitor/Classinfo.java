package visitor;
import java.util.*;
public class Classinfo {
       String name = new String();
       String parent = null;
       Map<String,Functioninfo> class_funcinfo = new HashMap<String,Functioninfo>();
       Map<String,Varinfo> class_varinfo = new HashMap<String,Varinfo>();
       Map<String,NewLambdaType> class_lambdavarinfo = new HashMap<String,NewLambdaType>();
       Classinfo(String name1){
              name  = name1;
       }
       Classinfo(String name1, Classinfo c){
              name = name1;
              class_varinfo.putAll(c.class_varinfo);
              class_funcinfo.putAll(c.class_funcinfo);
       }
}
