import 'package:brain_train/controllers/home_controller.dart';
import 'package:brain_train/route_names.dart';
import 'package:brain_train/screens/about_screen.dart';
import 'package:brain_train/screens/empty_screen.dart';
import 'package:get/get.dart';
import 'controllers/math_basic_controller.dart';
import 'home.dart';
import 'sub_home.dart';

class Routes {
  static final routes = [
    GetPage(
        name: RouteNames.HOME_SREEN,
        page: () => HomeScreen(),
        binding: HomeBinding()
    ),
    GetPage(
        name: RouteNames.SUB_HOME_SREEN,
        page: () => SubHomeScreen(),
    ),
    GetPage(
        name: RouteNames.ABOUT_SCREEN,
        page: () => AboutScreen(),
    ),
    GetPage(
        name: RouteNames.EMPTY_SCREEN,
        page: () => EmptyScreen(),
    ),
  ];
}


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}