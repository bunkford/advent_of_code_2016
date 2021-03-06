
import os, strutils, tables

# put input into seq
proc get_input(file:string):seq[string] =
  var input: seq[string]
  for line in lines file:
    for d in line.split(", "):
      input.add(d)
  return input

proc solve1(input: seq[string]):int =
  var coords: array[2, int]
  var d = ["N", "E", "S", "W"]
  var dir = {"N": [0, 1], "S": [0, -1], "E": [1, 0], "W": [-1, 0]}.toTable # [x, y]
  var current = 0 # assert d[0] == "N"

  for direction in input:
    var turn = direction[0 .. 0]
    var steps = direction[1 .. ^1]
    case turn:
      of "R":
        if current < 3: inc(current)
        else: current = 0
      of "L":
        if current > 0: dec(current)
        else: current = d.high 
    
    var x = d[current]
    var i = dir[x]
    coords[0] += (i[0] * steps.parseInt)
    coords[1] += (i[1] * steps.parseInt)
  
  #[ 
    Taxicab Distance between (x1, y1) and (x2, y2) = |x2 - x1| + |y2 - y1|
    * notation between pipes is absolute value (negatives become positives, eg, -100 becomes 100)
    We started at [0, 0], so all we have to do is add the absolute values of coordinates.
  ]# 
  result = abs(coords[0]) + abs(coords[1])


proc solve2(input: seq[string]):int =
  var coords: array[2, int]
  var d = ["N", "E", "S", "W"]
  var dir = {"N": [0, 1], "S": [0, -1], "E": [1, 0], "W": [-1, 0]}.toTable # [x, y]
  var current = 0 # assert d[0] == "N"
  var clist: seq[array[2, int]]

  clist.add([0,0])
  for direction in input:
    var turn = direction[0 .. 0]
    var steps = direction[1 .. ^1]
    case turn:
      of "R":
        if current < 3: inc(current)
        else: current = 0
      of "L":
        if current > 0: dec(current)
        else: current = d.high 
    
    var x = d[current]
    var i = dir[x]
    for d in 1 .. steps.parseInt:
      coords[0] += i[0]
      coords[1] += i[1]

      if coords in clist:
        return abs(coords[0]) + abs(coords[1])

      clist.add(coords) 


var input = get_input(getAppDir() / "aoc_2016_01.txt")

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input)



