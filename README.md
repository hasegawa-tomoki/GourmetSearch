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


