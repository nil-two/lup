lup
===

Line up text.

```
$ cat src.txt
Name Power Toughness
Ghitu_Lavarunner 1 2
Viashino_Pyromancer 2 1
Goblin_Chainwhirler 3 3

$ cat src.txt | lup
Name                Power Toughness
Ghitu_Lavarunner    1     2
Viashino_Pyromancer 2     1
Goblin_Chainwhirler 3     3
```

Usage
-----

```
usage: lup [<option(s)>] [<file(s)>]
line up lines.

options:
  -c, --count=COUNT     separate lines only COUNT times
  -i, --keep-indent     keep the first indent as indents
  -s, --separator=SEP   separate lines by SEP
      --help            print usage
```

Requirements
------------

- Perl (5.8.0 or later)

Installation
------------

1. Copy `lup` into your `$PATH`.
2. Make `lup` executable.

### Example

```
$ curl -L https://raw.githubusercontent.com/kusabashira/lup/master/lup > ~/bin/lup
$ chmod +x ~/bin/lup
```

Note: In this example, `$HOME/bin` must be included in `$PATH`.

Options
-------

### -c, --count=COUNT

Separate lines only COUNT times.

```
$ cat src.txt
name    = Ancestral Recall
  oracle_text =         Target player draws three cards.

$ cat src.txt | lup -c2
name        = Ancestral Recall
oracle_text = Target player draws three cards.
```

### -i, --keep-indent

Keep the first indent as indents.

```
$ cat src.txt
    let a = 10;
      let b     = 20;
let c =   30;

$ cat src.txt | lup -i
    let a = 10;
    let b = 20;
    let c = 30;
```

### -s, --separator=SEP

Separate lines by SEP.

```
$ cat src.txt
Name=Duress
cmc    =1
type_line= Sorcery
oracle_text  = Target opponent reveals their hand. You choose a noncreature, nonland card from it. That player discards that card.

$ cat src.txt | lup -s=
Name        = Duress
cmc         = 1
type_line   = Sorcery
oracle_text = Target opponent reveals their hand. You choose a noncreature, nonland card from it. That player discards that card.
```

### --help

Print usage.

```
$ lup --help
(Print usage)
```

License
-------

MIT License

Author
------

nil2 <nil2@nil2.org>
