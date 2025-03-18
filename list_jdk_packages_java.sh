#!/bin/bash

# Architecture and OS
OS="mac"  # Change to "windows" or "mac" as needed
ARCH="aarch64"
# Optional argument to filter JDK versions (e.g., "17" to run only for jdk-17)
version="$1"

# Directory where JDKs are stored
JDK_DIR="./jdks-$OS-$ARCH/jdk-$version"

JAVA_SRC_DIR="javasrc_temp/io/hargrave/java/packages"
mkdir -p "$JAVA_SRC_DIR"
curl -L "https://raw.githubusercontent.com/bjhargrave/java-platform-packages/refs/heads/master/src/main/java/io/hargrave/java/packages/CalculateJavaPlatformPackages.java" -o "$JAVA_SRC_DIR/CalculateJavaPlatformPackages.java"

if [ -d "$JDK_DIR" ]; then
    if [ -x "$JDK_DIR/bin/java" ]; then
        JAVA_CMD="$JDK_DIR/bin/java"  # Linux JDK path
        JAVAC_CMD="$JDK_DIR/bin/javac"  
    elif [ -x "$JDK_DIR/Contents/Home/bin/java" ]; then
        JAVA_CMD="$JDK_DIR/Contents/Home/bin/java"  # macOS JDK path
        JAVAC_CMD="$JDK_DIR/Contents/Home/bin/javac"  
    else
        echo "Error: No Java executable found in $JDK_DIR"
        exit 1
    fi

    # Ensure the Java executable exists
    if [ -x "$JAVA_CMD" ]; then
        # Run the module listing command directly with this JDK
        $JAVAC_CMD $JAVA_SRC_DIR/CalculateJavaPlatformPackages.java
        $JAVA_CMD -cp javasrc_temp io.hargrave.java.packages.CalculateJavaPlatformPackages
    else
        echo "Error: No Java executable found in $JDK_DIR"
    fi

    echo
fi
