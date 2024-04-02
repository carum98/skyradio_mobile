part of 'sk_tab.dart';

class SkTabController {
  final index = ValueNotifier<int>(0);

  void setIndex(int value) {
    index.value = value;
  }
}
