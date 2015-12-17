### HackBoy 3000
HackBoy 3000 is a solver for the terminal hacking mini-game in the Fallout series of
video games. 

This repository includes a command-line version of the tool as well as a version
written for the web. 

## Using HackBoy 3000 on the command line
```
$ ruby terminal_hack.rb
```

Available options:
```
$ ruby terminal_hack.rb -v (verbose mode)
```

You can also feed a file containing a list of games into `test_terminal_hack.rb`:
```
$ ruby test_terminal_hack.rb games/games.txt
100 tests completed.
Median attempts to win: 2.5
Average attempts to win: 2.5
Max attempts to win: 5
```

`test_terminal_hack.rb` can also be passed the `-v` flag.

## Building the web version
Running
```
$ make
```
will compile the .coffee and .scss files into .js and .css files and place them
into the `/public` directory.
