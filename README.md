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
line up text

options:
      --help   print usage
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
