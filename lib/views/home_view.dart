import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_app/functions/button_animation_logic.dart';
import 'package:example_app/providers/provider.dart';
import 'package:example_app/view_models/home_view_model.dart';
import 'package:example_app/widgets/_foundations/colors.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage(
    this.viewModel, {
    Key? key,
  }) : super(key: key);

  final ViewModel viewModel;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  late ViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = widget.viewModel;
    _viewModel.setRef(ref, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(titleProvider)),
        backgroundColor: ConstColors.mainColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(messageProvider),
            ),
            Text(
              _viewModel.count,
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // プラスボタン
                ElevatedButton(
                  onPressed: _viewModel.onIncrease,
                  child: ButtonAnimation(
                    animationCombination: _viewModel.animationPlusCombination,
                    child: const Icon(CupertinoIcons.plus),
                  ),
                ),
                // マイナスボタン
                ElevatedButton(
                  onPressed: _viewModel.onDecrease,
                  child: ButtonAnimation(
                    animationCombination: _viewModel.animationMinusCombination,
                    child: const Icon(CupertinoIcons.minus),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // カウントアップの回数更新
                Text(_viewModel.countUp),
                // カウントダウンの回数更新
                Text(_viewModel.countDown),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 画面遷移ボタン（予定）
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/postal', arguments: '1');
                  },
                  child: const Text('画面遷移ボタン'),
                ),
              ],
            ),
          ],
        ),
      ),
      // リフレッシュボタン
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag3 ',
        onPressed: _viewModel.onReset,
        child: ButtonAnimation(
          animationCombination: _viewModel.animationResetCombination,
          child: const Icon(CupertinoIcons.refresh),
        ),
      ),
    );
  }
}

class ButtonAnimation extends StatelessWidget {
  const ButtonAnimation({
    Key? key,
    required this.animationCombination,
    required this.child,
  }) : super(key: key);

  final AnimationCombination animationCombination;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animationCombination.animationScale,
      child: RotationTransition(
        turns: animationCombination.animationRotation,
        child: child,
      ),
    );
  }
}
