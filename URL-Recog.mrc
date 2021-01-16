dialog URL_Recog {
  title "URL Recognizer"
  size -1 -1 92 173
  option dbu

  box "URL Extensions", 1, 1 0 90 162
  list 2, 2 8 87 130, size
  button "Add", 3, 3 138 43 10
  button "Remove", 4, 46 138 43 10
  button "Get list online", 5, 2 150 87 10
  check "Open URLs in new window", 6, 9 163 75 10
}
menu * { 
  URL Reconizer:/dialog -md URL_Recog URL_Recog 
}
on *:DIALOG:URL_recog:init:0: {
  if (%URL_Recog == new) { .did -c $dname 6 }
  .did -r $dname 2
  var %a = 1
  while (%a <= $ini(URL-Recog.ini,0)) {
    .did -a $dname 2 $ini(URL-Recog.ini,%a)
    inc %a
  }
}
on *:DIALOG:URL_Recog:sclick:3,4,5,6: {
  if ($did == 6) {
    if ($did($dname,6).state == 1) { .set %URL_Recog new }
    else { .set %URL_Recog same }
  }
  if ($did == 5) {
    .sockclose URL-Recog
    .sockopen URL-Recog home.no 80
  }
  if ($did == 4) {
    if (!$did($dname,2).seltext) { halt }
    .remini URL-Recog.ini $did($dname,2).seltext
    .did -r $dname 2
    var %a = 1
    while (%a <= $ini(URL-Recog.ini,0)) {
      .did -a $dname 2 $ini(URL-Recog.ini,%a)
      inc %a
    }
  }
  if ($did == 3) {
    var %URL_Recog_new = $$?="Enter URL extension to add:"
    .writeini -n URL-Recog.ini %URL_Recog_new window nouse
    .did -r $dname 2
    var %a = 1
    while (%a <= $ini(URL-Recog.ini,0)) {
      .did -a $dname 2 $ini(URL-Recog.ini,%a)
      inc %a
    }
  }
}
on *:SOCKOPEN:URL-Recog: {
  if ($sockerr) { echo -a URL Recognizer Error: $sock(URL-Recog).wsmsg | return }
  .sockwrite -n URL-Recog GET /funman/URL-Recog.txt HTTP/1.1
  .sockwrite -n URL-Recog Host: www.home.no $+ $crlf $+ $crlf
}
on *:SOCKREAD:URL-Recog: {
  if ($sockerr) { echo .a URL Recognizer Error: $sock(URL-Recog).wsmsg | return }
  .sockread %URL_Recog_online
  if ($left(%URL_Recog_online,1) == .) { .writeini -n URL-Recog.ini %URL_Recog_online }
}
on *:SOCKCLOSE:URL-Recog: {
  .did -r URL_Recog 2
  var %a = 1
  while (%a <= $ini(URL-Recog.ini,0)) {
    .did -a URL_Recog 2 $ini(URL-Recog.ini,%a)
    inc %a
  }
}
on ^1:HOTLINK:*:*: {
  var %a = 1
  while (%a <= $ini(URL-Recog.ini,0)) {
    if ($regex($1,$ini(URL-Recog.ini,%a))) { return }
    elseif ($+(*,$ini(URL-Recog.ini,%a),*) iswm $1) { return }
    inc %a
  }
  halt
}
on 1:HOTLINK:*:*: {
  if (%URL_Recog == new) { .url -n $1 }
  else { .url $1 }
}
