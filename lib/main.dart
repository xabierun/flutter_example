import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_app/navigation/navigator.dart';

void main() {
  runApp(
    // providerの情報(state)を下位モジュールに伝播させる
    const ProviderScope(
      child: AppNavigator(),
    ),
  );
}
