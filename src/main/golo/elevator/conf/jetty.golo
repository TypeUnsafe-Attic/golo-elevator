module elevator.conf.jetty

import java.lang.System
import spark.Spark

struct JettyStruct = { port, staticFileLocation }

function default_jetty_conf = -> JettyStruct():
  port(9090):
  staticFileLocation("web"):
  frozenCopy()

function Jetty = | jettyConf | {
  let this = JettyStruct()
  this: port(jettyConf?: port() orIfNull default_jetty_conf(): port())
  this: staticFileLocation(jettyConf?: staticFileLocation() orIfNull default_jetty_conf(): staticFileLocation())
  return this: frozenCopy()
}

augment elevator.conf.jetty.types.JettyStruct {
 function init = |this| {
   let port = System.getProperty("app.port")?: toInteger() orIfNull this: port()
   setPort(port)
   staticFileLocation(this: staticFileLocation())
 }
}