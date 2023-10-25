/-  *pharos
/+  *etch
|%
::
++  enjs-ticket
  |=  =ticket
  ^-  ^json
  (en-vase !>(ticket))
::
++  enjs-tickets
  |=  tix=(list ticket)
  ^-  ^json
  a+(turn tix |=(a=ticket (en-vase !>(a))))
::
++  dejs-status
  |=  jon=json
  =,  dejs:format
  ;;  ticket-status
  ^-  @tas
  %.  jon
  (ot ~[status+so])
::
++  dejs-github-config
  |=  jon=json
  ^-  action
  =,  dejs:format
  :-  %edit-github-config
  %.  jon
  (ot ~[repo+so owner+so token+so])
::
++  dejs-comment
  |=  jon=json
  =,  dejs:format
  ^-  @t
  %.  jon
  (ot ~[body+so])
--
