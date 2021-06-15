import os, strutils

proc get_input(file:string):string =
  result = readFile file

proc solve1(input:string):int = 
    var decompressed:string
    var marker:string
    var record:bool = true
    var i:int
    while i <= input.high:
      if input[i] == '(':
        var e = input.find(')', i)
        marker = input[i + 1 ..  e - 1]
        decompressed = decompressed & input[e + 1 .. e + marker.split('x')[0].parseInt()].repeat(marker.split('x')[1].parseInt())
        i = e + 1 + marker.split('x')[0].parseInt()
      else:
        decompressed = decompressed & input[i]
        inc(i)

    return decompressed.len

var input = get_input(getAppDir() / "aoc_2016_09.txt")

echo "Answer Part 1: ", solve1(input) 
