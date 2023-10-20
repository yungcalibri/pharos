/-  *pharos
/+  c=view-components
|_  [%0 * * * boards=(map desk board) tickets=(map @ud ticket) *]
::
++  page
  |=  kid=manx
  ^-  manx
  ;html
    ;head
      ;title: Pharos
      ;meta(charset "utf-8");
      ;*  remote-scripts:c
      ;style: {style}
    ==
    ;body(hx-boost "true", hx-ext "json-enc,include-vals")
      ;+  kid
    ==
  ==
::
++  nav
  ^-  manx
  ;nav#topnav
    ;cluster-l(align "center")
      ;a/"/apps/pharos"
        ;h1: Tickets
      ==
      ;a/"/apps/pharos/settings"
        ;h1: Settings
      ==
    ==
    ;cluster-l.logotype(space "var(--s-1)")
      ;span: P
      ;span: H
      ;span: A
      ;span: R
      ;span: O
      ;span: S
    ==
  ==
::
++  home
  ::  sort by date created
  =/  ordered-tickets=(list [@ud ticket])
    %+  sort  ~(tap by tickets)
    |=  [[* a=ticket] [* b=ticket]]
    (gth date-created.a date-created.b)
  %-  page
  ^-  manx
  ;div#home
    ;+  nav
    ::
    ;center-l#home-main
      ;sidebar-l(side "right", sideWidth "28rem", space "var(--s-4)")
        ::  main content
        ;table#ticket-list
          ;thead
            ;tr
              ;th: type
              ;th: issue
              ;th: from
              ;th: priority
              ;th: date created
            ==
          ==
          ;tbody
            ;*  %+  turn  ordered-tickets
            |=  [id=@ud =ticket]
            ^-  manx
            =/  dex=tape  :: formatted body
              =+  (trip title.ticket)
              ?:  (gth 20 (lent -))
                -
              "{(swag [0 20] -)}..."
            =/  dat=date  (yore date-created.ticket)
            ;tr.ticket
              =hx-get     "/apps/pharos/ticket/{<id.ticket>}"
              =hx-target  "#ticket-content"
              ;td:"{(trip `@t`ticket-type.ticket)}"
              ;td:"{dex}"
              ;td:"{<author.ticket>}"
              ;td:"{(trip `@t`priority.ticket)}"
              ;td:"{<y.-.dat>} - {<m.dat>} - {<d.t.dat>}"
            ==
          ==
        ==
        ::  sidebar, content panel
        ;div#ticket-content
          ;cover-l(centered "small", minHeight "var(--s4)")
            ;small: Select a ticket to view details
          ==
        ==
      ==
    ==
  ==
::
::  ticket detail view
++  ticket-detail
  |=  =ticket
  %-  page
  ^-  manx
  ;article.ticket(data-ticket-id (scow %ud id.ticket))
    ;header
      ;stack-l(space "var(--s-2)")
        ;sidebar-l(side "right", sideWidth "calc(var(--s5) + var(--s1))")
          ;div
            ;h2: {(trip title.ticket)}
            ;div
              ; Last updated:
              ;+  (formatted-date.c date-updated.ticket)
            ==
            ;div
              ;a/"/apps/talk/dm/{<author.ticket>}"
                =target  "_blank"
                =rel     "noopener noreferer"
                ; DM {<author.ticket>} in Talk
              ==
            ==
          ==
          ;+  (ticket-features ticket)
        ==
      ==
    ==
    ;hr;
    ;div.body
      ; {(trip body.ticket)}
    ==
  ==
::
++  ticket-features
  |=  =ticket
  ^-  manx
  ;cluster-l.ticket-details(space "var(--s-3)")
    ;div.pill
      ;span:"id "
      ;span.value: {<id.ticket>}
    ==
    ;div.pill
      ;span:"author "
      ;span.value: {<author.ticket>}
    ==
    ;div.pill
      ;span:"app "
      ;span.value: {<board.ticket>}
    ==
    ;div.pill.interact
      =data-ticket-status  (trip `@t`status.ticket)
      =hx-get  "/apps/pharos/ticket/{<id.ticket>}/edit/status"
      ;span:"status "
      ;span.value: {(trip `@t`status.ticket)}
    ==
  ==
::
++  edit-ticket-status
  |=  =ticket
  ^-  manx
  ;div.pill
    =hx-target  "closest .ticket-details"
    ; Status
    ;div.pill.modify
      =data-ticket-status  "new"
      =hx-post  "/apps/pharos/ticket/{<id.ticket>}/edit/status/new"
      =include-vals  "status: 'new'"
      ;span.value: new
    ==
    ;div.pill.modify
      =data-ticket-status  "in-progress"
      =hx-post  "/apps/pharos/ticket/{<id.ticket>}/edit/status/in-progress"
      =include-vals  "status: 'in-progress'"
      ;span.value: in progress
    ==
    ;div.pill.modify
      =data-ticket-status  "resolved"
      =hx-post  "/apps/pharos/ticket/{<id.ticket>}/edit/status/resolved"
      =include-vals  "status: 'resolved'"
      ;span.value: resolved
    ==
    ;div.pill.modify
      =data-ticket-status  "dropped"
      =hx-post  "/apps/pharos/ticket/{<id.ticket>}/edit/status/dropped"
      =include-vals  "status: 'dropped'"
      ;span.value: dropped
    ==
  ==
::
++  settings
  ^-  manx
  %-  page
  ;div#settings
    ;+  nav
    ;center-l
      ;p: Settings
    ==
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 70ch;
    --pc-aquamarine-800: #0C7489;
    --pc-aquamarine-500: #4BB3BE;
    --pc-aquamarine-200: #368C96;
    --pc-seagreen-800:   #12AFCE;
    --pc-seagreen-500:   #78C6CE;
    --pc-seagreen-200:   #08505E;
    --pc-yellow-800:     #F9D939;
    --pc-yellow-500:     #EFCA08;
    --pc-yellow-200:     #B29506;
    --pc-orange-800:     #FEAD34;
    --pc-orange-500:     #F18F01;
    --pc-orange-200:     #B76E01;
    --pc-neut-800:       #F5F7F3;
    --pc-neut-700:       #EAEEE7;
    --pc-neut-600:       #E0E6DB;
    --pc-neut-500:       #D5DECF;
    --pc-neut-400:       #CBD5C3;
  }
  body {
    font-family: Lora, serif;
  }
  h1, h2, h3, h4, h5, h6 {
    margin-top: unset;
    margin-bottom: unset;
  }
  hr {
    width: 100%;
  }
  thead tr {
    background: var(--pc-seagreen-500);
    color: var(--pc-neut-800);
  }
  tbody tr {
    background: var(--pc-neut-200);
    border-top: var(--s-4) solid var(--pc-neut-500);
    border-bottom: var(--s-4) solid var(--pc-neut-500);
  }
  th, td {
    padding-inline: 1ch;
    padding-block: 1ch;
  }
  td {
    border-inline: none;
  }
  #topnav {
    width: 100%;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: var(--s0);
    background: var(--pc-seagreen-500);
    color: var(--pc-neut-800);
    padding: var(--s0);
    padding-top: var(--s2);
  }
  #topnav .logotype {
    font-size: 150%;
    border-radius: var(--s-2);
    padding-inline: var(--s-1);
    padding-block: var(--s-2);
    background-color: var(--pc-aquamarine-500);
    color: var(--pc-yellow-800);
  }
  #topnav :any-link {
    color: var(--pc-neut-800);
  }
  #ticket-list {
    border-width: var(--s-4);
    border-style: solid;
    border-color: var(--pc-aquamarine-500);
  }
  #ticket-list tbody tr {
    cursor: pointer;
    transition: 100ms;
  }
  #ticket-list tbody tr:hover {
    background: var(--pc-neut-600);
  }
  #ticket-content {
    border-block-width: 0.5lh;
    border-inline-width: 1ch;
    border-style: solid;
    border-color: var(--pc-aquamarine-500);
    padding-inline: 1ch;
    padding-block: 0.5lh;
    min-height: 20rem;
  }
  #home-main, #home-main > sidebar-l {
    max-inline-size: 90vw;
  }
  header {
    padding-block: 1ch;
  }
  .pill {
    min-width: var(--s2);
    padding-inline: var(--s-3);
    padding-block: var(--s-4);
    font-family: monospace;
    font-size: 90%;
    text-align: center;
    background-color: var(--pc-aquamarine-200);
    color: var(--pc-neut-600);
    border-radius: var(--s-4);
  }
  .pill.interact, .pill.modify {
    cursor: pointer;
  }
  .pill.interact:not(:has(.modify))::after {
    padding-left: 1ch;
    content: '✐';
  }
  .pill.modify::after {
    padding-left: 1ch;
    content: '✎';
  }
  .pill .value {
    color: var(--pc-yellow-800);
  }
  .monospace, .formatted-date {
    font-family: monospace;
  }
  '''
--
