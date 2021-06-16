import sequtils

# this doesn't work with all inputs.. 
# works on mine because you can always move two items up

proc solve(items: var seq[int]):int =
  while items[^1] != items.foldl(a + b):
    var lowest_floor = 0
    while items[lowest_floor] == 0:
      inc(lowest_floor)
    inc(result, 2 * (items[lowest_floor] - 1) - 1)
    items[lowest_floor + 1] = items[lowest_floor + 1] + items[lowest_floor]
    items[lowest_floor] = 0


var a = @[4, 2, 4, 0] # number of items on floor
var b = @[8, 2, 4, 0] # number of items on floor
echo "Answer Part 1: ", solve (a) 
echo "Answer Part 2: ", solve (b) 