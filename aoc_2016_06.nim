import os, tables

# put input into seq
proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(@[line])

proc solve1(input:seq[string]):string =
  for i in 0 .. input[0].high:
    var char_count = initCountTable[char]() 
    for row in input:
      char_count.inc(row[i])
    result = result & char_count.largest().key

proc solve2(input:seq[string]):string =
  for i in 0 .. input[0].high:
    var char_count = initCountTable[char]() 
    for row in input:
      char_count.inc(row[i])
    result = result & char_count.smallest().key

var input = get_input(getAppDir() / "aoc_2016_06.txt")

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input)