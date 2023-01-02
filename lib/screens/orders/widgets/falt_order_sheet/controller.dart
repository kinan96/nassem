import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:nassem/utils/custom_helpers/pick_image.dart';

class FaltOrderSheetController extends GetxController {
  FaltOrderSheetController({this.orderTypeId});
  final int? orderTypeId;
  int get allFilesLength => imagesPaths.length + filesPaths.length;
  List<String> imagesPaths = [];
  List<String> filesPaths = [];
  pickImageFile() async {
    pickImage().then((value) {
      if (value != null) {
        imagesPaths.add(value.path);
        update();
      }
    });
  }

  pickFiles() async {
    FilePicker.platform
        .pickFiles(
      allowCompression: true,
      allowMultiple: true,
    )
        .then((value) {
      if (value?.files.isNotEmpty == true) {
        filesPaths
            .addAll(value?.files.map((e) => e.path.toString()).toList() ?? []);
        update();
      }
    });
  }
}
