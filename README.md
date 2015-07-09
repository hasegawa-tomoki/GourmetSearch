# GourmetSearch
書籍「[TECHNICAL MASTER はじめてのiOSアプリ開発　Swift対応版](http://www.amazon.co.jp/dp/4798043656)」の Chapter 6〜8 のサンプルプログラムです。

コンパイルには以下の準備が必要です。

## ライブラリの clone

リポジトリを clone したら以下のコマンドでライブラリも clone されます。

```
$ cd GourmetSearch
$ git submodule update --init --recursive
```

## プロジェクト設定

このリポジトリのワークスペースファイルからはCopy FilesとLink Binary With Librariesの設定を削除しています。
本書P300を参照してCopy FilesとLink Binary With Librariesの設定をしてください。

## アプリケーションIDの設定

上記の設定でコンパイルは可能ですが、店舗検索のためにはYahoo!ローカルサーチAPIのアプリケーションIDを設定する必要があります。
本書P286ページを参照してアプリケーションIDを取得し、YahooLocal.swiftの113行目に設定してください。

### コンパイルに失敗する場合

コンパイルに失敗する場合、以下の手順でライブラリの再ビルドをしてみてください。

1. メニューから ``Product`` → ``Destination`` → ``iOS Simulator`` → ``iPhone 6`` を選択する。
2. メニューから ``Product`` → ``Scheme`` → ``Alamofire`` を選択し、[Commanc] + [B]でコンパイルする。
3. 同様に ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` もコンパイルする。
4. 1. と同様に ``Product`` → ``Destination`` → ``iOS Device`` を選択し、``Alamofire``, ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` をコンパイルする。
5. プロジェクトナビゲータから ``GourmetSearch`` を選択、``TARGETS`` → ``GourmetSearch`` を選択して ``Build Phases`` タブから、``Link Binary With Libraries`` と ``Copy Files`` 欄から ``Alamofire``, ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` を削除し、本書P300を参照して再度 ``Copy Files`` と ``Link Binary With Libraries`` を設定する。

