import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:example_app/data/entity/count/count.data.dart';
import 'package:example_app/functions/count_data_change_notifier.dart';

class ButtonAnimationLogic with CountDataChangeNotifier {
  // コンストラクタ
  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition) {
    // アニメーションコントローラー定義
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 300),
    );

    _animationScale = _animationController
        .drive(CurveTween(curve: const Interval(0.1, 0.7)))
        .drive(Tween(begin: 1, end: 1.8));

    _animationRotation = _animationController
        .drive(
          CurveTween(
            curve: Interval(
              0.4,
              0.8,
              curve: ButtonRotateCurve(),
            ),
          ),
        )
        .drive(Tween(begin: 0, end: 1));

    _animationCombination = AnimationCombination(
      _animationScale,
      _animationRotation,
    );
  }

  // 初期化
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<double> _animationRotation;

  late AnimationCombination _animationCombination;

  AnimationCombination get animationCombination => _animationCombination;

  ValueChangedCondition startCondition;

  void dispose() {
    _animationController.dispose();
  }

  void start() {
    _animationController.forward().whenComplete(
          () => _animationController.reset(),
        );
  }

  @override
  void valueChanged(CountData oldValue, CountData newValue) {
    if (startCondition(oldValue, newValue)) {
      start();
    }
  }
}

class ButtonRotateCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(2 * math.pi * t) / 16;
  }
}

class AnimationCombination {
  AnimationCombination(
    this.animationScale,
    this.animationRotation,
  );

  final Animation<double> animationScale;
  final Animation<double> animationRotation;
}
