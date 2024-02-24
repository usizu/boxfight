#!/bin/bash

# 1. Check if build directory exists and create it if not
[ ! -d "build" ] && mkdir build

# 2. Change the working directory to build
pushd build > /dev/null

# 3. Use SWC to compile TypeScript to JavaScript
swc compile ../src/game.ts --out-file game.js
# tsc ../src/game.ts --outfile game.js # Uncomment if using tsc instead

# 5. Copy files from src to build
cp ../src/index.html index.html
cp ../src/styles.css styles.css
# cp ../src/game.js game.js # Uncomment if needed in the future
cp ../src/samjs.min.js samjs.min.js
cp ../src/riffwave.js riffwave.js
cp ../src/sfxr.js sfxr.js

# 4. If "rel" is passed as first argument, minify game.js
if [ "$1" == "rel" ]; then
    # Minify js
    terser game.js -o game.js
fi

# 6. Gzip compress files if "rel" is passed as first argument
if [ "$1" == "rel" ]; then
    gzip -k index.html
    gzip -k game.js
    gzip -k samjs.min.js
    gzip -k riffwave.js
    gzip -k sfxr.js
fi

# Return to the original directory
popd > /dev/null

# Run type checking with TSC
tsc --noEmit