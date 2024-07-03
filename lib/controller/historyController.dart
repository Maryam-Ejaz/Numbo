import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_calculator/history_item.dart';

class HistoryController extends GetxController {
  RxList<HistoryItem> historyItems = RxList<HistoryItem>();

  @override
  void onInit() {
    super.onInit();
    loadHistory(); // Load history items when controller initializes
  }

  void loadHistory() {
    final List<HistoryItem> result = Hive.box<HistoryItem>('history')
        .values
        .toList()
        .reversed
        .toList()
        .cast<HistoryItem>();
    historyItems.assignAll(result);
  }

  void clearHistory() {
    historyItems.clear();
    Hive.box<HistoryItem>('history').clear();
  }
}
