import os, nre, strutils

# put input into seq
proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)


proc solve1(input:seq[string]):int =
  for line in input:
    block block1:
      var brackets = line.findAll(re"\[.*?\]") # mach everything in brackets
      var not_brackets = line.replace(re"\[.*?\]","|").split("|") # turn brackets into | and split
      for bracket in brackets:
        if bracket[1..^2].findAll(re"([a-z])(?!\1)([a-z])\2\1").len > 0: # check if brackets contain abba sequence, if so skip
          break block1
      for t in not_brackets:
        if t.findAll(re"([a-z])(?!\1)([a-z])\2\1").len > 0: # check if abba sequence exists in strings not in brackets 
          inc(result)
          break block1
        

var input = get_input(getAppDir() / "aoc_2016_07.txt")

echo "Answer Part 1: ", solve1(input)