import 'package:flutter/material.dart';
import 'package:example_app/view_models/home_view_model.dart';
import 'package:example_app/view_models/postal_view_model.dart';
import 'package:example_app/views/home_view.dart';
import 'package:example_app/views/postal_view.dart';
import 'package:example_app/widgets/_foundations/colors.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 画面情報を全てここで登録するためにMaterialAppの呼び出しは原則一回
    return MaterialApp(
      // 初期画面を設定
      initialRoute: '/',
      // router
      routes: {
        '/': (context) => MyHomePage(ViewModel()), // ホーム画面
        '/postal': (context) => PostalPage(PostalViewModel()), // 郵便番号検索システム
      },
      // アプリ全体のテーマカラー
      theme: ThemeData(
        primarySwatch: ConstColors.mainColor,
      ),
    );
  }
}
