import 'dart:convert';
import 'dart:math';

import 'package:ansi_logger/ansi_logger.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final logger = AnsiLogger();
  DateTime? _start;
  String? get _duration {
    if (_start == null) return 'without duration ➤ ';
    var duration = DateTime.now().difference(_start!).inMilliseconds;
    return '$duration MS ➤ ';
  }

  dynamic tryGetMap(dynamic data) {
    try {
      if (data is String) {
        return jsonDecode(data);
      } else {
        return data;
      }
    } catch (e) {
      return data;
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    // if (!kDebugMode) return;
    logger.logBox('Got error ${err.requestOptions.uri} at ${DateTime.now()}');
    dynamic requestData;
    List<IFile>? files;
    if (err.requestOptions.data is FormData) {
      var fd = err.requestOptions.data as FormData;
      requestData = {};
      for (var element in fd.fields) {
        requestData[element.key] = element.value;
      }
      files = [];
      for (var k in fd.files) {
        files.add(IFile(k.value.filename ?? '', k.key, k.value.length));
      }
    } else {
      requestData = err.requestOptions.data;
    }

    logger.logHttp(
      url: err.requestOptions.uri.toString(),
      statusMessage: '$_duration${err.response?.statusMessage}',
      method: err.requestOptions.method,
      statusCode: err.response?.statusCode ?? 0,
      queryParameters: err.requestOptions.queryParameters,
      requestHeaders: err.requestOptions.headers,
      responseHeaders: err.response?.headers.map ?? {},
      response: tryGetMap(err.response?.data),
      requestData: requestData,
      files: files,
    );
  }

  static String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    // if (!kDebugMode) return;
    logger.logBox(
        'Got response ${response.requestOptions.uri} at ${DateTime.now()}');
    dynamic requestData;
    List<IFile>? files;
    if (response.requestOptions.data is FormData) {
      var fd = response.requestOptions.data as FormData;
      requestData = {};
      for (var element in fd.fields) {
        requestData[element.key] = element.value;
      }
      files = [];
      for (var k in fd.files) {
        files.add(IFile(k.value.filename ?? '', k.key, k.value.length));
      }
    } else {
      requestData = response.requestOptions.data;
    }
    var bytes = _formatBytes(utf8.encode('${response.data}').length, 2);
    logger.logHttp(
      url: response.requestOptions.uri.toString(),
      statusMessage: '$bytes ➤ $_duration${response.statusMessage}',
      method: response.requestOptions.method,
      statusCode: response.statusCode ?? 0,
      queryParameters: response.requestOptions.queryParameters,
      requestHeaders: response.requestOptions.headers,
      responseHeaders: response.headers.map,
      response: tryGetMap(response.data),
      requestData: requestData,
      files: files,
    );
  }
}
