import os, nre, strutils, sequtils, tables, algorithm

# put input into seq
proc get_input(file:string):seq[seq[string]] =
  for line in lines file:
    result.add(@[line.match(re"^(.*)-(.*)\[(.*)\]$").get.captures[0], line.match(re"^(.*)-(.*)\[(.*)\]$").get.captures[1], line.match(re"^(.*)-(.*)\[(.*)\]$").get.captures[2]])
   

proc computeChecksum(chars: string): string =
  var hist = initCountTable[char]()
  for c in chars: hist.inc(c)

  proc vkcmp(a, b: char): int =
    # sort by value first, then if they match sort by key
    if hist[a] == hist[b]: return int(a) - int(b)
    return hist[b] - hist[a]  
  
  var res:seq[char]

  for k in hist.keys:
    res.add(k)

  return res.sorted(vkcmp)[0..4].join()


proc solve1(input:seq[seq[string]]):int =
  for room in input:
    if computeChecksum(room[0].replace("-", "")) == room[2]:
      result += room[1].parseInt() # add sector ID


proc solve2(input:seq[seq[string]]):int =
  for room in input:
    if computeChecksum(room[0].replace("-", "")) == room[2]:
      var s:string
      for c in room[0]:
        if c == '-':
            s = s & " "
        else:
          var start_letter = ord(c)
          for i in 0 .. room[1].parseInt() - 1:
            if start_letter == ord('z'): 
              start_letter = ord('a')
            else:
              inc(start_letter)
          
          s = s & $char(start_letter)
        
      if s == "northpole object storage": 
        return room[1].parseInt()



var input = get_input(getAppDir() / "aoc_2016_04.txt")

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input)
