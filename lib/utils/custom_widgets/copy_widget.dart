import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_app_image.dart';
import 'custom_button.dart';

class CustomCopyIcon extends StatelessWidget {
  final String text;
  const CustomCopyIcon({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonType: ButtonType.inkwell,
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: text));
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomImage(
          svgAsset: "assets/images/copy.svg",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
