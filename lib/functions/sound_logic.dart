import 'package:audioplayers/audioplayers.dart';
import 'package:example_app/data/entity/count/count.data.dart';
import 'package:example_app/functions/count_data_change_notifier.dart';

class SoundLogic with CountDataChangeNotifier {
  static const SOUND_DATA_UP = 'sounds/Onoma-Flash07-1(High-Long).mp3';
  static const SOUND_DATA_DOWN = 'sounds/Onoma-Flash08-1(High-Long).mp3';
  static const SOUND_DATA_RESET = 'sounds/Onoma-Flash09-1(High-Long).mp3';

  // 複数再生する場合はcacheを複製
  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  // 音楽ファイルの読み込み処理
  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  void valueChanged(CountData oldValue, CountData newValue) {
    if (newValue.countUp == 0 &&
        newValue.countDown == 0 &&
        newValue.count == 0) {
      playResetSound();
    } else if (oldValue.countUp + 1 == newValue.countUp) {
      playUpSound();
    } else if (oldValue.countDown + 1 == newValue.countDown) {
      playDownSound();
    }
  }

  // 音楽ファイルの実行処理(プラスボタン押下時)
  void playUpSound() {
    _cache.play(SOUND_DATA_UP);
  }

  // 音楽ファイルの実行処理(マイナスボタン押下時)
  void playDownSound() {
    _cache.play(SOUND_DATA_DOWN);
  }

  // 音楽ファイルの実行処理(リセットボタン押下時)
  void playResetSound() {
    _cache.play(SOUND_DATA_RESET);
  }
}
