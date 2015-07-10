# Xcode 6.1.1 対応プログラム

書籍に掲載された環境 Xcodd 6.1.1 でここからサンプルソースを clone する場合、以下を参照して読み進めて下さい。

## このサンプルソースのコンパイル手順

### ソースの clone

リポジトリを以下の様に clone します。

```
$ cd ~/Documents
$ git clone -b swift11 https://github.com/hasegawa-tomoki/GourmetSearch.git
```

### ライブラリの clone

リポジトリを clone したら以下のコマンドでライブラリも clone されます。

```
$ cd GourmetSearch
$ git submodule update --init --recursive
```

``GourmetSearch.xcworkspace``を開いてプログラムをコンパイルすることができます。

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
5. プロジェクトナビゲータで ``GourmetSearch`` → ``Frameworks`` と開いて、その配下にあるファイルのうち ``libPods.a`` 以外を削除する。（選択して右クリック→``Delete``）
6. プロジェクトナビゲータから ``GourmetSearch`` を選択、``TARGETS`` → ``GourmetSearch`` を選択して ``Build Phases`` タブから、``Link Binary With Libraries`` と ``Copy Files`` 欄から ``Alamofire``, ``SwiftyJSON``, ``Alamofire-SwiftyJSON`` を削除し、本書P300を参照して再度 ``Copy Files`` と ``Link Binary With Libraries`` を設定する。
