import 'package:flutter/cupertino.dart';
import '../screens/checkout_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../widgets/card_interior.dart';

class BottomRoutingProvider extends ChangeNotifier {
  final pages = [CardInterior(), SearchScreen(), CheckoutScreen(), ProfileScreen()];
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void changePageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}