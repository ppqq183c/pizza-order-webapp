# pizza-order-webapp
Java(Servlet/JSP)で作成したピザ注文Webアプリ

## 概要
 
本アプリは、ユーザーがブラウザからピザを注文できるWebアプリケーションです。

従来は店舗注文の電話対応向けの社内アプリの実装でしたが、一般ユーザーが直接注文できる仕組みにすることで、
利便性の向上を目指しました。

注文処理、カート管理、画面遷移の最適化などを通じて、
ユーザー体験を意識した設計・実装を行っています。

## 技術構成

フロントエンド：JSP,HTML,CSS

バックエンド：Java(Servlet)

データベース：MySQL

## 機能一覧
- ユーザー認証
  - 新規会員登録
  - ログイン機能（パスワードのハッシュ化対応）
  - ユーザー識別にUUIDを使用

- メニュー機能
  - ピザメニュー一覧表示
  - 商品詳細表示

- キャンペーン機能
  - キャンペーン一覧表示

- 注文機能
  - カート追加・削除・数量変更
  - 注文確定処理

## 担当範囲

### DAO

- `src/main/java/dao/GetImageDBAcess.java`
- `src/main/java/dao/GetImage_CampaignDBAccess.java`
- `src/main/java/dao/ItemDAO.java`
- `src/main/java/dao/ItemMenuDisplayDBAccess.java`
- `src/main/java/dao/SearchAllMenuDBAccess.java`
- `src/main/java/dao/Campaign_DesignListDBAccess.java`

### Control

- `src/main/java/control/ImageServlet.java`
- `src/main/java/control/ImageServlet_campaign.java`
- `src/main/java/control/SizeServlet.java`

### Action

- `src/main/java/action/Campaign_DesignAction.java`
- `src/main/java/action/ItemMenuDisplayAction.java`
- `src/main/java/action/SearchAllMenuAction.java`

### Modal

- `src/main/java/model/Campaign.java`
- `src/main/java/model/Item.java`

### JSP

- `src/main/webapp/HomePage.jsp`
- `src/main/webapp/campaign.jsp`

## 工夫・苦労した点

### 工夫した点

メニュー一覧画面のカート追加時のUX改善です。

当初はカートに商品を追加するたびにページ全体を再描画する実装となっており、
操作のたびに画面遷移が発生しユーザー体験を損ねる課題がありました。

この問題を解決するため、Ajaxによる非同期通信を導入し、
ページ遷移を伴わずにカート情報のみを更新する仕組みに改善しました。

### 苦労した点

SQL以外すべて初めて触れる技術だったため、基礎理解と実装の両立に苦労しました。

とりあえず手を動かしながら小さな機能をコツコツ実装して、習得していきました。

結果として最優秀賞をいただけたので努力が評価されて嬉しかったです。

## 学びと改善点

### 学び

- MVCに分けての実装と命名規則の重要性

一人で開発しているときは自分だけがわかればいいと思ってコードを書いていましたが、いざチーム開発となると他人のコードを見ることになります。

その際、わかりにくい変数名やMVC混同のコードを見ると理解に多大な時間がかかることに気づかされました。

この経験から、命名規則の統一や責務の分離を意識し、

再現性と可読性の高いコードを書くことを徹底しています。

- 技術選定の重要性

開発途中にJSPの書き方、特にJavaの変数の持ち方に違和感を持ちネットで調べてみると現在はよりモダンな技術が使われていることに気づきました。

この経験から、技術にはそれぞれ適した用途や時代背景があることを理解し、
単に動くものを作るだけでなく、目的や将来性を踏まえて技術選定を行う重要性を学びました。

現在は、それぞれの技術の特徴やメリット・デメリットを意識して選択することを心がけています。

- チームで開発することの楽しさ

### 改善点


