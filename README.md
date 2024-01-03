# SQLite WASI build

This is a [WASI](https://wasi.dev/) build of the SQLite shell, compiled with [wasienv](https://github.com/wasienv/wasienv).

It is published as an NPM package [@antonz/sqlite-wasi](https://www.npmjs.com/package/@antonz/sqlite-wasi):

```
https://unpkg.com/@antonz/sqlite-wasi/dist/index.js
https://unpkg.com/@antonz/sqlite-wasi/dist/sqlite.wasm
```

To build from source:

```
bash scripts/install.sh
bash scripts/build.sh
```

SQLite is [public domain](https://sqlite.org/copyright.html).
