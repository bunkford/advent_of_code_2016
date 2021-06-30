import os, strutils, sequtils, algorithm

proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)


proc solve1(input:seq[string], s:string):string =
  result = s 
  for i in input:
    let words = i.split()
    case words[0]:
      
      of "swap":
        let x = words[2]
        let y = words[5]
        if words[1] == "position":
            # swap position X with position Y
            let tmp = result[x.parseInt()]
            result[x.parseInt()] = result[y.parseInt()]
            result[y.parseInt()] = tmp
        elif words[1] == "letter":
          # swap letter X with letter Y
          result = result.replace(x, "$")
          result = result.replace(y, x)
          result = result.replace("$", y)

      of "rotate":
        if words[1] == "based":
          #rotate right based on position of letter X
          let index = result.find(words[6])
          let extra = if index >= 4: 1 else: 0
          result.rotateLeft(- (1 + index + extra))
        elif words[1] == "left":
          # rotate left X steps
          result.rotateLeft(words[2].parseInt())
        elif words[1] == "right":
          # rotate right X steps
          result.rotateLeft(-words[2].parseInt())
          

      of "reverse":
        # reverse positions X through Y 
        let x = words[2].parseInt()
        let y = words[4].parseInt()
        let t = result.toSeq() 
        result[x .. y] = t.reversed(x, y).join()


      of "move":
        # move position X to position Y
        let x = words[2].parseInt()
        let y = words[5].parseInt()
        let c = result[x]
        result.delete(x,x)
        result.insert($c, y)
      
      else:
        discard
    
proc solve2(input:seq[string], s:string):string =
  var se = s.toSeq()
  se.sort()
  while se.nextPermutation():
    if solve1(input, se.join()) == s:
      return se.join()



let input = get_input(getAppDir() / "aoc_2016_21.txt")

echo "Answer Part 1: ", solve1(input, "fdhbcgea") 
echo "Answer Part 2: ", solve2(input, "fbgdceah") 