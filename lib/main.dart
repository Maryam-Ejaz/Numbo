import 'package:flutter/material.dart';
import 'package:flutter_calculator/bindings/my_bindings.dart';
import 'package:flutter_calculator/screen/main_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_calculator/history_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      title: "Calculator",
      home: MainScreen(),
    );
  }
}
