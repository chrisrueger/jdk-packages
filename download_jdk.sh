#!/bin/bash

# Architecture and OS
OS="mac"  # Change to "windows" or "mac" as needed
ARCH="aarch64"
# Optional argument to filter JDK versions (e.g., "17" to run only for jdk-17)
version="$1"

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
