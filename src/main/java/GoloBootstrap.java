import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;

public class GoloBootstrap {

  public static void main(String[] args) throws Throwable {
    if(args.length == 1) {
      String goloMainModuleName = args[0];
      Class klass = Class.forName(goloMainModuleName);
      MethodHandle main = MethodHandles.publicLookup().findStatic(klass, "main", MethodType.genericMethodType(1));
      main.invoke(args);
    }
    System.err.println("Usage: GoloBootstrap <golo_main_module_name>");
  }
}

