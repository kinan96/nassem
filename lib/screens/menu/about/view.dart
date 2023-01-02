import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, title: "about".tr, titleHero: true),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomImage(
              svgAsset: "assets/images/Mask group.svg",
              fit: BoxFit.contain,
              width: Get.width,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomText("نحن نأخذ الزهور بشكل شخصي ونجلب لك السعادة"),
          const SizedBox(
            height: 10,
          ),
          const CustomText(
            "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدامهنا يوجد محتوى نصي، هنا يوجد محتوى فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء.",
            color: AppColors.grey,
            fontSize: 12,
          )
        ],
      )),
    );
  }
}
