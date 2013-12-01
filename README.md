golo-elevator
=====================


##Compile project (single jar)
It will produce a ```jar-with-dependencies.jar``` standalone artifact.
    mvn package

##Run project

    mvn exec:java

##Configurtation
By default the server listens on 9090, you can overwrite usin the ```app.port``` system property.

    mvn exec:java -Dapp.port=8080

##Cloudbees
The showcase is proudly hosted on [CloudBees](http://www.cloudbees.com/)
### [http://golo-elevator.typeunsafe.cloudbees.net/](http://golo-elevator.typeunsafe.cloudbees.net/)
