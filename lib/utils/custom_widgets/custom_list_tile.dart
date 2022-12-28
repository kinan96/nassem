import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.containerWidth,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.onTap,
    this.tileColor,
  }) : super(key: key);

  final double? containerWidth;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? selectedColor;
  final Color? iconColor;
  final Color? textColor;
  final Function()? onTap;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: containerWidth,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryWithOpacity,
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        selectedColor: selectedColor,
        iconColor: iconColor,
        textColor: textColor,
        onTap: onTap,
        tileColor: tileColor,
      ),
    );
  }
}
