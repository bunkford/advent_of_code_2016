import os, sequtils, strutils, tables, algorithm

type
  Bot* = object
    number: int
    chips*: seq[int]

proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)

proc solve1(input:seq[string] , target_comparison: seq[int]):int =
  var bots = initTable[int, seq[int]]()

  proc check_for_two(bots: var Table[int, seq[int]], from_bot: int, s:seq[int]) =
    if s.len == 2:
      for line in input:
        if line[0..2] == "bot":
          var bot = line.split(" ")[1].parseInt()

          if from_bot == bot:
            var give_low_to = line.split(" ")[6].parseInt()
            var give_high_to = line.split(" ")[^1].parseInt()

            if bots.hasKeyOrPut(give_low_to, @[s.min]):
              bots[give_low_to].add(s.min)
            if bots.hasKeyOrPut(give_high_to, @[s.max]):
              bots[give_high_to].add(s.max)

            bots[from_bot] = @[]

  for line in input: # initialize bots
    if line[0..2] != "bot": 
      var val = line.split(" ")[1].parseInt()
      var tobot = line.split(" ")[^1].parseInt()
      
      if bots.hasKeyOrPut(toBot, @[val]):
        bots[tobot].add(val)


  while true: # do moves until we get match for answer
    var b = bots
    for k, v in b:
      if v.sorted(system.cmp) == target_comparison.sorted(system.cmp): return k
      check_for_two(bots, k, v)


proc solve2(input:seq[string]):int =
  var bots = initTable[int, seq[int]]()
  var output = initTable[int, seq[int]]()

  proc check_for_two(bots: var Table[int, seq[int]], output: var Table[int, seq[int]], from_bot: int, s:seq[int]) =
    if s.len == 2:
      for line in input:
        if line[0..2] == "bot":
          var bot = line.split(" ")[1].parseInt()

          if from_bot == bot:
            var low_output_or_bot = line.split(" ")[5]
            var give_low_to = line.split(" ")[6].parseInt()
            var high_output_or_bot = line.split(" ")[^2]
            var give_high_to = line.split(" ")[^1].parseInt()
            
            if low_output_or_bot == "bot":
              if bots.hasKeyOrPut(give_low_to, @[s.min]):
                bots[give_low_to].add(s.min)
            else:
              if output.hasKeyOrPut(give_low_to, @[s.min]):
                output[give_low_to].add(s.min)

            if high_output_or_bot == "bot":    
              if bots.hasKeyOrPut(give_high_to, @[s.max]):
                bots[give_high_to].add(s.max)
            else:
              if output.hasKeyOrPut(give_high_to, @[s.max]):
                output[give_high_to].add(s.max)

            bots[from_bot] = @[]

  for line in input: # initialize bots
    if line[0..2] != "bot": 
      var val = line.split(" ")[1].parseInt()
      var tobot = line.split(" ")[^1].parseInt()
      
      if bots.hasKeyOrPut(toBot, @[val]):
        bots[tobot].add(val)

  while true: # do moves until we get match for answer
    var b = bots
    for k, v in b:
      if output.hasKey(0) and output.hasKey(1) and output.hasKey(2):
        return output[0][0] * output[1][0] * output[2][0]
      check_for_two(bots, output, k, v)


var input = get_input(getAppDir() / "aoc_2016_10.txt")

echo "Answer Part 1: ", solve1(input, @[17, 61])
echo "Answer Part 2: ", solve2(input,)
