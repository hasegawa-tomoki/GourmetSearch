# 書籍の Xcode 6.4 対応

書籍の手順を Xcode 6.4 で実施する場合、以下を参照して読み進めて下さい。

## ライブラリの更新

本書で使用しているライブラリ、 ``Alamoffire``, ``SwiftyJSON`` は、 ``Alamofire-SwiftyJSON`` ライブラリから参照されています。この参照が更新されていないため、``Alamofire``, ``SwiftyJSON``を手動で更新する必要があります。

書籍のP298〜P299の操作の後で、以下の様にライブラリを更新します。

```
$ cd ~/Documents/GourmetSearch/
$ cd Alamofire-SwiftyJSON
$ cd Alamofire
$ git pull origin master
$ cd ../SwiftyJSON
$ git pull origin master
```

## Alamofireの使用法の変更

Swift 1.2では、``Alamofire`` と ``Alamofire-SwiftyJSON`` 使用の際の書式を少し修正する必要があります。

Swift 1.1 では以下の様にこれらのライブラリを使用していました。

```
Alamofire.request(.GET, apiUrl, parameters: params).responseSwiftyJSON {
  // 受信完了の処理
}
```

これに対して、Swift 1.2 では以下の様に``()``を追加する必要があります。

```
Alamofire.request(.GET, apiUrl, parameters: params).responseSwiftyJSON ({
  // 受信完了の処理
})
```

## プログラムの修正（読み替え）

P173ページの記述の通り、Swift 1.1 で利用していた``as``によるダウンキャストは``as!``と表記する必要があります。

書籍の通りにプログラムを入力するとXcodeのエラーが以下の様に表示されます。

``'AnyObject?' is not convertible to '〜'; did you mean to use 'as!' to force downcast?``

このとき、指摘の通りに ``as`` → ``as!`` と変更することで Swift 1.2 で実行可能です。

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
