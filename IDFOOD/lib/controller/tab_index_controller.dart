import 'package:get/get.dart';

class TabIndexController extends GetxController{
  final RxInt _tabindex=0.obs;

  int get tabindex => _tabindex.value;
  set setTabindex(int newValue){
    _tabindex.value=newValue;
  }
}