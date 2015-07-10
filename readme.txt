RULES:

BOARD:
The game is played on an NxM Grid, where both N and M are randomly generated on a per game basis.

FOOD:
A piece of food will be randomly placed on the board. Every timea piece of food is eaten, a new piece of food is placed.

SNAKES:
start:
At the start of each game, each player has a snake created. The snake has a starting length of three,
and is randomly placed on the board. The only constraint is that the snake will be spawned 5 units
away from any other snake.

MOVING:
Each turn, each snake will be able to move 1 unit. If he lands of a piece of food, the snake will grow
by a single unit. If the snakes lands on a occupied space (including the boundaries of the board),
the snake will die. Occupied spaces include tiles occupied by your snakes and other snakes (alive or dead).

CORNER CASES: 
-If two snakes land on the same tile on the same turn, both snakes will die.
-If a snake turns back on itself, the snake dies (if it does a 180 turn)

SCORING:
Each turn that your snake is alive, it's length will be added to it score. No score is added on the turn
snake dies.

STARVATION:
Every N times a food is picked up, if your snake has not gotten ANY food in the last N turns it loses 1 length;
where N is the number of players whenthe game started. If your snake reaches a length of 0 it dies.

CARCASSES:
When a snake dies it leaves a carcass! This can be used to trap other snakes or block off part of the board.

WINNING:
The game ends when all snakes are dead or when only 1 snake is alive AND it has the highest score. 

-------------

Command line interface:

Done through command line
Initialization
 (0) Your player ID
-->Allows you to initialize any necessary files.
Example: ruby greedy_ai -i 0

Inputs to AI:
 (0) Your player ID
 (1) Board Width,Board Height, Number of Snakes
 (2) Food Location x,Food Location Y
 (3) Player(owner) ID,Alive/Dead,Score,Snake Head,...,Snake Tail #send alive players first then dead
 (4) ...repeat for all snakes -> Coordinates are of form x,y => ID,Score,x,y,x1,y2,x2,x3,y3,...
Note: Lists are comma separated, inputs are space separated
Example (3 players): ruby greedy_ai -s 0 46,78,3 39,49 0,1,0,12,63,13,63,14,63 1,1,0,7,3,8,3,9,3 2,1,0,29,16,28,16,27,16

Output from AI: "up","down","left" or "right"

--------------

Running the game:
From the rhumba/src/ folder:
ruby main Dave,'ruby greedy_ai' Bob,'ruby greedy_ai'

-------

Using the GUI:
From the rhumba/src/ folder:
ruby ../gui/gui_main 0.game

Controls:
Left Arrow Key: Step back one frame
Right Arrow Key: Step forward one frame
Down Arrow Key (press and hold): Step through multiple frames
P: Play through entire replay
S: Go to first frame (start)
E: Go to last frame (end)
