package elevator;

import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;

public class GoloBootstrap {

  public static String MAIN_MODULE = "elevator.Main";

  public static void main(String[] args) throws Throwable {
    Class klass = Class.forName(MAIN_MODULE);
    MethodHandle main = MethodHandles.publicLookup().findStatic(klass, "main", MethodType.genericMethodType(1));
    main.invoke(args);
  }
}

