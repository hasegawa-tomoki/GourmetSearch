# GourmetSearch
書籍「[TECHNICAL MASTER はじめてのiOSアプリ開発　Swift対応版](http://www.amazon.co.jp/dp/4798043656)」の Chapter 6〜8 のサンプルプログラムです。

2015年5月現在の Xcode 最新版、Xcode 6.3 では搭載されるSwiftのバージョンが 1.2 となり、書籍掲載の 1.1 とは若干文法が変更されました。以下の手順は Xcode 6.3 で、ここからダウンロードしたソースコードをコンパイルするための手順です。

Xcode 6.3で書籍の手順で学習を進める場合の手順については [Swift11.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/Swift11.md) を参照してください。


## このサンプルソースのコンパイル手順

### ソースのclone

リポジトリを以下の様に clone します。

```
$ cd ~/Documents
$ git clone https://github.com/hasegawa-tomoki/GourmetSearch.git
```

### ライブラリの clone

リポジトリを clone したら以下のコマンドでライブラリも clone されます。

```
$ cd GourmetSearch
$ git submodule update --init --recursive
```

続いて、AlamofireとSwiftyJSONを更新します。

```
$ cd Alamofire-SwiftyJSON
$ cd Alamofire
$ git pull origin master
$ cd ../SwiftyJSON
$ git pull origin master
```

### プロジェクト設定

このリポジトリのワークスペースファイルからは``Copy FilesとLink Binary With Libraries``の設定を削除しています。
本書P300を参照して``Copy Files``と``Link Binary With Libraries``の設定をしてください。

### アプリケーションIDの設定

上記の設定でコンパイルは可能ですが、店舗検索のためにはYahoo!ローカルサーチAPIのアプリケーションIDを設定する必要があります。
本書P286ページを参照してアプリケーションIDを取得し、``YahooLocal.swift``の113行目に設定してください。

### コンパイルに失敗する場合

コンパイルに失敗する場合、以下の手順でライブラリの再ビルドをしてみてください。

1. メニューから ``Product`` → ``iOS Simulator`` → ``iPhone 6`` を選択する。
2. メニューから ``Product`` → ``Scheme`` → ``Alamofire`` を選択し、[Commanc] + [B]でコンパイルする。
3. 同様に ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` もコンパイルする。
4. 1. と同様に ``Product`` → ``Destination`` → ``iOS Device`` を選択し、``Alamofire``, ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` をコンパイルする。
5. プロジェクトナビゲータから ``GourmetSearch`` を選択、``TARGETS`` → ``GourmetSearch`` を選択して ``Build Phases`` タブから、``Link Binary With Libraries`` と ``Copy Files`` 欄から ``Alamofire``, ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` を削除し、本書P300を参照して再度 ``Copy Files`` と ``Link Binary With Libraries`` を設定する。

## SwiftベースのライブラリをCocoaPodsで管理する

CocoaPods 0.36 以降ではSwiftベースのライブラリをCocoaPodsで管理することができる様になりました。

swift-libs-cocoapodsブランチの内容はSwiftベースのライブラリをCocoaPods経由で管理する例です。以下の様に clone, checkout します。

```
$ cd ~/Documents
$ git clone https://github.com/hasegawa-tomoki/GourmetSearch.git
$ cd GourmetSearch
$ git checkout swift-libs-cocoapods
```

Swift のライブラリを CocoaPods で管理する場合、Objective-C のライブラリ同様、以下の様に Podfile に記述します。

* 2行目の表記は Swift のライブラリを管理する場合に必要です。
* iOS 8 以降でのみ使用可能です。

```
platform :ios, '8.0'
use_frameworks!

pod 'SDWebImage'
pod 'Alamofire', '~> 1.2'
pod "SwiftyJSON", ">= 2.2"
```

書籍の手順もiOS8以降を対象としているため、2015年5月現在は、CocoaPods を利用してライブラリを管理することをお勧めします。

なお、``Alamofire-SwiftyJSON`` がCocoaPods対応していないため、``Alamofire-SwiftyJSON`` を使用しない形に変更する必要があります。詳細は書籍のP349 リスト06-12を参照してください。
