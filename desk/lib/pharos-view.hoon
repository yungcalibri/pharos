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
    ;stack-l
      ;header
        ;stack-l(space "var(--s-2)")
          ;h2: {(trip title.ticket)}
          ;div
            ; Last updated:
            ;+  (formatted-date.c date-updated.ticket)
          ==
          ;cluster-l.ticket-features
            ;div.pill
              ;header: id
              ;div: {<id.ticket>}
            ==
            ;div.pill.monospace
              ;header: author
              ;div: {<author.ticket>}
            ==
            ;div.pill.monospace
              ;header: app
              ;div: {<board.ticket>}
            ==
          ==
          ;div
            ;a/"/apps/talk/dm/{<author.ticket>}"
              =target  "_blank"
              =rel     "noopener noreferer"
              ; DM {<author.ticket>} in Talk
            ==
          ==
        ==
      ==
      ;hr;
      ;div.body
        ; {(trip body.ticket)}
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
    flex-direction: column;
    background: var(--pc-seagreen-500);
    color: var(--pc-neut-800);
    padding: var(--s0);
    padding-top: var(--s2);
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
    overflow: hidden;
    font-family: monospace;
    font-size: 90%;
    text-align: center;
    background-color: var(--pc-aquamarine-200);
    color: var(--pc-neut-800);
    border-radius: var(--s-4);
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .pill > header {
    width: 100%;
    font-size: 80%;
    padding-inline: var(--s-4);
    background-color: var(--pc-seagreen-200);
    color: var(--pc-neut-200);
  }
  .pill > header + div {
    padding: var(--s-3);
  }
  .monospace, .formatted-date {
    font-family: monospace;
  }
  '''
--
