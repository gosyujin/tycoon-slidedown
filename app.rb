# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'openssl'
require 'uri'
require 'net/http'

class Slideshare
  def initialize(url)
    @url = 'http://www.slideshare.net/api/2/get_slideshow'
    @param = Hash.new
    @param["slideshow_url"] = url
    @param["api_key"] = ENV["API_KEY"]
    @param["shared_secret"] = ENV["SHARED_SECRET"]
    # ts
    @param["ts"] = Time.now.to_i.to_s
    # hash
    @param["hash"] = Digest::SHA1.hexdigest(@param["shared_secret"]+@param["ts"])
  end

  def get()
    uri = URI.parse(@url)
    Net::HTTP.new(uri.host).start do |http|
      uri_param = @param.sort.map {|i|i.join('=')}.join('&')
    
      res = http.get(uri.path + '?' + uri_param)
      return res.body
    end
  end
end

get '/' do
  return '<form method="post" action="down">' +
           '<input type="text" name="url" />' +
           '<input type="submit" value="submit" />' +
         '</form>'
end

get '/down' do
  return params["url"]
  #ss = Slideshare.new(params["url"])
  #return ss.get()
end
