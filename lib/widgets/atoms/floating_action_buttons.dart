import 'package:flutter/material.dart';
import 'package:example_app/widgets/_foundations/colors.dart';

class PostalSendButton extends StatelessWidget {
  const PostalSendButton({
    Key? key,
    required this.heroTag,
  }) : super(key: key);

  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () {
        print('おされた');
      },
      backgroundColor: ConstColors.accentColor,
      child: const Icon(Icons.send),
    );
  }
}
