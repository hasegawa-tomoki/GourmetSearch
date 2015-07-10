# GourmetSearch
書籍「[TECHNICAL MASTER はじめてのiOSアプリ開発　Swift対応版](http://www.amazon.co.jp/dp/4798043656)」の Chapter 6〜8 のサンプルプログラムです。

## はじめに

2015年7月現在の Xcode 最新版、Xcode 6.4 では搭載されるSwiftのバージョンが 1.2 となり、書籍掲載の 1.1 とは若干文法が変更されました。

書籍でも解説していますが、iOS開発では基本的に最新の Xcode を使うことが要求されます。Xcoeについて、現時点では Xcode 6.4 を使用した開発をお勧めします。

また、書籍執筆時点では CocoaPods が Swift のライブラリに対応していなかったため、Objective-C のライブラリの管理には CocoaPods を使用し、Swift のライブラリの管理には ``git submodule`` を使用していました。CocoaPods はその後  Swift のライブラリにも対応しています。

現時点での最適なライブラリ管理法は、Objective-C 、Swift ともに CocoaPods で管理する方法です。

この様な理由で、現時点では、Xcode 6.4 と CocoaPods を使うのが最もお勧めの構成です。
 
## 3つの手順

ここでは3つの方法での ``GourmetSearch`` アプリ開発をサポート・解説しています。

どの方法も書籍中の前提と同様に iOS8 以降をサポートするアプリの開発が可能です。

前述のとおり、お勧めは Xcode 6.4 と CocoaPods を使う方法です。 

1.Xcode 6.4 で Swift のライブラリを CocoaPods で管理する方法

現時点で一番おすすめの方法です。

* 2015年7月現在もっとも標準的な構成です。
* ライブラリを CocoaPods で管理するため、Xcode 上での複雑な設定が不要です。
* 最新の Xcode に内蔵される Swift が Swift 1.2 のため、書籍掲載のプログラムに若干の修正が必要です。
 
iOS8 以降サポートのアプリを開発する限り、これ以外の方法を選択するメリットはありません。
このドキュメントの次章以降で方法を解説しています。
 
2.Xcode 6.4 で Swift のライブラリを git で管理する方法

最新のXcodeを使用して書籍掲載の手順で学習を進める方法です。

* ライブラリ組み込みを書籍のままの手順で進めることができます。
* 最新の Xcode に内蔵される Swift が Swift 1.2 のため、書籍掲載のプログラムに若干の修正が必要です。

現時点でこの方法を選択するメリットは無く、1.の方法を使用することをお勧めします。

詳細な手順は [NoCocoaPods.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/NoCocoaPods.md) を参照してください。

3.Xcode 6.1.1 で Swift のライブラリを git で管理する方法

古いバージョンのXcodeを使用して書籍掲載の手順で学習を進める方法です。

* ライブラリ組み込みやソースコードを書籍のままの手順で進めることができます。
* この方法で使用する Swift のバージョンは 1.1 です。
* 多くのオープンソースライブラリではメインのサポートが Swift 1.2 に移行しており、Swift 1.1 の更新は積極的には行われません。

現時点でこの方法を選択するメリットは無く、1.の方法を使用することをお勧めします。

詳細な手順は [Swift11.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/Swift11.md) を参照してください。


## Swift のライブラリを CocoaPods で管理する方法

Swift のライブラリを CocoaPods で管理するには、Objective-C のライブラリ同様、``Podfile`` にライブラリ名やバージョンを記述します。

AlamofireとSwiftyJSONを使用する場合以下の様に記述します。
2行目の表記は Swift のライブラリを管理する場合に必要です。

```
platform :ios, '8.0'
use_frameworks!

pod 'SDWebImage'
pod 'Alamofire', '~> 1.2'
pod "SwiftyJSON", ">= 2.2"
```

なお、Alamofire-SwiftyJSON がCocoaPods対応していないため、Alamofire-SwiftyJSON を使用しない形に変更する必要があります。詳細は書籍のP349 リスト06-12を参照してください。

## 書籍の手順変更

SwiftのライブラリにもCocoaPodsを使う場合、書籍を以下の様に読み替えます。

* ライブラリ組込方法の変更
  * P296 「Swiftベースのライブラリの組み込み」の直前までは変更無し。
  * P296 「Swiftベースのライブラリの組み込み」からP303 「ライブラリとライセンス」の直前までは実行しない。
  * その代わりに以下の手順で Swift のライブラリを CocoaPods で追加する。
    * ``Podfile``に上記の様に ``use_frameworks!`` 行と、Alamofire, SwiftyJSONの行を追加。
    * ``pod install`` を実行
* Alamofire-SwiftyJSON が CocoaPods に対応していないため、P349を参考に Alamofire-SwiftyJSON を使わない形で Alamofire を使用する。

## Swift 1.2

P173ページの記述の通り、Xcode 6.4 に内蔵されている Swift 1.2 では Swift 1.1 で利用していた``as``によるダウンキャストは``as!``と表記する必要があります。

書籍の通りにプログラムを入力するとXcodeのエラーが以下の様に表示されます。

``'AnyObject?' is not convertible to '〜'; did you mean to use 'as!' to force downcast?``

このとき、指摘の通りに ``as`` → ``as!`` と変更することで Swift 1.2 で実行可能です。

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
