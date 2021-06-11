import md5

proc solve1(input: string):string =
  var index:int = 0
  var hash = $tomd5(input & $index)

  while result.len < 8:
    while $hash[0..4] != "00000":
      hash = $tomd5(input & $index)
      inc(index)

    result = result & $hash[5]
    inc(index)
    hash = $tomd5(input & $index)


const input = "ffykfhsq"

echo "Answer Part 1: ", solve1(input)


