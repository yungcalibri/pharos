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
      ;link
        =rel          "stylesheet"
        =crossorigin  "anonymous"
        =integrity    "sha384-fXCv1dA3EJQwVgsQOvtqiHwOEUBDruR4MiLNatn8wzSPvKLN0N/Pt5TTrpvD/jRf"
        =href         "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.css";
      ;script
        =crossorigin  "anonymous"
        =integrity    "sha384-aOxz9UdWG0yBiyrTwPeMibmaoq07/d3a96GCbb9x60f3mOt5zwkjdbcHFnKH8qls"
        =src          "https://unpkg.com/htmx.org@1.9.0";
      ;script
        =crossorigin  "anonymous"
        =integrity    "sha384-nRnAvEUI7N/XvvowiMiq7oEI04gOXMCqD3Bidvedw+YNbj7zTQACPlRI3Jt3vYM4"
        =src          "https://unpkg.com/htmx.org@1.9.0/dist/ext/json-enc.js";
      ;script
        =crossorigin  "anonymous"
        =integrity    "sha384-8IQLVSa8SPeOEPFM9W1QHw0NcfoMataSHwhy8Nn9YBopVPLyDPnmR3+LnmZe0c+Q"
        =src          "https://unpkg.com/htmx.org@1.9.0/dist/ext/include-vals.js";
      ;script
        =async        ""
        =crossorigin  "anonymous"
        =integrity    "sha384-SWTvl6gg9wW7CzNqGD9/s3vxwaaKN2g8/eYyu0yT+rkQ/Rb/6NmjnbTi9lYNrpZ1"
        =src          "https://unpkg.com/hyperscript.org@0.9.11";
      ;script
        =type         "module"
        =crossorigin  "anonymous"
        =integrity    "sha384-c4SSI79zksulLspZ11E4zHda7VSN8U2rGzjdomNMNrgCA/S93oOe2yqQToNh1tLY"
        =src          "https://unpkg.com/@yungcalibri/layout@0.1.5/umd/bundle.js";
      ;script
        =nomodule     ""
        =crossorigin  "anonymous"
        =integrity    "sha384-39Mph3QgxUJ4Ou1dsJkb8LY0baiOtTwuW7LYX/pqchlr1glQOp1X8LL1LAkTlv5N"
        =src          "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.js";
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
  ;div
    ;nav#topnav
      ;h1: Tickets
    ==
    ;*  %+  turn  ordered-tickets
    |=  [id=@ud =ticket]
    ;div.ticket(data-ticket-id (scow %ud id))
      ;header
        ;h2
          ;a/"/apps/pharos/ticket/{(scow %ud id)}"
            {(trip title.ticket)}
          ==
        ==
        ;div
          ; submitted by:
          ;span.monospace:"{<author.ticket>}"
        ==
        ;div
          ; desk:
          ;span.monospace: {<board.ticket>}
        ==
        ;p: {(trip body.ticket)}
        ;footer
          ;+  (formatted-date.c date-updated.ticket)
        ==
        ;div.ticket-id
          ; id: {(scow %ud id)}
        ==
      ==
    ==  ::
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
  }
  h1, h2, h3, h4, h5, h6 {
    margin-top: unset;
    margin-bottom: unset;
  }
  #topnav {
    width: 100%;
    display: flex;
    flex-direction: column;
    background: var(--pc-aquamarine);
    color: var(--pc-white);
  }
  header {
    padding-block: 1ch;
  }
  .ticket {
    border-radius: 1ch;
    padding: 1ch;
    background: lightgrey;
    margin-bottom: 2ch;
    position: relative;
  }
  .ticket > .ticket-id {
    position: absolute;
    right: 0;
    top: 0;
    padding: 1rem;
    font-size: 120%;
  }
  .monospace {
    font-family: monospace;
  }
  '''
--
