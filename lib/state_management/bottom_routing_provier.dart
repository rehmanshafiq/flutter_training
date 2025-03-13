import 'package:flutter_bloc/flutter_bloc.dart';

class BottomRoutingCubit extends Cubit<int> {
  BottomRoutingCubit() : super(0);

  void changePageIndex(int index) {
    emit(index);
  }
}