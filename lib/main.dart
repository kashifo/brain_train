import 'package:brain_train/home.dart';
import 'package:brain_train/models/route_names.dart';
import 'package:brain_train/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue,));

    return GetMaterialApp(
      title: 'Brain Train',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      initialRoute: RouteNames.HOME_SREEN,
    );
  }
}

