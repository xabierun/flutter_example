import 'package:example_app/data/entity/count/count.data.dart';

typedef ValueChangedCondition = bool Function(
  CountData oldValue,
  CountData newValue,
);

abstract class CountDataChangeNotifier {
  void valueChanged(CountData oldValue, CountData newValue);
}
