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
    ;h1: Tickets
    ;*  %+  turn  ordered-tickets
    |=  [id=@ud =ticket]
    =/  =date  (yore date-updated.ticket)
    ;div.ticket(data-ticket-id (scow %ud id.ticket))
      ;header
        ;h2: {(trip title.ticket)}
        ;div
          ; submitted by:
          ;span.monospace:"{<author.ticket>}"
        ==
        ;div
          ; desk:
          ;span.monospace:"{<board.ticket>}"
        ==
      ==
      ;p: {(trip body.ticket)}
      ;footer
        ;+  (formatted-date.c date)
      ==
      ;div.ticket-id: id: {(scow %ud id.ticket)}
    ==
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 70ch;
  }
  h1, h2, h3, h4, h5, h6 {
    margin-top: unset;
    margin-bottom: unset;
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
