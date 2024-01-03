#!/bin/bash
set -e
set -x

export SQLITE_RELEASE_YEAR=2023
export SQLITE_VERSION=3440200
export SQLITE_OPT="-DSQLITE_ENABLE_DBPAGE_VTAB -DSQLITE_ENABLE_DBSTAT_VTAB -DSQLITE_ENABLE_EXPLAIN_COMMENTS -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_FTS5 -DSQLITE_ENABLE_GEOPOLY -DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_MATH_FUNCTIONS -DSQLITE_ENABLE_OFFSET_SQL_FUNC -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_STAT4 -DSQLITE_ENABLE_STMTVTAB -DSQLITE_ENABLE_UNKNOWN_SQL_FUNCTION -DSQLITE_LIKE_DOESNT_MATCH_BLOBS -DSQLITE_THREADSAFE=0 -DSQLITE_USE_URI"
export SQLITE_OPT="$SQLITE_OPT -DSQLITE_SHELL_FIDDLE -DSQLITE_NOHAVE_SYSTEM"
export CFLAGS="$SQLITE_OPT"

# download sqlite
curl -L "http://sqlite.org/$SQLITE_RELEASE_YEAR/sqlite-amalgamation-$SQLITE_VERSION.zip" --output sqlite.zip
unzip sqlite.zip
mv sqlite-amalgamation-$SQLITE_VERSION/* src
rmdir sqlite-amalgamation-$SQLITE_VERSION
rm -f sqlite.zip

# apply source patch
patch src/shell.c src/shell.diff

# prepare
rm -rf build
mkdir -p build
cd build
wasimake cmake ..
cd ..

# build
cmake --build build
wasm-strip build/sqlite.wasm

# dist
mkdir -p dist
cp build/sqlite.wasm dist/
node_modules/.bin/esbuild src/index.js --minify --target=es2021 --format=esm --outfile=dist/index.js
