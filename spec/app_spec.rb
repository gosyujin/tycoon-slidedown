require 'rubygems'
require 'rspec'
require 'kconv'
require 'pp'

describe xxxxx do
# プラットフォームがWindowsの場合標準出力をKconv.tosjisでラップ
if RUBY_PLATFORM.downcase =~ /mswin(?!ce)|mingw|cygwin|bccwin/ then
  def $stdout.write(str)
    super Kconv.tosjis(str)
  end
end

  before(:all) do 
    @response = {
      :URL => 'http://www.slideshare.net/gishi/wicket-presentation',
      :Format => 'ppt'
    }
  end

  describe 'xml parse' do
    it '200' do
      sli = Slisha.new().get()
      sli[:URL].should be == @response[:URL]
      sli[:Format].should be == @response[:Format]
    end
  end
end
