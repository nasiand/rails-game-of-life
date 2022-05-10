# Rails Game of Life

A Rails version of the Conway's Game of Life

### problem description

Given a input generation the goal of this kata is to calculate the next generation. The world consists of a two dimensional grid of cells, where each cell is either dead or alive. We assume that the grid is finite and no life can exist off the edges.

The initial state will be provided via a text file that specifies:

- the current generation number
- the grid size
- the population state (* represents a live cell, . represents a dead cell)

Example: 

```
Generation 3:
4 8
........
....*...
...**...
........
```

## Installation

```
rbenv install 2.6.9
bundle install
yarn install
```

## Database Schema

<img width="816" alt="Screenshot 2022-05-10 at 10 28 12" src="https://user-images.githubusercontent.com/74740635/167584684-45182ab5-d3e9-4fc4-862e-e717b15d54fa.png">

## Next Step

- Update Ruby and Rails versions
