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


## Round 0

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

### Refactoring

Some small adjustments on names and separation of responsibility

Changed the name of players: now there will be only Player 1 and Player 2, and any of them could be either Human or Machine. *Be careful*

Adjusted some variable names like from 'b' to 'board', it is not that it is not understandable, but I preffer some verbosity instead of 'have to stop, a little to remember'

#### Some pauses along the run
As before mentioned, there could have some more messages to the user, and also some usability improvements.

So I added more messages and some 'small' pauses, to give time to user to read some messages and prepare for what will come next.

#### Human vs Human
Seems the easiest case scenario.
I fixed to have it working.