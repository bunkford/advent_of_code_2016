#[
    Disc #1 has 13 positions; at time=0, it is at position 11.
    Disc #2 has 5 positions; at time=0, it is at position 0.
    Disc #3 has 17 positions; at time=0, it is at position 11.
    Disc #4 has 3 positions; at time=0, it is at position 0.
    Disc #5 has 7 positions; at time=0, it is at position 2.
    Disc #6 has 19 positions; at time=0, it is at position 17.
]#
proc d1(t:int):bool = return (t+11) mod 13 == 0
proc d2(t:int):bool = return (t+0) mod 5 == 0
proc d3(t:int):bool = return (t+11) mod 17 == 0
proc d4(t:int):bool = return (t+0) mod 3 == 0
proc d5(t:int):bool = return (t+2) mod 7 == 0
proc d6(t:int):bool = return (t+17) mod 19 == 0

# disc added in part 2
proc d7(t:int):bool = return (t+0) mod 11 == 0

proc solve1():int = 
  while true:
      if d1(result+1) and d2(result+2) and d3(result+3) and d4(result+4) and d5(result+5) and d6(result+6):
          return
      inc(result)

proc solve2():int = 
  while true:
      if d1(result+1) and d2(result+2) and d3(result+3) and d4(result+4) and d5(result+5) and d6(result+6) and d7(result+7):
          return
      inc(result)
echo "Answer Part 1: ", solve1()
echo "Answer Part 2: ", solve2()

