proc reverse(s: var string) =
  for i in 0 .. s.high div 2:
    swap(s[i], s[s.high - i])

proc swap1and0(s: var string) =
  for i in 0 .. s.high:
    if s[i] == '1': s[i] = '0'
    elif s[i] == '0': s[i] = '1'

proc newChecksum(s:string):string =
  ## for some reason this is much faster
  for i in countup(0, s.high, 2):
    if s[i] == s[i + 1]:
        result &= '1'
    else:
        result &= '0'

proc checksum(s: string):string =
  for i in countup(0, s.high, 2):
    if s[i] & s[i+1] == "00" or s[i] & s[i+1] == "11":
      result = result & $1
    else:
      result = result & $0

proc solve1(input:string, size: int):string =
  var a = input
  while a.len < size: # disk size
    var b = a
    b.reverse()
    b.swap1and0()
    a = a & $0 & b
  
  var checksum = newChecksum(a[0..size-1])
  while checksum.len mod 2 == 0:
    checksum = newChecksum(checksum)
  return checksum


let input = "10011111011011001"

echo "Answer Part 1: ", solve1(input, 272)
echo "Answer Part 2: ", solve1(input, 35651584)
