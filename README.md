The first step of our hiring process is a small challenge which will give us an idea of your skills and capability.

We will judge by the criteria: Code maintenance, readability, separation of responsibilities and expressiveness of names. You are free to change this project in any way to deliver a production quality code.

The game.rb file is the classic tic-tac-toe. However, the code is a mess and there are several issues that can be improved such as:
- The handling of invalid entries is bad;
- Lack of interactive messages with players.

We would also like to add some new features like:
- Allow the player to choose the level of difficulty, today it is always on hard;
- Allow the choice of different game types (human vs. human, computer vs. computer and human vs. computer) to be possible.

Can you help us finish the game?

Important:
- You will have 7 days to do as much as you can. We know that time is short and very difficult to do everything. But do as much as you can;
- After completion send us a git bundle to raphael@ecoportal.co.nz


# Development log

## Round 6

Some more code love and Development Log.

## Round 5

Terminator arrives.
Start transcribing the "development log".

### Adjustments

Basicaly returned the evaluation code to be more generic, and usable by Machine besides it being *Player 1* or *Player 2*.

And the evaluations follows a more direct path: for every forking path (it just calculates the possible outcomes and weights the available position gives more opportunities to win, as less moves needed better the scoring).

So *HARD* mode is on!

Also some clarifications to User when difficulty mode is set.

## Round 4

Some code loving

### Adjustments
Organization of files into folders.
A more organized arrangement for making development easier
Adde 'Main'

Now, on the root directory of this project, just run:

```Bash
Ruby main
```

Some user interface improvement
Some more ajustments on code, mainly for clarity

## Round 3

Easy difficulty Mode.

### Adjustments

Implemented the Easy mode: the machine just move to first spot available.

## Round 2

Here comes a new challenger!
### Refactoring
Things got a little messy...
As things got more complicated, a I decided to separate some classes into files, to make things easier.

And also created a module so that some methods could be shared between Classes. Game over conditions methods.
And also the characters to be used on this game to sign a player's symbol on the board.

Adjustments to improve reuse.

Review feature, to understand how the game developed, mainly in Machine vs Machine case.


## Round 1

Propper hands on code!

### Refactoring

Some small adjustments on names and separation of responsibility.

Changed the name of players: now there will be only Player 1 and Player 2, and any of them could be either Human or Machine. *Be careful*

Adjusted some variable names like from 'b' to 'board', it is not that it is not understandable, but I preffer some verbosity instead of 'have to stop, a little to remember'

#### Some pauses along the run
As before mentioned, there could have some more messages to the user, and also some usability improvements.

So I added more messages and some 'small' pauses, to give time to user to read some messages and prepare for what will come next.

#### Human vs Human
Seems the easiest case scenario.
I fixed to have it working.


## Round Zero

Setup of IDE and understand the game.

Understanding of *WIN* and *GAME OVER* conditions.

I understood that:
* one of its goals is that there will games:
  * Human vs Human
  * Human vs Machine (Human playing first) *(Go John!!!)*
  * Machine vs Human (Machine playing first)
  * Why not Machine vs Machine *(Terminator continuation feelings)*
* Machine Player has to have level of difficulty.
  * Easy
  * Medium
  * Hard

