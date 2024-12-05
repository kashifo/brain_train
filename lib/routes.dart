import 'package:brain_train/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static final routes = [
    GetPage(
        name: '/',
        page: () => HomeScreen(),
        binding: HomeBinding(),
    ),
    GetPage(
        name: '/',
        page: () => HomeScreen()
    ),
  ];
}
