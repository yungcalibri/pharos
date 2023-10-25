/-  *pharos
/+  dbug, default-agent, schooner, server, view=pharos-view, json-ticket
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      next-ticket-id=@ud
      next-comment-id=@ud
      next-label-id=@ud
::  get rid of boards ? 
      boards=(map desk board)
      tickets=(map @ud ticket)
      labels=(set label)
  ==
--
=|  state-0
=*  state  -
%-  agent:dbug
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      hc    ~(. ^hc bowl)
      def   ~(. (default-agent this %|) bowl)
  ::
  ++  on-init
    ^-  (quip card _this)
    :_  this
    :~  :*  %pass  /eyre/connect  %arvo  %e
            %connect  [~ /apps/pharos]  %pharos
    ==  ==
  ::
  ++  on-save
    ^-  vase
    !>(state)
  ::
  ++  on-load
    |=  old=vase
    ^-  (quip card _this)
    =/  old  !<(versioned-state old)
    ?-  -.old
      %0  [~ this(state old)]
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ~&  mark
    ^-  (quip card _this)
    ?+    mark  (on-poke:def mark vase)
      ::
        %handle-http-request
      ?>  =(src.bowl our.bowl)
      =/  req  !<([eyre-id=@ta =inbound-request:eyre] vase)
      =*  dump
        :_  state
        (response:schooner eyre-id.req 404 ~ [%none ~])
      ::
      =^  cards  state
        ^-  (quip card _state)
        ?+    method.request.inbound-request.req  dump
          ::
            %'GET'
          ~(get handle-http:hc req)
        ==
        ::
      [cards this]
      ::
        %pharos-action
      ?>  =(src.bowl our.bowl)
      =/  act  !<(pharos-action vase)
      =^  cards  state
        (handle-action:hc act)
      [cards this]
    ==
  ::
  ++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %get-ticket-id @ud ~]  
      =/  output-ticket  (need (~(get by tickets) (sub i.t.t.path 48)))      
    ``ticket+!>(output-ticket)
      [%x %get-all-tickets ~]  
    ``tickets+!>(~(val by tickets))
  ==
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?+    path  (on-watch:def path)
        [%http-response *]
      [~ this]
    ==
  ::
  ++  on-leave  on-leave:def
  ++  on-agent  
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    ?+  -.wire  (on-agent:def wire sign)
      %thread
      ?+  -.sign  (on-agent:def wire sign)
          %fact  
        ?+     p.cage.sign  (on-agent:def wire sign)
              %thread-fail
              =/  err  !<  (pair term tang)  q.cage.sign
              %-  (slog leaf+"Thread failed: {(trip p.err)}" q.err)
              `this
            ::
              %thread-done
              `this
        ==
      ==
    ==
  ++  on-arvo  on-arvo:def
  ++  on-fail  on-fail:def
  --
|%
::  helper core
++  hc
  |_  =bowl:gall
  ::
  ++  do-nothing  ~
  ::
  ++  handle-action
    |=  act=pharos-action
    ^-  (quip card _state)
    ?-    -.act
      ::
        %create-board
      =/  bod=board         *board
      =.  desk.bod          desk.act
      =.  date-created.bod  now.bowl
      =.  date-updated.bod  now.bowl
      =.  boards            (~(put by boards) desk.act bod)
      [~ state]
      ::
        %create-ticket
      ::
      ::If we using boards add logic to create-board in here if doesn't have in state yet
      ::
      ::  derive any fields we don't have
      ::  put it into the appropriate board
      ::  use & increment next-ticket-id
      ~&  ['action in pharos' act]
      =/  author=@p         ?.(anon.act src.bowl ~zod)
      ::=/  add-to             (~(got by boards) desk.act)
      =/  new-ticket=ticket  :*  id=next-ticket-id
                                 title=title.act
                                 body=body.act
                                 author=author
                                 ticket-type=ticket-type.act
                                 app-version=app-version.act
                                 board=board.act
                                 ::  defaults only for now
                                 date-created=now.bowl
                                 date-updated=now.bowl
                                 priority=%none
                                 labels=~
                                 date-resolved=~
                                 comments=~
                             ==
      ~&  next-ticket-id
      ::=.  next-ticket-id    +(next-ticket-id)
      ~&  new-ticket
      ::=.  tickets           (~(put by tickets) next-ticket-id new-ticket)
      ::=.  tickets.add-to
      ::  (~(put by tickets.add-to) id.new-ticket new-ticket)
      ::=.  boards            (~(put by boards) desk.act add-to)
      `state(tickets (~(put by tickets) next-ticket-id new-ticket), next-ticket-id +(next-ticket-id))
      ::
        %delete-ticket
      =/  bod=board    (~(got by boards) desk.act)
      =.  tickets.bod  (~(del by tickets.bod) id.act)
      =.  boards       (~(put by boards) desk.act bod)
      [~ state]
      ::
        %export-ticket
        ?-  export-location.act
          %export-csv
            [~ state]
          %github-issues
          =/  ghtoken  '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'
          =/  ghurl    'https://api.github.com/repos/dannulbortux/test-repository/issues'      
          =/  i  0
          =/  outcards  *(list card)          
          |-          
          ?:  =((lent ids.act) i)                 
            :-  ^-  (list card)
              outcards
            state      
          =/  twire  `@ta`(crip (weld (a-co:co (snag i ids.act)) (trip (scot %da now.bowl))))
          =/  tid  `@ta`(crip (weld (a-co:co (snag i ids.act)) (trip (cat 3 'thread_' (scot %uv (sham eny.bowl))))))
          =/  thisticket  +:(~(get by tickets) (snag i ids.act))
          =/  start-args  [~ `tid byk.bowl(r da+now.bowl) %ghi-thread !>([~ ghurl ghtoken thisticket])]
          =/  acard  [%pass /thread/[twire] %agent [our.bowl %spider] %watch /thread-result/[tid]]
          =/  bcard  [%pass /thread/[twire] %agent [our.bowl %spider] %poke %spider-start !>(start-args)]
          =/  ccards  `(list card)`~[acard bcard]
          %=  $
            outcards  (weld `(list card)`outcards `(list card)`ccards)
            i         +(i)        
          ==
        ==
    ==
  ::
  ++  handle-http
    |_  [eyre-id=@ta =inbound-request:eyre]
    +*  req   (parse-request-line:server url.request.inbound-request)
        body  body.request.inbound-request
        send  (cury response:schooner eyre-id)
        dump  [(send [404 ~ [%none ~]]) state]
        derp  [(send [500 ~ [%stock ~]]) state]
    ::
    ++  get
      ^-  (quip card _state)
      =/  site  site.req
      ?+    site  dump
        ::
          [%apps %pharos ~]
        :_  state
        (send [200 ~ [%manx ~(home view state)]])
        ::
          [%apps %pharos %ticket @t ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  got  (~(get by tickets) ticket-id)
        ?~  got
          ~|("No ticket with id {<ticket-id>}" dump)
        :_  state
        (send [200 ~ [%manx (~(ticket-detail view state) u.got)]])
      ==
    --
  --
--
