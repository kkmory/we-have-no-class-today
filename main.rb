require 'open-uri'
require 'nokogiri'
require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "KEY"
  config.consumer_secret     = "SECRET"
  config.access_token        = "TOKEN"
  config.access_token_secret = "TOKEN_SECRET"
end

html = open(url = 'https://typhoon.yahoo.co.jp/weather/jp/warn/40/')
$doc_warn = Nokogiri::HTML.parse(html, nil, nil)
$bofu_warns= []

def check_warn(area_id, warn_type)
  $doc_warn.xpath('//div[@id="area_'+ area_id.to_s + '"]').each do |node|
    list = node.css('tr').inner_text.split
    # テスト用データ list = ["筑豊", "筑豊地方", "直方市", "強風注意報", "飯塚市", "暴風警報", "田川市", "暴風警報", "宮若市", "大雨警報", "嘉麻市", "発表なし", "小竹町", "発表なし", "鞍手町", "発表なし", "桂川町", "発表なし", "香春町", "発表なし", "添田町", "発表なし", "糸田町", "発表なし", "川崎町", "発表なし", "大任町", "発表なし", "赤村", "発表なし", "福智町", "発表なし"]
    list.each_with_index do |n, i|
      $bofu_warns.push(list[i-1]) if n == warn_type
    end
  end
end

check_warn("8210", "暴風警報") #福岡地方
check_warn("8220", "暴風警報") #北九州地方
check_warn("8230", "暴風警報") #筑豊地方

unless $bofu_warns[0].nil?
  head = "休講の可能性があります。事務からのメールに注意してください。現在、暴風警報が以下の地域に発表されています。（#{Time.now.strftime("%m/%d %H:%M")}現在）\n"
  data = $bofu_warns.join(" ")
  @client.update(head + data)
  puts "ツイートされました（#{Time.now.strftime("%m/%d %H:%M")}現在）"
else
  puts "警報なし（#{Time.now.strftime("%m/%d %H:%M")}現在）"
end
