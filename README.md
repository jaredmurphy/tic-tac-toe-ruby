# Tic Tac Toe Challenge
An object-oriented Terminal game written in Ruby

# Usage
1. clone this repo
2. in the main directory run `ruby lib/game.rb`
3. follow the prompts
4. have fun!

# winner detection
The `CheckForWinner` class checks to see if either player has met a requirement for winning after each turn

The algorithm is based on adding up all of the values from each tile in a given row

Each tile has a value which is `1` if the tile is `X`, `-1` if the tile is `O`, or `0` if the tile is blank still

Given the size of the grid, any completed row that has been played by only one player will have a total equal to the size of the grid.

Example:
```
grid_values = [
  [1, 0, -1],
  [0, 1, -1],
  [-1, 0, 1]
]
```
Given that the size of the grid is 3x3, we can look for any row, column, or diagonal whose total is equal to 3

We can see that `X`, or the player whose tiles are valued at `1`, has a diagonal win from top left to bottom right of the matrix

1 + 1 + 1 = 3 and so we have a winner.

The tricky thing with this approach was finding something reusable to determine if there was a winner for every type of case

The `check_rows` method takes in a 2 dimensional array and determines if either row gives us a winner. This works out nicely for getting the rows (horizontal wins) taken care of right off the bat. However, to use this method for columns (horizontal wins), I needed to rotate the grid 90 deg and then pass it in to `check_rows`.

For grabbing the diagonal wins, I needed to map over the grid and return only the values at each given index for both rows and columns. So, while the index is at 0, we would get grid_values[0][0], which is 1, and this moves from the top left to the bottom right.

For grabbing the reverse diagonal wins, I needed to map over the grid similarly, however I needed to move from the top right to the bottom left. The solution was maintaining an index as I had done for the regular diagonals but also keeping a `j` variable which started at the back of each row and moved closer to the front on each iteration. In the above example, the reverse diagonals would have been [-1, 1, -1]
