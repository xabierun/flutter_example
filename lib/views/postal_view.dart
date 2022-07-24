import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example_app/providers/postal_provider.dart';
import 'package:example_app/utils/SizeConfig.dart';
import 'package:example_app/view_models/postal_view_model.dart';
import 'package:example_app/widgets/_foundations/colors.dart';
import 'package:example_app/widgets/atoms/floating_action_buttons.dart';

class PostalPage extends ConsumerStatefulWidget {
  const PostalPage(this.viewModel, {Key? key}) : super(key: key);

  final PostalViewModel viewModel;

  @override
  ConsumerState<PostalPage> createState() => _PostalPageState();
}

class _PostalPageState extends ConsumerState<PostalPage>
    with TickerProviderStateMixin {
  late PostalViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = widget.viewModel;
    _viewModel.setRef(ref, this);
  }

  @override
  Widget build(BuildContext context) {
    final familyPostalCode =
        ref.watch(apiFamilyProvider(ref.watch(postalCodeProvider)));

    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColors.mainColor,
        title: const Text('郵便番号検索システム'),
      ),
      backgroundColor: ConstColors.subColor,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.blockSizeHorizontal! * 94,
              ),
              child: TextFormField(
                onChanged: _viewModel.onPostalCodeChanged,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  hintText: '郵便番号を入力してください。例：1000000',
                  filled: true,
                  border: OutlineInputBorder(),
                ),
                maxLength: 7,
              ),
            ),
            Expanded(
              child:
                  _viewModel.postalCodeWithFamily(_viewModel.postalCode).when(
                        data: (data) => ListView.separated(
                          itemCount: data.data.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.data[index].ja.prefecture),
                                Text(data.data[index].ja.address1),
                                Text(data.data[index].ja.address2),
                                Text(data.data[index].ja.address3),
                                Text(data.data[index].ja.address4),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.black,
                          ),
                        ),
                        // error: (error, stack, data) => Text(error.toString()),
                        error: (error, stack) => Text(error.toString()),
                        loading: () => const AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator(),
                        ),
                      ),
            ),
          ],
        ),
      )),
      floatingActionButton: const PostalSendButton(heroTag: 'postal'),
    );
  }
}
