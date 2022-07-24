import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_app/data/entity/count/count.data.dart';
import 'package:example_app/functions/button_animation_logic.dart';
import 'package:example_app/functions/count_data_change_notifier.dart';
import 'package:example_app/functions/logic.dart';
import 'package:example_app/functions/shared_preference_logic.dart';
import 'package:example_app/functions/sound_logic.dart';
import 'package:example_app/providers/provider.dart';

class ViewModel {
  final Logic _logic = Logic();

  final SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;
  late ButtonAnimationLogic _buttonAnimationLogicMinus;
  late ButtonAnimationLogic _buttonAnimationLogicReset;

  late final WidgetRef _ref;

  List<CountDataChangeNotifier> notifiers = [];

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _ref = ref;

    ValueChangedCondition conditionPlus;
    conditionPlus = (CountData oldValue, CountData newValue) {
      return oldValue.countUp + 1 == newValue.countUp;
    };

    _buttonAnimationLogicPlus =
        ButtonAnimationLogic(tickerProvider, conditionPlus);
    _buttonAnimationLogicMinus = ButtonAnimationLogic(tickerProvider,
        (CountData oldValue, CountData newValue) {
      return oldValue.countDown + 1 == newValue.countDown;
    });
    _buttonAnimationLogicReset = ButtonAnimationLogic(
      tickerProvider,
      (oldValue, newValue) => newValue.countUp == 0 && newValue.countDown == 0,
    );

    // キャッシュにロード
    _soundLogic.load();

    notifiers = [
      _soundLogic,
      _buttonAnimationLogicPlus,
      _buttonAnimationLogicMinus,
      _buttonAnimationLogicReset,
      SharedPreferencesLogic(),
    ];

    SharedPreferencesLogic.read().then((value) {
      _logic.init(value);
      update();
    });
  }

  String get count => _ref.watch(countDataProvider).count.toString();

  String get countUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  String get countDown => _ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  AnimationCombination get animationPlusCombination =>
      _buttonAnimationLogicPlus.animationCombination;

  AnimationCombination get animationMinusCombination =>
      _buttonAnimationLogicMinus.animationCombination;

  AnimationCombination get animationResetCombination =>
      _buttonAnimationLogicReset.animationCombination;

  void onIncrease() {
    _logic.increase();
    update();
  }

  void onDecrease() {
    _logic.decrease();
    update();
  }

  void onReset() {
    _logic.reset();
    update();
  }

  void onScreenNavigate(BuildContext context) {
    Navigator.pushNamed(context, '/postal');
  }

  void update() {
    // 現在の値を取得
    final oldValue = _ref.watch(countDataProvider.notifier).state;

    // stateの変更処理
    _ref.watch(countDataProvider.notifier).update((state) => _logic.countData);

    // 変更後の値を取得
    final newValue = _ref.watch(countDataProvider.notifier).state;

    // 音楽実行処理とアニメーション実行処理
    for (final element in notifiers) {
      element.valueChanged(oldValue, newValue);
    }
  }
}
