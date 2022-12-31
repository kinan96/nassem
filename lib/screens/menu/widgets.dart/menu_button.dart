import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/custom_widgets/custom_app_image.dart';
import '../../../utils/custom_widgets/custom_button.dart';
import '../../../utils/custom_widgets/custom_text.dart';

class MenuButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final String svgAsset;
  final Color? color;
  const MenuButton({
    Key? key,
    this.color,
    this.onPressed,
    required this.text,
    required this.svgAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonType: ButtonType.inkwell,
      onPressed: onPressed,
      child: Row(
        children: [
          CustomImage(
            svgAsset: svgAsset,
            height: 30,
            width: 30,
            color: color ?? AppColors.grey,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: CustomText(
            text,
            color: color ?? AppColors.grey,
          ))
        ],
      ),
    );
  }
}
