# Pixel Chix Desktop Buddy - Decompiled Assets









![PIXEL2](https://github.com/user-attachments/assets/ae15c6c6-2f4b-45c9-8fb9-9151194ca35b)






This repository contains the decompiled source files from a 2006 Pixel Chix desktop buddy application. These files contain the complete source structure needed to recreate or (hopefully) port Pixel Chix to modern platforms.

## Structure

- **frames/** - Timeline frame data
- **scripts/** - ActionScript source code organized by package
- **shapes/** - Vector graphics and shape definitions  
- **sounds/** - Audio files
- **sprites/** - Character animations and sprite definitions
- **symbolClass/** - Symbol linkage information

## Notable Components

The ActionScript code is organized under `com.pixelchix` packages and includes:
- Main application logic (`PixelDesktop`, `Application`)
- Character management (`CharManager`)
- Activity modules (fetch game, guitar playing, rollerblading)
- Animation systems (`AnimGeneric`, `AnimLoop`, `AnimWalk`)
- Utility classes for XML handling and event delegation

## Character Animations

Sprites include various character states and activities:
- Idle animations (idle0-idle7)
- Walking and movement
- Mini-games (fetch, guitar, rollerblading, pong)
- Dress-up system
- Welcome and prompt screens

## Future Plans

Eventually I'd like to rewrite this in C++ or something modern, but tbh that will probably never happen since I tend to get distracted and lose intrest very easily lol 
