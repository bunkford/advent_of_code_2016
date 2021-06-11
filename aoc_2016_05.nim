import md5, strutils

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

proc solve2(input: string):array[8, char] =
  var index:int = 0
  var hash = $tomd5(input & $index)

  while '\x00' in result:
    while $hash[0..4] != "00000":
      hash = $tomd5(input & $index)
      inc(index)

    var i:int
    if hash[5].isDigit():
      i = parseInt($hash[5])
      if i <= result.high and result[i] == '\x00':
          var digit = hash[6]
          result[i] = digit
    
    inc(index)
    hash = $tomd5(input & $index)


const input = "ffykfhsq"

echo "Answer Part 1: ", solve1(input)
echo "Answer Part 2: ", solve2(input).join()