import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNav extends StateNotifier<int> {
  BottomNav(super.state);

  void setIndex(int index) {
    state = index;
  }
}

final bottomNav = StateNotifierProvider<BottomNav, int>((ref) {
  return BottomNav(0);
});
