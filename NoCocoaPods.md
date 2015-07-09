# GourmetSearch
 書籍「[TECHNICAL MASTER はじめてのiOSアプリ開発　Swift対応版](http://www.amazon.co.jp/dp/4798043656)」の Chapter 6〜8 のサンプルプログラムです。

 このドキュメントでは最新のXcode、Xcode 6.4を使用して書籍掲載の手順で学習を進める方法を解説しています。

 現時点でこの方法を選択するメリットは無く、Swift ベースのライブラリにも CocoaPods を使うことを勧めします。
 Swift ベースのライブラリにも CocoaPods を使う詳細な手順は [README.md](https://github.com/hasegawa-tomoki/GourmetSearch/blob/master/README.md) を参照してください。

## このサンプルソースのコンパイル手順

### ソースのclone

リポジトリを以下の様に clone します。

```
$ cd ~/Documents
$ git clone -b no-cocoapods https://github.com/hasegawa-tomoki/GourmetSearch.git
```

### ライブラリの clone

リポジトリを clone したら以下のコマンドでライブラリも clone されます。

```
$ cd GourmetSearch
$ git submodule update --init --recursive
```

続いて、AlamofireとSwiftyJSONを更新します。この操作で Swift 1.2 対応の Alamofire, SwiftyJSON がダウンロードされます。

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
3. 同様に ``SwiftyJSON`` もコンパイルする。
4. 1. と同様に ``Product`` → ``Destination`` → ``iOS Device`` を選択し、``Alamofire``, ``SwiftyJSON`` をコンパイルする。
5. プロジェクトナビゲータから ``GourmetSearch`` を選択、``TARGETS`` → ``GourmetSearch`` を選択して ``Build Phases`` タブから、``Link Binary With Libraries`` と ``Copy Files`` 欄から ``Alamofire``, ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` を削除し、本書P300を参照して再度 ``Copy Files`` と ``Link Binary With Libraries`` を設定する。

## Swift 1.2

P173ページの記述の通り、Xcode 6.4 に内蔵されている Swift 1.2 では Swift 1.1 で利用していた``as``によるダウンキャストは``as!``と表記する必要があります。

書籍の通りにプログラムを入力するとXcodeのエラーが以下の様に表示されます。

``'AnyObject?' is not convertible to '〜'; did you mean to use 'as!' to force downcast?``

このとき、指摘の通りに ``as`` → ``as!`` と変更することで Swift 1.2 で実行可能です。

また、Aamofire-SwiftyJSON が Swift 1.2 対応していないため使用しい様に修正しています。


