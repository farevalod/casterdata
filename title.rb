#!/usr/bin/env ruby
require 'net/http'
require "cgi"
cgi = CGI.new("html4")
uri = URI("http://184.173.181.32:19025/status.xsl")
@txt = Net::HTTP.get(uri)
/<Current-Song>(.*)<\/Current-Song>/.match(@txt)
song = $1
cgi.out{
  cgi.html{
    cgi.body{
      $1
	}
  }
}
