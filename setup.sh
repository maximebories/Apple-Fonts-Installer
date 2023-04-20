#!/bin/bash

## Download and install Apple's latest fonts on macOS

# Set the working directory
cd /tmp

# Set the base URL
baseURL="https://devimages-cdn.apple.com/design/resources/download/"

# Set the font image names
fontImages=("SF-Pro.dmg" "SF-Compact.dmg" "SF-Mono.dmg" "NY.dmg")

# Set the font mounted volume names
fontVolumes=("SFProFonts" "SFCompactFonts" "SFMonoFonts" "NYFonts")

# Set the font package names
fontPackages=("SF Pro Fonts.pkg" "SF Compact Fonts.pkg" "SF Mono Fonts.pkg"  "NY Fonts.pkg")

# Download the font images
for image in "${fontImages[@]}"; do
	curl -O "${baseURL}${image}"
done

# Mount the font images
for image in "${fontImages[@]}"; do
	hdiutil attach "${image}"
done

# Silently run the installer for each font package
for i in "${!fontVolumes[@]}"; do
	sudo installer -pkg "/Volumes/${fontVolumes[$i]}/${fontPackages[$i]}" -target /
done

# Unmount the font volumes
for volume in "${fontVolumes[@]}"; do
	hdiutil detach "/Volumes/${volume}"
done

# Remove the font images
for image in "${fontImages[@]}"; do
	rm "${image}"
done