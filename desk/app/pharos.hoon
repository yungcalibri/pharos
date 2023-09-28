/-  *pharos
/+  dbug, default-agent, schooner
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
        `state
        :::_  state
        ::(response:schooner eyre-id.req 404 ~ [%none ~])
      ::
      dump
      ::
        %pharos-action
      ?>  =(src.bowl our.bowl)
      =/  act  !<(pharos-action vase)
      =^  cards  state
        (handle-action:hc act)
      [cards this]
    ==
  ::
  ++  on-peek  on-peek:def
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
  ++  on-agent  on-agent:def
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
    ==
  --
--