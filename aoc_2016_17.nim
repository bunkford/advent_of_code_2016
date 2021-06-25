import md5

type
  Stack = object
    x:int
    y:int
    dir:string

proc solve1(input:string): string = 
  var stack:seq[Stack] = @[Stack(x:0, y:0, dir:"")]
  var open:array[5, char] = ['b', 'c', 'd', 'e', 'f']

  while stack.len > 0:
    var pos = stack[0]
    stack.delete(0)

    if pos.x == 3 and pos.y == 3:
      return pos.dir

    var hash = getMD5(input & pos.dir)

    if pos.y - 1 >= 0 and hash[0] in open: stack.add(Stack(x:pos.x, y:pos.y - 1, dir:pos.dir & 'U'))
    if pos.y + 1 <= 3 and hash[1] in open: stack.add(Stack(x:pos.x, y:pos.y + 1, dir:pos.dir & 'D'))
    if pos.x - 1 >= 0 and hash[2] in open: stack.add(Stack(x:pos.x - 1, y:pos.y, dir:pos.dir & 'L'))
    if pos.x + 1 <= 3 and hash[3] in open: stack.add(Stack(x:pos.x + 1, y:pos.y, dir:pos.dir & 'R'))


proc solve2(input:string): int = 
  var stack:seq[Stack] = @[Stack(x:0, y:0, dir:"")]
  var open:array[5, char] = ['b', 'c', 'd', 'e', 'f']

  while stack.len > 0:
    var pos = stack[0]
    stack.delete(0)

    if pos.x == 3 and pos.y == 3:
      result = pos.dir.len
      continue

    var hash = getMD5(input & pos.dir)

    if pos.y - 1 >= 0 and hash[0] in open: stack.add(Stack(x:pos.x, y:pos.y - 1, dir:pos.dir & 'U'))
    if pos.y + 1 <= 3 and hash[1] in open: stack.add(Stack(x:pos.x, y:pos.y + 1, dir:pos.dir & 'D'))
    if pos.x - 1 >= 0 and hash[2] in open: stack.add(Stack(x:pos.x - 1, y:pos.y, dir:pos.dir & 'L'))
    if pos.x + 1 <= 3 and hash[3] in open: stack.add(Stack(x:pos.x + 1, y:pos.y, dir:pos.dir & 'R'))

let input = "awrkjxxr"

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 1: ", solve2(input)