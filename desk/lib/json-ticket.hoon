/-  *pharos
/+  *etch
|%
++  to-js
  |=  tkt=ticket
  ^-  ^json
  (en-vase !>(tkt))
++  multi-to-js
  |=  tkts=(list ticket)
  ^-  ^json
  [%a (turn tkts |=(a=ticket (en-vase !>(a))))]
--