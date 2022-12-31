import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import '../constants/colors.dart';
import '../constants/styles_and_themes.dart';
import '../custom_helpers/validators.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Color fillColor;
  final bool cancelLabel;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final String? svgIconAsset;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enabled;
  final String? imageIcon;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool isPassword;
  final Function(String)? onChanged;
  final Function(String)? onSaved;
  final Function? onEditingComplete;
  final Function? onTap;
  final bool isDenes;
  final bool readOnly;
  final Color? unSelectedBorderColor;
  final bool alwaysLabelOn;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  final Color? labelColor;
  final TextAlign? textAlign;

  final Color? textColor;
  const CustomTextFormField({
    this.controller,
    this.svgIconAsset,
    this.textAlign,
    this.padding,
    this.textColor,
    this.labelColor,
    this.unSelectedBorderColor,
    this.focusNode,
    this.isDenes = false,
    this.imageIcon,
    this.prefixIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.alwaysLabelOn = false,
    this.borderColor,
    this.cancelLabel = false,
    this.suffixIcon,
    this.borderRadius,
    this.enabled = true,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.fillColor = AppColors.background,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.hint,
    this.label,
    this.validator = nullVaildate,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.readOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _hidePassword;
  bool? _hideLabel;
  bool errorValidate = false;
  late FocusNode _focus;
  void _onFocusChange() {
    if (!_focus.hasFocus && mounted) {
      setState(() {
        _hideLabel = true;
      });
    }
  }

  @override
  void initState() {
    _hidePassword = widget.isPassword;
    _hideLabel = true;
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
          offstage: !widget.alwaysLabelOn &&
                  (_hideLabel == true || widget.cancelLabel) ||
              widget.label == null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                widget.label ?? "",
                fontSize: 14,
                color: errorValidate &&
                        (widget.validator?.call(widget.controller?.text) !=
                            null)
                    ? AppColors.red
                    : (widget.labelColor ?? AppColors.greyText),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 7,
              )
            ],
          ),
        ),
        TextFormField(
          focusNode: _focus,
          validator: widget.validator,
          controller: widget.controller,
          style: TextStyle(
              color: errorValidate &&
                      (widget.validator?.call(widget.controller?.text) != null)
                  ? AppColors.red
                  : (widget.textColor ?? AppColors.greyText),
              fontSize: 12,
              fontWeight: FontWeight.w600),
          textAlign: widget.textAlign ?? TextAlign.start,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          minLines: (widget.keyboardType == TextInputType.multiline
              ? widget.minLines
              : 1),
          maxLines: widget.isPassword
              ? 1
              : (widget.keyboardType == TextInputType.multiline
                  ? widget.maxLines
                  : 1),
          maxLength: widget.maxLength,
          obscureText: widget.isPassword ? _hidePassword : false,
          onChanged: (v) {
            if (mounted) {
              setState(() {
                errorValidate = true;
              });
            }
            if (widget.onChanged != null) widget.onChanged?.call(v);
          },
          onEditingComplete: () {
            if (widget.onEditingComplete != null) {
              widget.onEditingComplete?.call();
            }
          },
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(FocusNode());
            if (widget.onSaved != null) widget.onSaved?.call(v);
            setState(() {});
          },
          onSaved: (v) {
            if (mounted) {
              setState(() {
                errorValidate = true;
              });
            }
            if (widget.onSaved != null) widget.onSaved?.call(v.toString());
          },
          onTap: () {
            if (mounted) {
              setState(() {
                _hideLabel = false;
              });
            }
            if (widget.onTap != null) widget.onTap?.call();
          },
          readOnly: widget.readOnly,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            return const SizedBox();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              isDense: widget.isDenes,
              errorMaxLines: 2,
              enabledBorder: outlineInputBorder(
                  widget.borderColor ??
                      (widget.unSelectedBorderColor ??
                          AppColors.primaryWithOpacity),
                  borderRadius: widget.borderRadius),
              focusedBorder: outlineInputBorder(
                  widget.borderColor ?? AppColors.secondary,
                  borderRadius: widget.borderRadius),
              errorBorder: outlineInputBorder(AppColors.red,
                  borderRadius: widget.borderRadius),
              disabledBorder: outlineInputBorder(AppColors.primaryWithOpacity,
                  borderRadius: widget.borderRadius),
              focusedErrorBorder: outlineInputBorder(AppColors.red,
                  borderRadius: widget.borderRadius),
              border: outlineInputBorder(AppColors.white,
                  borderRadius: widget.borderRadius),
              fillColor: widget.fillColor,
              labelText: widget.label,
              hintText: widget.hint ?? widget.label,
              contentPadding: widget.padding ??
                  (widget.isDenes
                      ? const EdgeInsets.symmetric(vertical: 12)
                      : null),
              suffix: widget.suffixWidget,
              prefix: widget.prefixWidget,
              prefixIconConstraints: widget.isDenes
                  ? const BoxConstraints(maxHeight: 40, maxWidth: 30)
                  : null,
              suffixStyle: const TextStyle(
                  color: AppColors.textFieldHintText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              errorStyle: const TextStyle(
                  color: AppColors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              labelStyle: const TextStyle(
                  color: AppColors.textFieldHintText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              hintStyle: TextStyle(
                  color: widget.textColor ?? AppColors.textFieldHintText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              suffixIcon: !widget.isPassword
                  ? (widget.svgIconAsset == null
                      ? widget.suffixIcon
                      : CustomImage(
                          svgAsset: widget.svgIconAsset,
                          height: 20,
                          padding: const EdgeInsets.all(12),
                          color: AppColors.unSelectedGreyContainer,
                        ))
                  : IconButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            if (_hidePassword == true) {
                              _hidePassword = false;
                            } else {
                              _hidePassword = true;
                            }
                          });
                        }
                      },
                      icon: Icon(
                        _hidePassword == true
                            ? CupertinoIcons.eye_slash
                            : Icons.remove_red_eye_outlined,
                        color: AppColors.unSelectedGreyContainer,
                      ),
                      iconSize: 20,
                      disabledColor: AppColors.unSelectedGreyContainer,
                    ),
              prefixIcon: (widget.imageIcon == null
                  ? widget.prefixIcon
                  : IconButton(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage(widget.imageIcon ?? ""),
                        color: errorValidate &&
                                (widget.validator
                                        ?.call(widget.controller?.text) !=
                                    null)
                            ? AppColors.red
                            : null,
                      ),
                      iconSize: 20,
                      color: AppColors.unSelectedGreyContainer,
                      disabledColor: AppColors.unSelectedGreyContainer,
                    ))),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
