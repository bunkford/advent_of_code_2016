import os, strutils, sequtils

# put input into seq
proc get_input(file:string):seq[seq[int]] =
  for line in lines file:
    result.add(line.splitWhiteSpace().map(proc(x: string):int = x.parseInt()))


proc solve1(input:seq[seq[int]]):int =
  for triangle in input:
    var a:int = triangle[0]
    var b:int = triangle[1]
    var c:int = triangle[2]
    if a + b <= c or b + c <= a or a + c <= b: 
      discard
    else:
      inc(result)


proc solve2(input:seq[seq[int]]):int =
  #[
    We recored traingle dimensions down the columns.
    Process 3 at a time because there are 3 columns.
  ]#
  var point:int
  var triangle0, triangle1, triangle2: array[3, int]
  
  for points in input:
    triangle0[point] = points[0]
    triangle1[point] = points[1]
    triangle2[point] = points[2]
    
    inc(point)
    if point == 3: 
      var a:int = triangle0[0]
      var b:int = triangle0[1]
      var c:int = triangle0[2]
      
      if a + b <= c or b + c <= a or a + c <= b: 
        discard
      else:
        inc(result)

      a = triangle1[0]
      b = triangle1[1]
      c = triangle1[2]
      
      if a + b <= c or b + c <= a or a + c <= b: 
        discard
      else:
        inc(result)

      a = triangle2[0]
      b = triangle2[1]
      c = triangle2[2]
      
      if a + b <= c or b + c <= a or a + c <= b: 
        discard
      else:
        inc(result)

      point = 0
    


var input = get_input(getAppDir() / "aoc_2016_03.txt")

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input)
