import md5, nre

#[
  ! compile with -d:release or this is much slower
]#

proc solve1(input:string):int = 
  var i: int 
  var keysFound:int
  while true:
    let hash = $toMD5(input & $i)
    let threepeats = hash.findAll(re"([a-z0-9])\1{2}")
    if threepeats.len >= 1:
      echo i, ": ", hash, " - ", keysFound, " of 64 keys found"
      for e in i + 1 .. i + 1 + 1000:
        let checkhash = $toMD5(input & $e)
        var find:string = "([" & $threepeats[0][0] & "])\\1{4}"
        let fivepeats = checkhash.findAll(re find)
        if fivepeats.len >= 1:
          inc(keysFound)
          if keysFound == 64: return i
          break
    inc(i)

proc solve2(input:string):int = 
  var i: int 
  var keysFound:int
  var hashes:seq[string]
  for i in 1 .. 1000:
    var checkhash = getMD5(input & $i)
    for y in 1 .. 2016:
      checkhash = getMD5(checkhash)
    hashes.add(checkhash)
    echo "generating cached hashes to check: ", i, " of 1000"

  while true:
    var hash = getMD5(input & $i)
    for y in 1 .. 2016:
      hash = getMD5(hash)
    let threepeats = hash.findAll(re"([a-z0-9])\1{2}")
    if threepeats.len >= 1:
      echo i, ": ", hash, " - ", keysFound, " of 64 keys found"
      for h in hashes:
        var find:string = "([" & $threepeats[0][0] & "])\\1{4}"
        let fivepeats =  h.findAll(re find)
        if fivepeats.len >= 1:
          inc(keysFound)
          if keysFound == 64: return i
          break
    inc(i)

    hashes.delete(0)
    var checkhash = getMD5(input & $(i + 1000))
    for y in 1 .. 2016:
      checkhash = getMD5(checkhash)
    hashes.add(checkhash)


let input = "cuanljph"

let part1 = solve1(input)
let part2 = solve2(input)

echo "Answer Part 1: ", part1
echo "Answer Part 2: ", part2




