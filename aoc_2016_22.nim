import os, strutils, nre

type 
  Node = object
    id: string
    x:int
    y:int
    size:int
    used:int
    avail:int
    pct:int
    
proc get_input(file:string):seq[string] =
  for line in lines file:
    result.add(line)



proc solve1(input:seq[string]):int =
  var nodes: seq[Node]
  for i in 2 .. input.high:
    let split = input[i].find(re"node\-(x\d+\-y\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%").get.captures
    let xy = split[0].find(re"x(\d+)\-y(\d+)").get.captures
    
    var node = Node(id: split[0], x: xy[0].parseInt(), y: xy[1].parseInt(), size: split[1].parseInt(), used: split[2].parseInt(), avail: split[3].parseInt(), pct: split[4].parseInt())
    nodes.add(node)
  
  for node1 in nodes:
    for node2 in nodes:
        if node1.id == node2.id:
          continue
        if node1.used == 0:
          continue
        if node1.used <= node2.avail:
          inc(result)

let input = get_input(getAppDir() / "aoc_2016_22.txt")

echo "Answer Part 1: ", solve1(input) # 901