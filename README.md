lup
===

![CI](https://github.com/nil-two/lup/workflows/CI/badge.svg)

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
$ lup [<option(s)>] [<file(s)>]
line up text.

options:
  -c, --count=COUNT     separate lines only COUNT times
  -i, --keep-indent     keep the first indent as indents
  -m, --margin=N        put N spaces between cells
  -p, --pack-separator  pack separator cells and non-separator cells
  -s, --separator=SEP   separate lines by SEP
      --help            print usage and exit
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
$ curl -L https://raw.githubusercontent.com/nil-two/lup/master/lup > ~/bin/lup
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

### -m, --margin=N

Put N spaces between cells.

```
$ cat src.txt
server_name     localhost;
  listen 80;

$ cat src.txt | lup -m2
server_name  localhost;
listen       80;
```

### -p, --pack-separator

Pack separator cells and non-separator cells.
```
$ cat src.txt
x,y,z
10,20,30
 40,  50,   60
70   ,  80  ,90
100 , 110 , 120

$ cat src.txt | lup -ps=
x,   y,   z
10,  20,  30
40,  50,  60
70,  80,  90
100, 110, 120
```

### -s, --separator=SEP

Separate lines by SEP.

```
$ cat src.txt
name=Duress
cmc    =1
type_line= Sorcery
oracle_text  = Target opponent reveals their hand. You choose a noncreature, nonland card from it. That player discards that card.

$ cat src.txt | lup -s=
name        = Duress
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
