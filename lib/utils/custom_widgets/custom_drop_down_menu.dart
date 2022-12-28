import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/styles_and_themes.dart';
import '../custom_helpers/validators.dart';
import 'custom_text.dart';

class CustomDropDownMenu extends StatelessWidget {
  final Function(dynamic) onSelect;
  final Function(dynamic) getTextFromModel;
  final dynamic selectedValue;
  final List models;
  final String? labelText;
  final String? hintText;
  final String? emptyText;
  final bool enableValidation;
  final Color? labelColor;
  final TextAlign textAlign;
  final Color? bgColor;
  final Color? borderColor;
  final Color? viewTextColor;
  final Color? arrowColor;
  final bool withoutSearch;
  const CustomDropDownMenu({
    Key? key,
    this.borderColor,
    this.textAlign = TextAlign.start,
    this.arrowColor,
    this.withoutSearch = false,
    this.viewTextColor,
    required this.onSelect,
    this.bgColor,
    this.models = const [],
    this.hintText,
    this.selectedValue,
    this.labelText,
    this.emptyText,
    this.enableValidation = false,
    required this.getTextFromModel,
    this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
            offstage: labelText == null,
            child: CustomText(
              labelText ?? "",
              color: labelColor ?? AppColors.greyText,
              padding: const EdgeInsets.only(bottom: 10),
            )),
        Theme(
          data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                  subtitle1: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: appFontFamily),
                  subtitle2: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: appFontFamily))),
          child: DropdownSearch<dynamic>(
            popupProps: PopupProps.menu(
              emptyBuilder: (context, searchEntry) =>
                  Center(child: CustomText(emptyText ?? "no_result".tr)),
              fit: FlexFit.loose,
              constraints:
                  BoxConstraints(maxHeight: Get.height / 3, minHeight: 10),
              showSearchBox: withoutSearch == false,
              showSelectedItems: false,
              searchFieldProps: TextFieldProps(
                  textAlign: textAlign,
                  style: const TextStyle(color: AppColors.greyText)),
              itemBuilder: (context, item, isSelected) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomText(
                  getTextFromModel.call(item) ?? "",
                  color: item == selectedValue
                      ? AppColors.secondaryBlack
                      : AppColors.greyText,
                ),
              ),
            ),
            dropdownButtonProps: DropdownButtonProps(
              icon: ImageIcon(
                const AssetImage("assets/images/chevron-down.png"),
                color: arrowColor ?? AppColors.greyText,
              ),
            ),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: enableValidation ? emptyDropDownValidate : null,
            items: models,
            itemAsString: (item) => getTextFromModel.call(item) ?? "",
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: const TextStyle(color: AppColors.greyText),
              dropdownSearchDecoration: InputDecoration(
                border:
                    outlineInputBorder(borderColor ?? AppColors.transparent),
                errorBorder:
                    outlineInputBorder(borderColor ?? AppColors.transparent),
                enabledBorder:
                    outlineInputBorder(borderColor ?? AppColors.transparent),
                focusedBorder:
                    outlineInputBorder(borderColor ?? AppColors.transparent),
                disabledBorder:
                    outlineInputBorder(borderColor ?? AppColors.transparent),
                focusedErrorBorder:
                    outlineInputBorder(borderColor ?? AppColors.transparent),
                labelText: hintText ?? labelText,
                fillColor: bgColor,
                labelStyle:
                    TextStyle(color: viewTextColor ?? AppColors.greyText),
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            onChanged: onSelect,
            selectedItem: selectedValue,
          ),
        ),
      ],
    );
  }
}
