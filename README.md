# GourmetSearch
書籍「[TECHNICAL MASTER はじめてのiOSアプリ開発　Swift対応版](http://www.amazon.co.jp/dp/4798043656)」の Chapter 6〜8 のサンプルプログラムです。

書籍の内容は執筆時点での最新環境を想定しています。

このリポジトリでは2015年10月現在の最新環境である Xcode 7 と、Swift 2.0 を使って本書の学習をすすめるための差分情報とサンプルソースを提供しています。

書籍の購入をご検討の場合、上記ご承知置きください。

## はじめに

書籍の記述は Xcode 6.3 を前提としています。このバージョンには Swift 1.1 が搭載されていました。

その後、Swift のバージョンは2015年7月の Xcode 6.4 で Swift 1.2 に、2015年9月の Xcode 7 で Swift 2.0 に更新されました。また、Xcode 7 と同時に iOS 9 がリリースされています。

書籍でも解説していますが、iOS開発では基本的に最新の Xcode を使うことが要求されます。そのため、Xcodeについて、現時点では Xcode 7 を使用した開発をお勧めします。

このリポジトリの master ブランチには最新の Xcode 7 + iOS 9 でアプリを開発する場合のソースコードを置いています。

また、このリポジトリは以下のブランチを含みます。推奨はしませんが必要に応じて使い分けてください。各ブランチの詳細は後述します。

* master
* swift12
* swift11
* no-cocoapods

## CocoaPods の使用

書籍執筆時点では CocoaPods が Swift のライブラリに対応していなかったため、Objective-C のライブラリの管理には CocoaPods を使用し、Swift のライブラリの管理には ``git submodule`` を使用していました。CocoaPods はその後  Swift のライブラリにも対応しています。

現時点での最適なライブラリ管理法は、Objective-C 、Swift ともに CocoaPods で管理する方法です。

## 各ブランチの詳細

前述のとおり、このリポジトリは4つのブランチを含みます。
各ブランチの内容は以下のとおりです。
前述のとおり、お勧めは master ブランチの方法です。

### master

Xcode 7 + Swift 2.0 で対象OSを iOS 8 & iOS 9 とする方法です。

* 2015年10月現在もっとも標準的な構成です。
* iOS 8 & iOS 9 両対応のアプリを作ることができます。
* ライブラリを CocoaPods で管理するため、Xcode 上での複雑な設定が不要です。
* Swift のライブラリを CocoaPods で管理する方法は後述します。
* Swift が Swift 2.0 であることと、iOS 9 をサポートするため、書籍掲載のプログラムに修正が必要です。

iOS 8 以降サポートのアプリを開発する限り、この方法を強くお勧めします。


### swift12

Xcode 6.4 + Swift 1.2 で Swift のライブラリを CocoaPods で管理する方法です。

紙面のソースコードからの乖離が少なめで済むメリットがありますが、

ライブラリについても Swift 1.2 対応のものを探す必要があるなどデメリットも大きくあまり現実的ではないでしょう。


### no-cocoapods

Xcode 6.4 + Swift 1.2 で Swift のライブラリを紙面の解説どおり Git で管理する方法です。
本書の前提ではライブラリの管理に CocoaPods を使用しないメリットは無く、現状この構成を選ぶメリットありません。

詳細な手順は [NoCocoaPods.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/NoCocoaPods.md)  にあります。

### swift11

Xcode 6.3 + Swift 1.1 で Swift のライブラリを紙面の解説どおり Git で管理する方法です。

ソースコードは紙面のままとなりますが、 no-cocoapods ブランチ同様、ライブラリの管理に CocoaPods を使用しないメリットは無く、現状この構成を選ぶメリットありません。

詳細な手順は [Swift11.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/Swift11.md) にあります。



## Swift のライブラリを CocoaPods で管理する方法

Swift のライブラリを CocoaPods で管理するには、Objective-C のライブラリ同様、``Podfile`` にライブラリ名やバージョンを記述します。

AlamofireとSwiftyJSONを使用する場合以下の様に記述します。
2行目の表記は Swift のライブラリを管理する場合に必要です。

```
platform :ios, '8.0'
use_frameworks!

pod 'SDWebImage'
pod 'Alamofire', '~> 2.0'
pod "SwiftyJSON", "~> 2.3"
```

なお、Alamofire-SwiftyJSON が CocoaPods 対応していないため、Alamofire-SwiftyJSON を使用しない形に変更する必要があります。詳細は書籍のP349 リスト06-12を参照してください。


## 書籍の手順変更

SwiftのライブラリにもCocoaPodsを使う場合、書籍を以下の様に読み替えます。

* ライブラリ組込方法の変更
  * P296 「Swiftベースのライブラリの組み込み」の直前までは変更無し。
  * P296 「Swiftベースのライブラリの組み込み」からP303 「ライブラリとライセンス」の直前までは実行しない。
  * その代わりに以下の手順で Swift のライブラリを CocoaPods で追加する。
    * ``Podfile``に上記の様に ``use_frameworks!`` 行と、Alamofire, SwiftyJSONの行を追加。
    * ``pod install`` を実行
* Alamofire-SwiftyJSON が CocoaPods に対応していないため、P349を参考に Alamofire-SwiftyJSON を使わない形で Alamofire を使用する。

## 仕様変更による影響

### Swift 1.2

P173の記述の通り、Xcode 6.4 に搭載されている Swift 1.2 では Swift 1.1 で利用していた``as``によるダウンキャストは``as!``と表記する必要があります。

書籍の通りにプログラムを入力するとXcodeのエラーが以下の様に表示されます。

``'AnyObject?' is not convertible to '〜'; did you mean to use 'as!' to force downcast?``

このとき、指摘の通りに ``as`` → ``as!`` と変更することで Swift 1.2 で実行可能です。

### Swift 2.0

Xcode 7 に搭載されている Swift 2.0 ではいくつかのグローバル変数がメソッド化されており、以下の様に変更する必要があります。

|Swift 1.2|Swift 2.0|
|:--------|:--------|
|contains(heystack, needle)|heystack.contains(needle)|
|find(heystack, needle)|heystack.indexOf(needle)|
|join(",", array)|array.joinWithSeparator(",")|


### iOS 9

GourmetSearch アプリを iOS 9 を前提としてコンパイルするためにはいくつかの修正が必要です。

#### APIの変更

iOS 9 ではいくつかのAPI（デリゲートメソッドなど）の定義が変わっており、プログラムに少し修正をする必要があります。

この変更の多くは`Optional`型で渡されていたパラメタが非`Optional`型で渡される様になった、という変更です。

興味がある方は c1e46d82b650e674d37e770758188eb1ff65e2fa を参照してください。

#### ATS対応

iOS 9 では App Transport Security （ATS）という機能が導入され、一定のセキュアな接続以外の外部へのネットワーク接続は拒否される様になりました。

本来的には、全ての接続をセキュアにするか、どうしてもセキュアな接続に出来ない箇所について例外を定義して対応することになりますが、本リポジトリのサンプルではATSを無効にすることで外部へのネットワーク接続を許可しています。

本書の内容を学習し終わり、本格的にご自身のアプリを作成する際にはATSの動作をネットなどで学習し、しかるべき対応をしてください。


## このサンプルソースのコンパイル手順

リポジトリを以下の様に clone し、``pod install`` コマンドを実行します。実行したら``GourmetSearch.xcworkspace``を開けばそのままコンパイルが可能です。

```
$ cd ~/Documents
$ git clone https://github.com/hasegawa-tomoki/GourmetSearch.git
$ cd GourmetSearch
$ pod install
```

## アプリケーションIDの設定

上記の設定でコンパイルは可能ですが、店舗検索のためにはYahoo!ローカルサーチAPIのアプリケーションIDを設定する必要があります。 本書P286ページを参照してアプリケーションIDを取得し、YahooLocal.swiftの113行目に設定してください。
