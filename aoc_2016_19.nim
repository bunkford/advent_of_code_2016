import lists, tables

proc solve1(input:int):int =
  var lookup: Table[int, DoublyLinkedNode[int]]

  var head = newDoublyLinkedNode[int](1)
  head.next = head
  head.prev = head
  lookup[1] = head

  var cur = head

  for i in 2 .. input:
    let n = newDoublyLinkedNode[int](1)
    lookup[i] = n
    cur.next = n
    n.next = head
    n.prev = cur
    head.prev = n
    cur = n

  cur = head

  while true:
    var next = cur.next
    while next.value == 0:
      next = next.next

      if next == cur:
        # only one person left has presents
        for k, v in lookup:
          if v.value > 0: return k 

    cur.value = cur.value + next.value
    next.value = 0
    
    cur = cur.next
    while cur.value == 0:
      cur = cur.next
   
   


let input = 3014603

echo "Answer Part 1: ", solve1(input)

