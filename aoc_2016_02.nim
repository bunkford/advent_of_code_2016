import os

# put input into seq
proc get_input(file:string):seq[string] =
  var input: seq[string]
  for line in lines file:
      input.add(line)
  return input

proc solve1(input:seq[string]): string =
  var keys:array[3,array[3, int]]
  keys[0] = [1, 2, 3]
  keys[1] = [4, 5, 6]
  keys[2] = [7, 8, 9]

  var pos = [1, 1]

  for line in input:
    for letter in line:
      case letter:
        of 'U':
          if pos[1] != 0: pos[1] -= 1 
        of 'D':
          if pos[1] != 2: pos[1] += 1
        of 'L':
          if pos[0] != 0: pos[0] -= 1
        of 'R':
          if pos[0] != 2: pos[0] += 1
        else:
          return "Error"
      
    result = result & $keys[pos[1]][pos[0]]


proc solve2(input:seq[string]): string =
  var keys:array[5,array[5, string]]
  keys[0] = [" ", " ", "1", " ", " "]
  keys[1] = [" ", "2", "3", "4", " "]
  keys[2] = ["5", "6", "7", "8", "9"]
  keys[3] = [" ", "A", "B", "C", " "]
  keys[4] = [" ", " ", "D", " ", " "]

  var pos = [0, 2]
  
  for line in input:
    for letter in line:
      case letter:
        of 'U':
          if pos[1] != 0 and keys[pos[1] - 1][pos[0]] != " ": pos[1] -= 1 
        of 'D':
          if pos[1] != 4 and keys[pos[1] + 1][pos[0]] != " ": pos[1] += 1
        of 'L':
          if pos[0] != 0 and keys[pos[1]][pos[0] - 1] != " ": pos[0] -= 1
        of 'R':
          if pos[0] != 4 and keys[pos[1]][pos[0] + 1] != " ": pos[0] += 1
        else:
          return "Error"
      
    result = result & $keys[pos[1]][pos[0]]


var input = get_input(getAppDir() / "aoc_2016_02.txt")

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input)
