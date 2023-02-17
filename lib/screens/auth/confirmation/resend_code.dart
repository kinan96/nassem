// ignore_for_file: library_private_types_in_public_api

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/custom_widgets/custom_text.dart';

class ResendCodeTimerButton extends StatefulWidget {
  final int? timer;
  final String? text;
  final Function()? onActivePress;
  const ResendCodeTimerButton(
      {Key? key, this.onActivePress, this.timer, this.text})
      : super(key: key);

  @override
  _ResendCodeTimerButtonState createState() => _ResendCodeTimerButtonState();
}

class _ResendCodeTimerButtonState extends State<ResendCodeTimerButton> {
  final CountDownController? _controller = CountDownController();
  @override
  void initState() {
    _active = false;
    super.initState();
  }

  late bool _active;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              if (_active) _controller?.restart();
              if (mounted) {
                setState(() {
                  _active = false;
                });
              }
            },
            child: CustomText(
              "resend".tr,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(
          width: 10,
        ),
        CircularCountDownTimer(
          duration: widget.timer ?? 60,
          initialDuration: 0,
          controller: _controller,
          width: 30,
          height: 30,
          ringColor: AppColors.greyContainer,
          ringGradient: null,
          fillColor: AppColors.primary,
          fillGradient: null,
          backgroundColor: AppColors.white,
          backgroundGradient: null,
          strokeWidth: 2.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
            fontSize: 12.0,
            color: AppColors.primary,
          ),
          textFormat: CountdownTextFormat.S,
          isReverse: false,
          isReverseAnimation: false,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () async {
            if (_active) {
              await widget.onActivePress?.call();
            }
          },
          onComplete: () {
            if (mounted) {
              setState(() {
                _active = true;
              });
            }
          },
        ),
      ],
    );
  }
}
