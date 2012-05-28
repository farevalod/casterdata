#!/usr/bin/env ruby
require 'net/http'
require "cgi"
cgi = CGI.new("html4")
uri = URI("http://184.173.181.32:19025/status.xsl")
@txt = Net::HTTP.get(uri)
/<Current-Listeners>(.*)<\/Current-Listeners>/.match(@txt)
listeners = $1
/<Current-Song>(.*)<\/Current-Song>/.match(@txt)
song = $1
if(song)
cgi.out{
  cgi.html{
	cgi.head{'<meta http-equiv="refresh" content="10; URL=scrobble.rb">'} +
    cgi.body{"<div style='overflow:hidden;background:#141414;color:#f0f7ff;font-weight:bold;vertical-align:middle;margin-top:28px;'><span style='font-size:22px'>Now Playing: <span style='color:#bbbbff'>"+song+"</span></span><br/><span style='font-size:18px'>Current Listeners: <span style='color:#bbbbff'>"+listeners+"</span></span><br/><a style='color:#bbbbff' href='http://4ws.cl/song_history.txt' target='new'>Last Played</a></div>"}
  }
}
last_line = `tail -n 1 song_history.txt`
time = Time.new
File.open("song_history.txt", 'a'){|f| 
	if(last_line.split(': ')[1].chomp != song)
		f.write(time.inspect+": "+song+"\n")
	end
}
else
	cgi.out{cgi.html{cgi.head + cgi.body{"Radio is offline"}}}
end
