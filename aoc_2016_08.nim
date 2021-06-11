import os, strutils, sequtils, algorithm, osproc


# put input into seq
proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)

proc solve1(input:seq[string]): int =
  var screen: array[6, array[50, int]]
  for instruction in input:

    case instruction.split(" ")[0]:
      of "rect":
        var dims = instruction.split(" ")[1].split("x")
        for y in 0 .. dims[1].parseInt() - 1: # tall
          for x in 0 .. dims[0].parseInt() - 1: # wide
            screen[y][x] = 1

      of "rotate":
        var a = instruction.split(" ")[2].replace("y=", "").replace("x=", "").parseInt()
        var b = instruction.split(" ")[4].parseInt()
        case instruction.split(" ")[1]:
          of "row":
            screen[a].rotateLeft(-b) # negative number to rotate to the right

          of "column":
            var col:string
            for r in screen:
              col = col & $r[a]

            var rotated = toSeq(col).map(proc(x:char):int = parseint($x)).rotatedLeft(-b) # negative number to rotate to the right
            for r in 0 .. screen.high:
              screen[r][a] = rotated[r]


          else:
            echo "Wrong rotate command"

      else:
        echo "Error: unkown instruction"

    
    discard execCmd "clear"
    for row in screen:
      echo row
    sleep(10)
    
  
  for row in screen:
    result += row.count(1) # high 151 
  

var input = get_input(getAppDir() / "aoc_2016_08.txt")

echo "Answer Part 1: ", solve1(input)