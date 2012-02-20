# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'openssl'
require 'uri'
require 'net/http'

class Slideshare
  def initialize()
    @url = 'http://www.slideshare.net/api/2/get_slideshow'
    @param = Hash.new
    @param["slideshow_url"] = 'http://www.slideshare.net/gishi/wicket-presentation'
    @param["api_key"] = 'EQyydpLx'
    @param["sharedsecret"] = '8drMZ4hG'
    # ts
    @param["ts"] = Time.now.to_i.to_s
    # hash
    @param["hash"] = Digest::SHA1.hexdigest(param["sharedsecret"]+param["ts"])
  end

  def get()
    uri = URI.parse(@url)
    Net::HTTP.new(uri.host).start do |http|
    uri_param = param.sort.map {|i|i.join('=')}.join('&')
    
    res = http.get(uri.path + '?' + uri_param)
    return res.body
  end
end

get '/' do
  ss = Slideshare.new()
  puts ss.get()
  return "HElOO"
end
