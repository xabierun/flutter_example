import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_app/data/entity/postal/postal_code.dart';
import 'package:example_app/functions/postal_code_logic.dart';

final _postalCodeLogicProvider =
    Provider<PostalCodeLogic>((ref) => PostalCodeLogic());

final _postalCodeProvider = StateProvider<String>((ref) => '');

final AutoDisposeFutureProviderFamily<PostalCode, String> _apiFamilyProvider =
    FutureProvider.autoDispose
        .family<PostalCode, String>((ref, postalCode) async {
  //プロバイダの値を取得した上で、その変化を監視する。値が変化すると、その値に依存するウィジェットやプロバイダの更新が行われる。
  final postalCodeLogic = ref.watch(_postalCodeLogicProvider);

  if (!postalCodeLogic.willProceed(postalCode)) {
    return PostalCode.empty;
  }

  return postalCodeLogic.getPostalCode(postalCode);
});

class PostalViewModel {
  late final WidgetRef _ref;
  String get postalCode => _ref.watch(_postalCodeProvider);

  AsyncValue<PostalCode> postalCodeWithFamily(String postCode) =>
      _ref.watch(_apiFamilyProvider(postalCode));

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _ref = ref;
  }

  void onPostalCodeChanged(String postalCode) {
    // プロバイダの値を取得する（監視はしない）。クリックイベント等の発生時に、その時点での値を取得する場合に使用できる。
    _ref.read(_postalCodeProvider.notifier).update((state) => postalCode);
  }
}
