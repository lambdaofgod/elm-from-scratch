# Elm from scratch

**What you'll need to get started with Elm and it's Intellij IDEA plugin**

### Prerequisites 
You'll need to [install Elm](https://guide.elm-lang.org/install.html).

[IDEA plugin](https://github.com/durkiewicz/elm-plugin) is obtainable from IDEA itself.

### Project setup
You set up project sources with 

```buildoutcfg
elm-package install
```
Now IDEA is able to see your dependencies' code, so you can use the plugin's capabilities.

Elm tools will fetch dependencies from *elm-package.json* and create *elm-stuff* directory and place the needed sources inside.

### Compiling to HTML
```buildoutcfg
elm-make src/HelloWorld.elm --output html/index.html
```
Compiles hello world program to HTML.

### Compiling to JS

```buildoutcfg
elm-make src/MoreInvolved.elm --output html_and_js/more_involved.js
```

Will compile `MoreInvolved` to appropriate javascript code. This script can be then accessed, like in [html_and_js/index.html](https://github.com/lambdaofgod/elm-from-scratch/blob/master/html_and_js/index.html).

### Testing

To run tests you'd need to install `elm-test` npm and elm packages.

```
npm install -g elm-test
elm-package install elm-community/elm-test
```

If you don't have any tests you can use `elm-test init` to setup appropriate directory (it's called *tests* by default) and even write an example stub test.
