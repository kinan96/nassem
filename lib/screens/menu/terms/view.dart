import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/constants/colors.dart';
import 'package:nassem/utils/custom_widgets/custom_app_bar.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_app_screen.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppScreen(
      appBar: customAppBar(context, title: "terms".tr, titleHero: true),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 20,
          ),
          Center(
            child: CustomImage(
              svgAsset: "assets/images/q.svg",
              height: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomText("سياسة نسيم"),
          SizedBox(
            height: 10,
          ),
          CustomText(
            "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدامهنا يوجد محتوى نصي، هنا يوجد محتوى فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء.",
            color: AppColors.grey,
            fontSize: 12,
          )
        ],
      )),
    );
  }
}
