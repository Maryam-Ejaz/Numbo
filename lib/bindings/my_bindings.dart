import 'package:flutter_calculator/controller/calculate_controller.dart';
import 'package:flutter_calculator/controller/historyController.dart';
import 'package:get/instance_manager.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculateController());
    Get.lazyPut(() => HistoryController());
  }
}
