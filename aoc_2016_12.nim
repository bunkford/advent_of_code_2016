import os, tables, strutils

proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)

proc solve1(input:seq[string]):int =
  var reg = {"a":0, "b":0, "c":0, "d":0}.toTable 
  var i:int
  while i <= input.high:
    let instruction = input[i].split(" ")
    let ins = instruction[0]
    let x = instruction[1]
    case ins:
      of "cpy":
        # cpy x y - copies x (either an integer or the value of a register) into register y.
        let y = instruction[2]
        if reg.hasKey(x):
          reg[y] = reg[x]
        else:
          reg[y] = x.parseInt()
      of "inc":
        # inc x - increases the value of register x by one.
        reg[x] += 1 
      of "dec":
        # dec x - decreases the value of register x by one.
        reg[x] -= 1 
      of "jnz":
        # jnz x y - jumps to an instruction y away (positive means forward; negative means backward), but only if x is not zero.
        let y = instruction[2]
        var check:int
        if reg.hasKey(x):
          check = reg[x]
        else:
          check = x.parseInt()
        if check != 0:
          i += y.parseInt()
        else:
          inc(i)
      else:
        discard

    if ins != "jnz": inc(i)
    if i > input.high:
      return reg["a"]

proc solve2(input:seq[string]):int =
  var reg = {"a":0, "b":0, "c":1, "d":0}.toTable 
  var i:int
  while i <= input.high:
    let instruction = input[i].split(" ")
    let ins = instruction[0]
    let x = instruction[1]
    case ins:
      of "cpy":
        # cpy x y - copies x (either an integer or the value of a register) into register y.
        let y = instruction[2]
        if reg.hasKey(x):
          reg[y] = reg[x]
        else:
          reg[y] = x.parseInt()
      of "inc":
        # inc x - increases the value of register x by one.
        reg[x] += 1 
      of "dec":
        # dec x - decreases the value of register x by one.
        reg[x] -= 1 
      of "jnz":
        # jnz x y - jumps to an instruction y away (positive means forward; negative means backward), but only if x is not zero.
        let y = instruction[2]
        var check:int
        if reg.hasKey(x):
          check = reg[x]
        else:
          check = x.parseInt()
        if check != 0:
          i += y.parseInt()
        else:
          inc(i)
      else:
        discard

    if ins != "jnz": inc(i)
    if i > input.high:
      return reg["a"]


var input = get_input(getAppDir() / "aoc_2016_12.txt")

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input)