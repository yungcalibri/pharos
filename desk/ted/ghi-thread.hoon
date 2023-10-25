/-  spider
/-  *pharos
/+  strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
:: =/  uargs  !<([~ url=@t token=@t title=@t body=@t] arg)
=/  uargs  !<([~ url=@t token=@t =ticket] arg)
=/  url  url.uargs
=/  token  token.uargs
=/  title  title.ticket.uargs
=/  body  body.ticket.uargs
:: =/  title   'mytitle'
:: =/  body    'mybody'
=/  authhead  ['Authorization' (crip (weld "Bearer " (trip token)))]
:: =/  useragenthead  ['User-Agent' 'Pharos Desk']
:: =/  headers  `(list [key=@t value=@t])`[authhead ~]
=/  useragenthead  ['User-Agent' 'Pharos Desk']
=/  headers  `(list [key=@t value=@t])`[authhead useragenthead ~]
=/  jsondata  %:  en:json:html 
                o+(malt (limo ~[['title' s+title] ['body' s+body]]))
              ==
              ~&  jsondata
=/  ticketdata  `(as-octs:mimes:html jsondata)
=/  =request:http  [%'POST' url headers ticketdata]
=/  =task:iris  [%request request *outbound-config:iris]
=/  =card:agent:gall  [%pass /http-req %arvo %i task]
;<  ~  bind:m  (send-raw-card:strandio card)
;<  res=(pair wire sign-arvo)  bind:m  take-sign-arvo:strandio
?.  ?=([%iris %http-response %finished *] q.res)
  (strand-fail:strand %bad-sign ~)
~&  +.q.res
?~  full-file.client-response.q.res
  (strand-fail:strand %no-body ~)
(pure:m !>(`@t`q.data.u.full-file.client-response.q.res))
