/-  *pharos
|_  [%0 * * * boards=(map desk board) tickets=(map @ud ticket) *]
::
++  page
  |=  kid=manx
  ^-  manx
  ;html
    ;head
      ;title: Pharos
      ;meta(charset "utf-8");
      ;style: {style}
    ==
    ;body
      ;+  kid
    ==
  ==
::
++  home
  %-  page
  ;div
    ;h1: Tickets
    ;*  %+  turn
      ~(tap by tickets)
    |=  [id=@ud =ticket]
    ;div(data-ticket-id "{(scow %ud id.ticket)}")
      ;header
        ;div: {(trip title.ticket)}
        ;div
          ; author:
          ;span:"{<author.ticket>}"
        ==
      ==
      ;p: {(trip body.ticket)}
      ;footer: {(scow %da date-updated.ticket)}
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
  '''
--
