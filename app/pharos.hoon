/-  *pharos
/+  dbug, default-agent, *pharos, schooner, server, view=pharos-view, grip
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
    ::
      gh-config=github-config
  ==
--
=|  state-0
=*  state  -
%-  %-  agent:grip
  :*
  ~zod         
  [0 0 0]
  /apps/pharos
  ==   
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
          ::
            %'POST'
          ~(pot handle-http:hc req)
        ==
        ::
      [cards this]
      ::
        %pharos-action
        ~&  'pharos-action?'
      ::?>  =(src.bowl our.bowl)
      =/  act  !<(action vase)
      =^  cards  state
        (handle-action:hc act)
      [cards this]
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+    path  (on-peek:def path)
      ::
        [%x %ticket @ud ~]
      =/  =ticket  (~(got by tickets) `@ud`i.t.t.path)
      ``ticket+!>(ticket)
      ::
        [%x %all-tickets ~]
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
  ::
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
  ::
  ++  on-arvo  on-arvo:def
  ++  on-fail  on-fail:def
  --
|%
::  helper core
++  hc
  |_  =bowl:gall
  ::
  ++  new-comment
    |=  ticket-id=@ud
    =+  *comment
    %=  -
      author        our.bowl
      date-created  now.bowl
      date-updated  now.bowl
      reply-to      ticket-id
    ==
  ::
  ++  handle-action
    |=  act=action
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
      ::=/  tt  ;;  ticket-type  ticket-type.act
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
                                 status=%new
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
        %edit-ticket-type
      =/  got=ticket  (~(got by tickets) id.act)
      =.  ticket-type.got  ticket-type.act
      [~ state(tickets (~(put by tickets) id.act got))]
      ::
        %edit-ticket-status
      =/  got=ticket  (~(got by tickets) id.act)
      =.  status.got  ticket-status.act
      [~ state(tickets (~(put by tickets) id.act got))]
      ::
        %edit-github-config
      ~&  owner+owner.act
      ~&  repo+repo.act
      ~&  token+token.act
      =/  new-config=github-config  +.act
      [~ state(gh-config new-config)]
      ::
        %edit-comment
      =/  got=ticket    (~(got by tickets) reply-to.act)
      =/  =comment      :*  id=0
                            body=body.act
                            author=our.bowl
                            date-created=date.act
                            date-updated=now.bowl
                            reply-to=reply-to.act
                        ==
      =.  comments.got  (~(put by comments.got) id.comment comment)
      [~ state(tickets (~(put by tickets) reply-to.act got))]
      ::
        %export-tickets
      ?.  ?&  ?!  =('' owner.gh-config)
              ?!  =('' repo.gh-config)
              ?!  =('' token.gh-config)
          ==
          ~|("Github credentials have not been configured" !!)
      ?>  =(%github-issues export-location.act)
      ?>  (roll ids.act |=([id=@ud acc=?] ?&((~(has by tickets) id) acc)))
      =/  ghpath=path  :~  'api.github.com'
                           'repos'
                           owner.gh-config
                           repo.gh-config
                           'issues'
                       ==
      =/  ghurl=tape  "https:/{(trip (spat ghpath))}"
      =|  outcards=(list card)
      =/  i  0
      |-
      ?:  =((lent ids.act) i)
        [outcards state]
      =/  id  (snag i ids.act)
      =/  tic  (~(got by tickets) id)
      =/  twire=@ta  (crip (weld (a-co:co id) (trip (scot %da now.bowl))))
      =/  tid=@ta  (crip (weld (a-co:co id) (trip (cat 3 'thread_' (scot %uv (sham eny.bowl))))))
      =/  start-args  [~ `tid byk.bowl(r da+now.bowl) %ghi-thread !>([~ ghurl token.gh-config tic])]
      =/  acard  :*  %pass  /thread/[twire]  %agent  [our.bowl %spider]
                     %watch  /thread-result/[tid]
                 ==
      =/  bcard  :*  %pass  /thread/[twire]  %agent  [our.bowl %spider]
                     %poke  %spider-start  !>(start-args)
                 ==
      %=  $
        outcards  (weld outcards `(list card)`~[acard bcard])
        i         +(i)
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
          [%apps %pharos %settings ~]
        :_  state
        (send [200 ~ [%manx ~(settings view state)]])
        ::
          [%apps %pharos %ticket @t ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  got  (~(get by tickets) ticket-id)
        ?~  got  ~|("No ticket with id {<ticket-id>}" dump)
        :_  state
        (send [200 ~ [%manx (~(ticket-detail view state) u.got)]])
        ::
          [%apps %pharos %ticket @t %features ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  got  (~(get by tickets) ticket-id)
        ?~  got  ~|("No ticket with id {<ticket-id>}" dump)
        :_  state
        (send [200 ~ [%manx (~(ticket-features view state) u.got)]])
        ::
          [%apps %pharos %ticket @t %edit %status ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  got  (~(get by tickets) ticket-id)
        ?~  got  ~|("No ticket with id {<ticket-id>}" dump)
        :_  state
        (send [200 ~ [%manx (~(edit-ticket-status view state) u.got)]])
        ::
          [%apps %pharos %ticket @t %edit %comment ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  got  (~(get by tickets) ticket-id)
        ?~  got  ~|("No ticket with id {<ticket-id>}" dump)
        ?~  comments.u.got  
          =/  comments  (malt (limo ~[[0 (new-comment ticket-id)]]))
          :_  state 
          (send [200 ~ [%manx (~(edit-comment view state) comments)]])
        :_  state
        (send [200 ~ [%manx (~(edit-comment view state) comments.u.got)]])
      ==
    ::  need
    ++  pot
      ^-  (quip card _state)
      =/  site  site.req
      ?~  body.request.inbound-request
        ~|("No request body" derp)
      ?+    site  dump
          [%apps %pharos %settings %github-config ~]
        =/  jon=(unit json)  (de:json:html q.u.body.request.inbound-request)
        ?~  jon  ~|("Could not parse request body to JSON" derp)
        =/  act=action  (dejs-github-config u.jon)
        =/  scat=(unit (quip card _state))
          (mole |.((handle-action act)))
        ?~  scat  ~|("Could not apply the updated config" derp)
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [200 ~ %manx ~(success view state)])
        ::
          [%apps %pharos %ticket @t %edit %status @t ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  got  (~(get by tickets) ticket-id)
        ?~  got
          ~|("No ticket with id {<ticket-id>}" derp)
        =/  status-param  `@tas`(slav %tas i.t.t.t.t.t.t.site)
        ?.  ?=(ticket-status status-param)
          ~|("{(trip `@t`status-param)} is not a valid ticket status" derp)
        =/  scat=(unit (quip card _state))
          %-  mole
          |.
          %-  handle-action
          `action`[%edit-ticket-status ticket-id status-param]
        ?~  scat 
          ~|("Failed to update the status of ticket {<ticket-id>}" derp)
        :_  +.u.scat
        %+  weld
          -.u.scat
        %-  send
        :*  303  ~  %redirect
            (crip "/apps/pharos/ticket/{<ticket-id>}/features")
        ==
        ::
          [%apps %pharos %ticket @t %edit %comment @t ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        ~&  body
        =/  jon=(unit json)  (de:json:html q.u.body)
        =/  dejs-body=@t  (dejs-comment (need jon))
        =/  scat=(unit (quip card _state))
          %-  mole
          |.
          %-  handle-action
          `action`[%edit-comment ticket-id dejs-body now.bowl]
        ?~  scat 
          ~|("Failed to update the status of ticket {<ticket-id>}" derp)
        :_  +.u.scat
        %+  weld
          -.u.scat
        %-  send
        :*  303  ~  %redirect
            (crip "/apps/pharos/ticket/{<ticket-id>}")
        ==
        ::
          [%apps %pharos %ticket @t %export ~]
        =/  ticket-id  (slav %ud i.t.t.t.site)
        =/  scat=(unit (quip card _state))
          %-  mole
          |.
          %-  handle-action
          `action`[%export-tickets ~[ticket-id] %github-issues]
        ?~  scat  ~|("Exporting ticket {<ticket-id>} failed" derp)
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [200 ~ %manx ~(success view state)])
      ==
    --
  --
--
