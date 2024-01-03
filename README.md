# SQLite WASI build

This is a [WASI](https://wasi.dev/) build of the SQLite shell, compiled with [wasienv](https://github.com/wasienv/wasienv).

It is published as an NPM package [@antonz/sqlite-wasi](https://www.npmjs.com/package/@antonz/sqlite-wasi):

```
https://unpkg.com/@antonz/sqlite-wasi/dist/index.js
https://unpkg.com/@antonz/sqlite-wasi/dist/sqlite.wasm
```

## Usage

Using the [Runno](https://github.com/nalgeon/runno) runtime:

```js
import sqlite from "https://unpkg.com/@antonz/sqlite-wasi/dist/index.js";
import { WASI } from "https://unpkg.com/@antonz/runno/dist/runno.mjs";

const wasm = sqlite.load();
const result = await WASI.start(wasm, {
    args: ["sqlite3", "-version"],
    stdout: (out) => console.log(out),
    stderr: (err) => console.error(err),
});
console.log("exit code =", result.exitCode);
```

Result:

```
3.44.2 2023-11-24 11:41:44 ...
exit code = 0
```

## Building from source

```
bash scripts/install.sh
bash scripts/build.sh
```

## License

Copyright 2024 [Anton Zhiyanov](https://antonz.org/), MIT License.

SQLite is [public domain](https://sqlite.org/copyright.html).
