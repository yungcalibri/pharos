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
++  home
  ::  sort by date created
  =/  ordered-tickets=(list [@ud ticket])
    %+  sort  ~(tap by tickets)
    |=  [[* a=ticket] [* b=ticket]]
    (gth date-created.a date-created.b)
  %-  page
  ^-  manx
  ;div#home
    ;nav#topnav
      ;h1: Tickets
    ==
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
            ;tr.ticket(data-ticket-id (scow %ud id))
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
          ; boo
        ==
      ==
    ==
  ==
::
::  full ticket detail page
++  ticket-page
  |=  =ticket
  %-  page
  ^-  manx
  ;div
    ;sidebar-l
      ;h1
        ; {<title.ticket>}
      ==
      ;span
        ; id: {<id.ticket>}
      ==
    ==
    ;div.ticket
      ;div
        ; submitted by:
        ;span.monospace
          ; {<author.ticket>}
        ==
      ==
      ;div
        ; desk:
        ;span.monospace: {<board.ticket>}
      ==
      ;div.body
        ; {<body.ticket>}
      ==
      ;footer
        ;div
          ; updated
          ;+  (formatted-date.c date-updated.ticket)
        ==
        ;div
          ; created
          ;+  (formatted-date.c date-created.ticket)
        ==
      ==
    ==
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 70ch;
    --pc-aquamarine: #0C7489;
    --pc-seagreen:   #78C6CE;
    --pc-yellow:     #EFCA08;
    --pc-orange:     #F18F01;
    --pc-white:      #FFF;
    --pc-gray:       #EEE;
  }
  body {
    font-family: Lora, serif;
  }
  h1, h2, h3, h4, h5, h6 {
    margin-top: unset;
    margin-bottom: unset;
  }
  thead tr {
    background: var(--pc-seagreen);
    color: var(--pc-white);
  }
  tbody tr {
    background: var(--pc-gray);
    border-top: var(--s-4) solid var(--pc-white);
    border-bottom: var(--s-4) solid var(--pc-white);
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
    flex-direction: column;
    background: var(--pc-seagreen);
    color: var(--pc-white);
    padding: var(--s0);
    padding-top: var(--s2);
  }
  #ticket-list {
    border-width: var(--s-4);
    border-style: solid;
    border-color: var(--pc-aquamarine);
  }
  #ticket-content {
    border-block-width: 1lh;
    border-inline-width: 2ch;
    border-style: solid;
    border-color: var(--pc-aquamarine);
    min-height: 20rem;
  }
  #home-main, #home-main > sidebar-l {
    max-inline-size: 90vw;
  }
  header {
    padding-block: 1ch;
  }
  .monospace {
    font-family: monospace;
  }
  '''
--
