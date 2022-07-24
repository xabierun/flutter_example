import 'package:freezed_annotation/freezed_annotation.dart';

part 'count.data.freezed.dart';
part 'count.data.g.dart';

@freezed
class CountData with _$CountData {
  const factory CountData({
    required int count,
    required int countUp,
    required int countDown,
  }) = _CountData;

  factory CountData.fromJson(Map<String, dynamic> json) =>
      _$CountDataFromJson(json);
}
