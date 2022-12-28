import 'package:get/get.dart';

import 'arabic.dart';
import 'english.dart';

enum Lang { ar, en }

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'ar_SA': ar, 'en_US': en};
}
