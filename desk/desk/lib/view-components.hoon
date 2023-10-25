|%
++  remote-scripts
  ^-  marl
  ;=
    ;link
      =rel          "stylesheet"
      =crossorigin  "anonymous"
      =integrity    "sha384-fXCv1dA3EJQwVgsQOvtqiHwOEUBDruR4MiLNatn8wzSPvKLN0N/Pt5TTrpvD/jRf"
      =href         "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.css";
    ;link
      =rel          "stylesheet"
      =crossorigin  "anonymous"
      =integrity    "sha384-Kh+o8x578oGal2nue9zyjl2GP9iGiZ535uZ3CxB3mZf3DcIjovs4J1joi2p+uK18"
      =href         "https://unpkg.com/@fontsource/lora@5.0.8/index.css";
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
  ==
::
++  formatted-date
  |=  =@da
  =/  =date  (yore da)
  ^-  manx
  ;span.formatted-date
    ;span: {<(mod y.-.date 100)>}.{<m.date>}.{<d.t.date>}
    ;span:"  "
    ;span: {<h.t.date>}:{<m.t.date>}:{<s.t.date>}
  ==
--
