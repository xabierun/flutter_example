import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_app/constants/screen_constants.dart';
import 'package:example_app/data/entity/count/count.data.dart';

final titleProvider = Provider<String>((ref) {
  return ScreenConstants.title;
});

final messageProvider = Provider<String>((ref) {
  return 'You have pushed the button this many times:';
});

final countDataProvider = StateProvider<CountData>((ref) {
  return const CountData(count: 0, countUp: 0, countDown: 0);
});
