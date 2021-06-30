import os, algorithm, strutils, sequtils

proc get_input(file:string):seq[(BiggestInt, BiggestInt)] =
  for line in lines file:
    let r = line.split("-").mapIt(it.parseBiggestInt())
    result.add((r[0], r[1]))


proc solve1(input:seq[(BiggestInt, BiggestInt)]):BiggestInt =
  var record = input
  record.sort()
  var mx = record[0][1]
  for r in record:
    if r[0] > mx + 1:
      return mx + 1
    else:
      mx = max(mx, r[1])

proc solve2(input:seq[(BiggestInt, BiggestInt)]):BiggestInt =
  var record = input
  record.sort()
  var mn = record[0][0]
  var mx = record[0][1]
  var tot: BiggestInt
  for r in record:
    if r[0] > mx + 1:
      tot += mx - mn + 1
      mn = r[0]
      mx = r[1]
    else:
      mx = max(mx, r[1])
  return 4294967296 - tot - (mx - mn + 1)
  

let input = get_input(getAppDir() / "aoc_2016_20.txt")

echo "Answer Part 1: ", solve1(input) 
echo "Answer Part 2: ", solve2(input)