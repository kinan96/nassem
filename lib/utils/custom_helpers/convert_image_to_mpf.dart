import 'package:dio/dio.dart';

Future<MultipartFile> convertImageToMPF(String path) async {
  return await MultipartFile.fromFile(path);
}
