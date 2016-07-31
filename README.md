# ocaml-minilibx

**Not finished**

Bindings OCaml to minilibx library.

## What is minilibx?

Minilibx is a very basic graphical library writting in C used in
[42](https://www.42.fr) (also exported in US in the Silicon Valley, see [42
US](https://www.42.us.org)) and in [Epitech](http://www.epitech.eu/) for infography
project such like *fdf* and *Raytracer*.

This library is based on [X.org](www.x.org) and there is also a native version
for Mac OSX. You can find the source of the
library in [this mirror](https://github.com/dannywillems/minilibx) (and
[here](https://github.com/dannywillems/minilibx-mac-osx) for the native version
for Mac OSX).

## Tutorials

Here some tutorials and articles (in French):
* [Installation and basic usage](https://achedeuzot.me/2014/12/20/installer-la-minilibx/)
* [Manual](http://thomas.tissotdupont.free.fr/MinilibX%20Manual/)

## How to install?

You can use opam to install:
```
opam pin add ocaml-minilibx https://github.com/dannywillems/ocaml-minilibx.git
```

Else, a Makefile is provided and you need ocamlfind to install.

```
make build
make install
```

The library is available in native and bytecode.

## Binding organization/documentation

TODO

## Licence

Licence GPLv3

Minilibx
======================================

Interface OCaml à la librairie minilibx.

## Qu'est-ce que minilibx ?

Minilibx est une librairie graphique très basique écrite en C utilisée à
[42](https://42.fr) (aussi exporté aux USA dans la Silicon Valley, voir [42
US](https://42.us.org)) et à [Epitech](http://www.epitech.eu) pour les projets
d'infographie tel que *fdf* et *Raytracer*.

Cette librarie est basé sur [X.org](www.x.org) et il existe également une
version native pour Mac OSX. Vous pouvez trouver les sources de la librairie
[ici](https://github.com/dannywillems/minilibx) et
[ici](https://github.com/dannywillems/minilibx-mac-osx) pour la version native
pour Mac OSX.

## Tutoriels

Ici des articles et des tutoriels (en français):

* [Installation et utilisation basique](https://achedeuzot.me/2014/12/20/installer-la-minilibx/)
* [Manuel](http://thomas.tissotdupont.free.fr/MinilibX%20Manual/)

## Comment installer?

Vous pouvez utiliser opam pour installer:
```
opam pin add ocaml-minilibx https://github.com/dannywillems/ocaml-minilibx.git
```

Sinon, un Makefile est fourni et vous avez besoin d'ocamlfind pour installer.
```
make build
make install
```

La librairie est disponible en natif et en bytecode.

## Organisation/documentation du binding.

TODO

## License

License GPLv3
