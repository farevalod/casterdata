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
    cgi.body{"<div style='overflow:hidden;background:#141414;color:#f0f7ff;font-weight:bold;vertical-align:middle;margin-top:28px;'><span style='font-size:22px'>Now Playing: <span style='color:#bbbbff'>"+song+"</span></span><br/><span style='font-size:18px'>Current Listeners: <span style='color:#bbbbff'>"+listeners+"</span></span></div>"}
  }
}
else
	cgi.out{cgi.html{cgi.head + cgi.body{"Radio is offline"}}}
end
