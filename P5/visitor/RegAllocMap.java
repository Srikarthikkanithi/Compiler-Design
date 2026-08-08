package visitor;
import java.util.*;
public class RegAllocMap {
      
      public Map<Integer,Integer> tmapping = new HashMap<Integer,Integer>();
       public Map<Integer,Integer> smapping = new HashMap<Integer,Integer>(); /*TEMP X   ty */
       public Set<Integer> spilledvars = new HashSet<Integer>();
       public void printalloc(){
              System.out.println("t--mapping:");
              for(Map.Entry<Integer,Integer> entry:tmapping.entrySet()){
                     System.out.println(entry.getKey() + " : " + entry.getValue());
              }
              System.out.println("s--mapping:");
              for(Map.Entry<Integer,Integer> entry:smapping.entrySet()){
                     System.out.println(entry.getKey() + " : " + entry.getValue());
              }
              System.out.println("spillinginfo:");
              for(Integer value:spilledvars){
                     System.out.print(value+ " ");
              }
              System.out.println();
       }
}
