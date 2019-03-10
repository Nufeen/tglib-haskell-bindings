# tglib-haskell-bindings

[Telegram library](https://github.com/tdlib/td#using-json) haskell bindings example. Examples in other languages can be found [here](https://github.com/tdlib/td/tree/master/example)

This example considers prebuilt dynamic `libtdjson.[so|dylib|dll]` in `lib` folder.

# To execute:

1. [Build tdlib](https://core.telegram.org/tdlib/docs/#building) or get precompiled binaries.

2. `stack ghci --ghci-options -ltdjson`

# To build:

```
stack build --ghc-options -ltdjson
```

In case of Mac OS you may need to specify lib path before execution:

```
export DYLD_LIBRARY_PATH=lib
```

# Notes

This may be useful: https://github.com/Bannerets/tdlib-binaries

The copy of build instructions (they are a bit different) can be also found here: https://github.com/tdlib/td#building

td_json_client.h File Reference: https://core.telegram.org/tdlib/docs/td__json__client_8h.html

Check this fork, much more complex:  https://github.com/egormkn/tdlib-haskell-bindings


### Mac OS OpenSSL issues:

https://stackoverflow.com/a/29792635

MacOS uses LibreSSL by default. If you have issues with it you can try switch to openssl like:

```
export PATH="/usr/local/etc/openssl/bin:$PATH"
```

Use `openssl version` to ensure which lib is actually used.
