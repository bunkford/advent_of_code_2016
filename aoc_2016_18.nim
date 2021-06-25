import sequtils

proc solve1(input:string, rows:int):int =
  var lines:seq[string] = @[input]
  for a in 2 .. rows:
    var newline:string
    var safePad = '.' & lines[^1] & '.'
    for i in 1 .. safePad.high - 1:
      var left = if safePad[i-1] == '.': true else: false
      var center = if safePad[i] == '.': true else: false
      var right = if safePad[i+1] == '.': true else: false
      if (left == false and center == false and right == true) or 
        (left == true and center == false and right == false) or 
        (left == false and center == true and right == true) or
        (left == true and center == true and right == false):
          newline &= '^'
      else:
        newline &= '.'
    lines.add(newline)
  
  for line in lines:
    inc(result, line.count('.'))




var input = ".^^^.^.^^^^^..^^^..^..^..^^..^.^.^.^^.^^....^.^...^.^^.^^.^^..^^..^.^..^^^.^^...^...^^....^^.^^^^^^^"

echo "Answer Part 1: ", solve1(input, 40)
echo "Answer Part 2: ", solve1(input, 400000)