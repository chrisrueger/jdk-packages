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

# list packages for all JDKs
./list_jdk_packages.sh > jdkall.txt

# list packages of JDK17 using CalculateJavaPlatformPackages.java
# outputting a .properties file for bnd / bndtools
# Source: https://github.com/bjhargrave/java-platform-packages
./list_jdk_packages_java.sh 17 > "jdk17-packages.properties"
```