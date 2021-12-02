import os, strutils, nre, sequtils, algorithm

type 
  Node = object
    id: string
    x:int
    y:int
    size:int
    used:int
    avail:int
    pct:int
    
proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)



proc solve1(input:seq[string]):int =
  var nodes: seq[Node]
  for i in 2 .. input.high:
    let split = input[i].find(re"node\-(x\d+\-y\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%").get.captures
    let xy = split[0].find(re"x(\d+)\-y(\d+)").get.captures
    
    var node = Node(id: split[0], x: xy[0].parseInt(), y: xy[1].parseInt(), size: split[1].parseInt(), used: split[2].parseInt(), avail: split[3].parseInt(), pct: split[4].parseInt())
    nodes.add(node)
  
  for node1 in nodes:
    for node2 in nodes:
        if node1.id == node2.id:
          continue
        if node1.used == 0:
          continue
        if node1.used <= node2.avail:
          inc(result)

proc taxi_cab(a:(int, int), b:(int, int)):int =
  var x1:int = a[0]
  var y1:int = a[1]
  var x2:int = b[0]
  var y2:int = b[1]
  return abs(x2 - x1) + abs(y2 - y1)

proc solve2(input:seq[string]):int =
  # I was stumped and used narimiran's python logic to solve this
  # https://github.com/narimiran/advent_of_code_2016/blob/master/python/day_22.py

  # Figure out size of grid. Largest x, y are at the bottom of the file
  let size_x = input[^1].find(re"node\-x(\d+)\-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%").get.captures[0].parseInt() + 1 
  let size_y = input[^1].find(re"node\-x(\d+)\-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%").get.captures[1].parseInt() + 1 

  var grid = newSeqWith(size_y, newSeqWith[char](size_x, '.'))

  var start_y:int 
  var wall_y:int

  for i in 2 .. input.high:
    let split = input[i].find(re"node\-x(\d+)\-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%").get.captures
    let x = split[0].parseInt() # x
    let y = split[1].parseInt() # y
    let u = split[3].parseInt() # used

    if u > 100:
      grid[y][x] = '#'
      wall_y = y
    elif u == 0:
      grid[y][x] = '_'
      start_y = y

  grid[0][^1] = 'G'
  grid[0][0] = 'F'


  echo "Storage Map:"
  for line in grid:
    echo line.join()


  var start = (grid[start_y].find('_'), start_y) # location of _
  echo "Start: ", start
  var wall = (grid.len - wall_y, grid[wall_y].find('#') - 1) # location of wall #
  echo "Wall: ", wall
  var goal = (0, grid[0].len - 1)
  echo "Goal: ", goal

  result = taxi_cab(start, wall)
  result.inc(taxi_cab(wall, goal))
  result.inc(5 * (goal[1] - 1))

  
let input = get_input(getAppDir() / "aoc_2016_22.txt")

echo "Answer Part 1: ", solve1(input) # 901

echo "Answer Part 2: ", solve2(input) # 238
