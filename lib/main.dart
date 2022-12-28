import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'my_app/view.dart';
import 'utils/custom_helpers/http_client_handler.dart';

late HttpClient httpClient;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  httpClient = await HttpClient.init();
  runApp(const MyApp());
}
