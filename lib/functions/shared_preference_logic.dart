// TODO(tano): modelsに移行, https://URL-to-issue.

import 'package:example_app/data/entity/count/count.data.dart';
import 'package:example_app/functions/count_data_change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLogic with CountDataChangeNotifier {
  static const keyCount = 'COUNT';
  static const keyCountUp = 'COUNT_UP';
  static const keyCountDown = 'COUNT_DOWN';

  @override
  Future<void> valueChanged(CountData oldValue, CountData newValue) async {
    // ignore: omit_local_variable_types
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt(keyCount, newValue.count);
    sharedPreferences.setInt(keyCountUp, newValue.countUp);
    sharedPreferences.setInt(keyCountDown, newValue.countDown);
  }

  static Future<CountData> read() async {
    // ignore: omit_local_variable_types
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return CountData(
      count: await sharedPreferences.getInt(keyCount) ?? 0,
      countUp: await sharedPreferences.getInt(keyCountUp) ?? 0,
      countDown: await sharedPreferences.getInt(keyCountDown) ?? 0,
    );
  }
}
