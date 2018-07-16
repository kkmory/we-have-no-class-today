# 暴風警報通知スクリプト

近畿大学福岡キャンパスの休講規定に定められた範囲（福岡地方、北九州地方、筑豊地方）に暴風警報が出た場合、ツイートしてお知らせします。

<br>

## How to use
Twitter Appsでアプリケーションを作成し、以下の部分にコンシューマキー等を入れてください。

```
config.consumer_key        = "KEY"
config.consumer_secret     = "SECRET"
config.access_token        = "TOKEN"
config.access_token_secret = "SECRET"
```
<br>

普通に実行します。  
自動実行したい場合は、お好みでHeorku Schedulerなどをご使用ください。
```
bundle install
ruby main.rb
```