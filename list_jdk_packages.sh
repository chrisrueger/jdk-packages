#!/bin/bash

# Check if all required parameters are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <JDK_VERSION> <OS> <ARCH>"
    echo "Example: $0 17 linux x64"
    echo "         $0 17 mac aarch64"
    echo "         $0 17 windows x64"
    exit 1
fi

# Mandatory parameters
version="$1"   # JDK Version (e.g., 17 for JDK 17)
OS="$2"        # OS Type (e.g., "linux", "mac", "windows")
ARCH="$3"      # Architecture (e.g., "x64", "aarch64" for Mac M1)

# Directory where JDKs are stored
JDK_DIR="./jdks-$OS-$ARCH/jdk-$version"

if [ -d "$JDK_DIR" ]; then
    
    if [ -x "$JDK_DIR/bin/java" ]; then
        JAVA_CMD="$JDK_DIR/bin/java"  # Linux JDK path
    elif [ -x "$JDK_DIR/Contents/Home/bin/java" ]; then
        JAVA_CMD="$JDK_DIR/Contents/Home/bin/java"  # macOS JDK path
    else
        echo "Error: No Java executable found in $JDK_DIR"
        exit 1
    fi

    echo "============================="
    echo "Using JDK: $JDK_DIR"
    echo "============================="

    # Ensure the Java executable exists
    if [ -x "$JAVA_CMD" ]; then
        # Run the module listing command directly with this JDK
        echo "Run $JAVA_CMD"
        #$JAVA_CMD --list-modules | awk '/^exports / {print $2}' | grep -v '^$'

        # List all modules
        modules=$($JAVA_CMD --list-modules | cut -d '@' -f1)

        # Loop through each module and describe it
        for module in $modules; do
            echo "============================="
            echo "Module: $module"
            echo "============================="
            $JAVA_CMD --describe-module $module
            echo
        done
    else
        echo "Error: No Java executable found in $JDK_DIR"
    fi

    echo
fi
