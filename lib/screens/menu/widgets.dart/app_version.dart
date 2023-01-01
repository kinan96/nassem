import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getVersion(),
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              "application_version".tr,
              color: AppColors.grey,
              textAlign: TextAlign.center,
            ),
            snapshot.hasData
                ? CustomText(
                    snapshot.data ?? "",
                    color: AppColors.grey,
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.only(bottom: 20, top: 5),
                  )
                : const LinearProgressIndicator()
          ],
        );
      },
    );
  }

  Future<String?> getVersion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activate();
    return remoteConfig.getString("app_version");
  }
}
