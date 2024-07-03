import 'package:flutter/material.dart';
import 'package:flutter_calculator/theme/colors.dart';
import 'package:get/get.dart';
import '../controller/historyController.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);
  final HistoryController historyController = Get.put(HistoryController());


  /// app bar function
  AppBar appbar(
    BuildContext context,
    String title,
    IconData icon,
    Function() tap,
  ) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
      ),
      backgroundColor: DarkColors.sheetBgColor,
      actions: [
        IconButton(
          onPressed: tap,
          icon: const Icon(Icons.auto_delete_outlined, color: Colors.grey),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);


    return Scaffold(
        backgroundColor: DarkColors.scaffoldBgColor,
        appBar: appbar(
          context,
          'History',
          Icons.auto_delete_outlined,
          () {
            if (mediaQuery.orientation == Orientation.portrait){
              Navigator.pop(context);
            }
            historyController.clearHistory();
            SnackWidget.showSnackBar('History Cleared',
              'History cleared successfully');
          },
        ),
        body: Obx(() {
          var result = historyController.historyItems;
          return result.isEmpty
              ? Center(
                  child: Text(
                    'Empty!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 12.0, color: Colors.grey),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: result.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      tileColor: DarkColors.sheetBgColor,
                      title: Text(
                        result[i].title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 26.0, color: Colors.grey),
                      ),
                      subtitle: Text(
                        result[i].subtitle,
                        style: const TextStyle(color: Colors.orange),
                      ),
                    );
                  },
                );
        }));
  }
}

class SnackWidget {
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 800),
    );
  }
}

