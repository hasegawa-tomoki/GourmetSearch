# GourmetSearch
書籍「[TECHNICAL MASTER はじめてのiOSアプリ開発　Swift対応版](http://www.amazon.co.jp/dp/4798043656)」の Chapter 6〜8 のサンプルプログラムです。

## はじめに

 2015年7月現在の Xcode 最新版、Xcode 6.4 では搭載されるSwiftのバージョンが 1.2 となり、書籍掲載の 1.1 とは若干文法が変更されました。

 また、書籍執筆時点では CocoaPods が Swift ベースのライブラリに対応していなかったため、Objective-C ベースのライブラリの管理には CocoaPods を使用し、Swift ベースのライブラリは ``git submodule`` で管理していましたが、現在は CocoaPods が Swift ベースのライブラリにも対応しています。

 そのため、現時点での最適なライブラリ管理法は、Objective-C ベース、Swift ベースともに CocoaPods で管理する方法です。
 
 ここでは3つの方法での ``GourmetSearch`` アプリ開発をサポート・解説しています。
 どの方法も書籍中の前提と同様に iOS8 以降をサポートするアプリの開発が可能です。
 

1. Xcode 6.4 で Swift のライブラリを CocoaPods で管理する方法

 現時点で一番おすすめの方法です。
 iOS8 以降サポートのアプリを開発する限り、これ以外の方法を選択するメリットはありません。
 このドキュメントの次章以降で方法を解説しています。
 
2. Xcode 6.4 で Swift のライブラリを git で管理する方法

 最新のXcodeを使用して書籍掲載の手順で学習を進める方法です。
 現時点でこの方法を選択するメリットは無く、1.の方法を使用することをお勧めします。
 詳細な手順は [NoCocoaPods.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/NoCocoaPods.md) を参照してください。

3. Xcode 6.1.1 で Swift のライブラリを git で管理する方法

 古いバージョンのXcodeを使用して書籍掲載の手順で学習を進める方法です。
 現時点でこの方法を選択するメリットはありません。
 この方法では Swift の旧バージョン 1.1 を使用することになります。多くのオープンソースライブラリではメインのサポートが Swift 1.2 に移行しており、Swift 1.1 の更新は積極的には行われません。
 上記1.の方法を使用することを強くお勧めします。

 詳細な手順は [Swift11.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/Swift11.md) を参照してください。


## このサンプルソースのコンパイル手順

リポジトリを以下の様に clone し、``pod install`` コマンドを実行します。実行したら``GourmetSearch.xcworkspace``を開けばそのままコンパイルが可能です。

```
$ cd ~/Documents
$ git clone https://github.com/hasegawa-tomoki/GourmetSearch.git
$ pod install
```

Swift のライブラリを CocoaPods で管理する場合、Objective-C のライブラリ同様、以下の様に Podfile に記述します。
2行目の表記は Swift のライブラリを管理する場合に必要です。

```
platform :ios, '8.0'
use_frameworks!

pod 'SDWebImage'
pod 'Alamofire', '~> 1.2'
pod "SwiftyJSON", ">= 2.2"
```

なお、``Alamofire-SwiftyJSON`` がCocoaPods対応していないため、``Alamofire-SwiftyJSON`` を使用しない形に変更する必要があります。詳細は書籍のP349 リスト06-12を参照してください。

## Swift 1.2

 Xcode 6.4 に内蔵されている Swift は、Swift 1.2 です。
 書籍で使用している Xcode 6.1.1 に内蔵されている Swift 1.1 からいくつかの仕様変更が加えられています。
 特に、P173で触れている通り、ダウンキャスト演算子 ``as`` を ``as!`` と表記する必要がありますので適宜読み替えてください
