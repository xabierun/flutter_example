## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

1.ディレクトリ直下でsh sh/release_setup.shを実行

# 困った時コマンド

- [build_runnerで失敗した時](https://github.com/dart-lang/build/issues/2835)

# 採用アーキテクチャ

- MVVM-Repository

# lib配下のディレクトリ毎の役割

- constants 共通的に使用する定数を定義
- functions 各モデルで共通的に使用するファイルを定義(API通信等)
- logic -> functionsへ以降
- model 各stateを管理する
    - api apiで保持するstate -> providerとの関係性がわからなくなりそうどうしましょうか？
    - entity freezedを使用したentity
    - preference ローカルDBで保持するstate -> providerとの関係性がわからなくなりそうどうしましょうか？
    - provider アプリ内だけで保持するstate -> providerとの関係性がわからなくなりそうどうしましょうか？
- navigation 画面遷移を管理する関数を定義
- repository view_modelとmodelとの値引き渡し
- screens viewファイルを格納
- view_model view_modelファイルを格納
- utils まだ役割決めてない
- widgets 画面作成時に共通的に使用するパーツを細かく定義
    - atom 配色・フォントといった定義、ラベルボタンにフォームのパーツ単位など UI の最小要素
    - molecules atomを組み合わせたもの(ボタンとフォントの組み合わせ等)
    - organisms (ヘッダー・フッター・などの共通的なパーツ(moleculesを組み合わせ))
