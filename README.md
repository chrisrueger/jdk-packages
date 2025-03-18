# JDK Packages

Some helper scripts to generate lists of packages contained in a specific JDK version. 

## Usage Examples

```sh

# Download JDK 17
./download_jdk.sh 17

# list packages for JDK17
./list_jdk_packages.sh 17

# list packages for JDK17 and write into file jdk17.txt
./list_jdk_packages.sh 17 > jdk17.txt

# list packages for JDK17 and write into file jdk17-onlypackages.txt
# but extract only the packages
./list_jdk_packages.sh 17 | awk '/^exports / {print $2}' > jdk17-onlypackages.txt




# list packages of JDK17 using CalculateJavaPlatformPackages.java
# outputting a .properties file for bnd / bndtools
# Source: https://github.com/bjhargrave/java-platform-packages
./list_jdk_packages_java.sh 17 > "jdk17-packages.properties"
```

## Example Outputs 

The following output can 

```shell
# list_jdk_packages.sh 17

=============================
Using JDK: ./jdks-mac-aarch64/jdk-17
=============================
Run ./jdks-mac-aarch64/jdk-17/Contents/Home/bin/java
=============================
Module: java.base
=============================
java.base@17.0.14
exports java.io
exports java.lang
exports java.lang.annotation
exports java.lang.constant
exports java.lang.invoke
exports java.lang.module
exports java.lang.ref

=============================
Module: java.datatransfer
=============================
java.datatransfer@17.0.14
exports java.awt.datatransfer
requires java.base mandated
uses sun.datatransfer.DesktopDatatransferService
qualified exports sun.datatransfer to java.desktop
contains sun.datatransfer.resources

...

```

If you are only interested in the plain packages try using this:

```shell
# ./list_jdk_packages.sh 17 | awk '/^exports / {print $2}' > jdk17-onlypackages.txt

java.io
java.lang
java.lang.annotation
java.lang.constant
java.lang.invoke
java.lang.module
java.lang.ref

```


The following creates a .properties file for placing into https://github.com/bndtools/bnd/tree/master/biz.aQute.bndlib/src/aQute/bnd/build/model (e.g. see [JavaSE_17.properties](https://github.com/bndtools/bnd/blob/master/biz.aQute.bndlib/src/aQute/bnd/build/model/JavaSE_17.properties))

```shell
# list_jdk_packages.sh 17

org.osgi.framework.system.packages = \
 com.sun.jarsigner,\
 com.sun.java.accessibility.util,\
 com.sun.jdi,\
 com.sun.jdi.connect,\

jpms.modules = \
 java.base;\
  exports:List<String>='\
   java.io,\
   java.lang,\
   java.lang.annotation,\
 java.compiler;\
  exports:List<String>='\
   javax.annotation.processing,\
   javax.lang.model,\
   javax.lang.model.element,\
   javax.lang.model.type,\
   javax.lang.model.util,\
   javax.tools',\
 java.datatransfer;\
  exports:List<String>='\
   java.awt.datatransfer',\

   ...

```