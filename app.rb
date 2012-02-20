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
puts ENV["API_KEY"]
puts ENV["SHARED_SECRET"]

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
  ss = Slideshare.new()
  return ss.get()
end
