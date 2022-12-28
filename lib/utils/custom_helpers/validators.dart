// import 'customMap/mapBloc.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';

String? mobileValidate(v) {
  if (v == null || v.isEmpty) {
    return "phone_validate1".tr;
  }
  // else if (v.length >= 2 && !v.toString().startsWith("05")) {
  //   return "phone_validate2".tr;
  // } else if (v.length < 10) {
  //   return "phone_validate3".tr;
  // }
  else if (int.tryParse(v) == null) {
    return "phone_validate4".tr;
  } else {
    return null;
  }
}

String? taxValidate(v) {
  if (v.length > 0 && int.tryParse(v) == null) {
    return "tax_validate1".tr;
  } else if (v.length > 0 && v.length < 15) {
    return "tax_validate2".tr;
  } else {
    return null;
  }
}

String? emptyDropDownValidate(value) {
  if (value == null || value == "") {
    return "empty_validate".tr;
  } else {
    return null;
  }
}

String? emptyValidate(v) {
  if (v.isEmpty) {
    return "empty_validate".tr;
  } else {
    return null;
  }
}

String? priceValidate(v) {
  if (v.isEmpty) {
    return "price_validate1".tr;
  } else if (double.tryParse(v) == null) {
    return "price_validate2".tr;
  } else {
    return null;
  }
}

String? percentatgeValidate(v) {
  if (v.isEmpty) {
    return "empty_validate".tr;
  } else if ((double.tryParse(v) ?? 101) > 100 ||
      (double.tryParse(v) ?? -1) < 0) {
    return "wrong_percent".tr;
  } else {
    return null;
  }
}

String? numberValidate(v) {
  if (v.isNotEmpty && double.tryParse(v) == null) {
    return "wrong_number".tr;
  } else {
    return null;
  }
}

String? entityNumberValidate(
  v,
) {
  if (v.isEmpty) {
    return "empty_validate".tr;
  } else if (v.isNotEmpty && double.tryParse(v) == null) {
    return "wrong_number".tr;
  } else {
    return null;
  }
}

String? nameValidate(v) {
  if (v.isEmpty) {
    return "name_validate".tr;
  } else {
    return null;
  }
}

String? name4Validate(v) {
  List co = v.toString().split(" ");
  if (v.isEmpty) {
    return "name_validate".tr;
  } else if (co.last == "" || co.length < 4) {
    return "من فضلك أدخل اسمك الرباعي";
  } else {
    return null;
  }
}

String? nullVaildate(String? v) {
  return null;
}

String? emailValidate(v) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (v.length > 0 && !regex.hasMatch(v)) {
    return "email_validate".tr;
  } else {
    return null;
  }
}

String? passwordValidate(v) {
  if (v == null || v.isEmpty) {
    return "password_validate1".tr;
  } else if (v.length < 8) {
    return "password_validate2".tr;
  } else {
    return null;
  }
}

String? doublePasswordValidate(v1, v2) {
  if (v1 == null || v1.isEmpty) {
    return "password_validate1".tr;
  } else if (v1.length < 8) {
    return "password_validate2".tr;
  } else if (v1 != v2) {
    return "double_password_validate".tr;
  } else {
    return null;
  }
}
