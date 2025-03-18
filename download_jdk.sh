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

# Directory to store JDKs
JDK_DIR="./jdks-$OS-$ARCH"
mkdir -p "$JDK_DIR"

# Adoptium base URL (update this if needed)
ADOPTIUM_URL="https://api.adoptium.net/v3/binary/latest"


# Download and extract each JDK
echo "Downloading JDK $version..."

# Construct the download URL
JDK_FILE="$JDK_DIR/jdk-$version.tar.gz"
JDK_EXTRACT_DIR="$JDK_DIR/jdk-$version"

curl -L "$ADOPTIUM_URL/$version/ga/$OS/$ARCH/jdk/hotspot/normal/eclipse?project=jdk" -o "$JDK_FILE"

echo "Extracting JDK $version..."
mkdir -p "$JDK_EXTRACT_DIR"
tar -xzf "$JDK_FILE" --strip-components=1 -C "$JDK_EXTRACT_DIR"

rm "$JDK_FILE"  # Clean up downloaded archive

echo "All JDKs downloaded and extracted!"
