/-  *pharos, spider
/+  strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m

=/  uargs  !<([~ url=tape token=@t =ticket] arg)
=/  url    (crip url.uargs)
=/  token  token.uargs
=/  title  title.ticket.uargs
=/  body   body.ticket.uargs
=/  auth  ['Authorization' (crip "Bearer {(trip token)}")]
=/  user  ['User-Agent' 'Pharos Desk']
=/  headers=header-list:http  ~[auth user]
=/  jsondata  %-  en:json:html
              o+(malt (limo ~[['title' s+title] ['body' s+body]]))

::  ~&  %thread-json^jsondata

=/  ticketdata  `(as-octs:mimes:html jsondata)
=/  =request:http  [%'POST' url headers ticketdata]
=/  =task:iris     [%request request *outbound-config:iris]
=/  =card:agent:gall  [%pass /http-req %arvo %i task]

;<  ~  bind:m  (send-raw-card:strandio card)
;<  res=(pair wire sign-arvo)  bind:m  take-sign-arvo:strandio

?.  ?=([%iris %http-response %finished *] q.res)
  (strand-fail:strand %bad-sign ~)

::  ~&  %thread-response^+.q.res

?~  full-file.client-response.q.res
  (strand-fail:strand %no-body ~)

~&  "github submission succeeded: {<title>}"

(pure:m !>(`@t`q.data.u.full-file.client-response.q.res))
