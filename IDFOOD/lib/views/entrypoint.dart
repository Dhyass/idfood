import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/tab_index_controller.dart';
import 'package:idfood/views/cart/cart_page.dart';
import 'package:idfood/views/home/home_page.dart';
import 'package:idfood/views/profile/profile_page.dart';
import 'package:idfood/views/search/search_page.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

final List<Widget> pageList = const [
  HomePage(),
  SearchPage(),
  CartPage(),
  ProfilePage()
];
  @override
  Widget build(BuildContext context) {
    final controller= Get.put(TabIndexController());

    return Obx(() => Scaffold(
      body: Stack(
        children:  [
          pageList[controller.tabindex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(data:Theme.of(context).copyWith(canvasColor:kWhite),
              child: BottomNavigationBar(

                showSelectedLabels: false, // ne pas afficher le labes d'icons non select
                showUnselectedLabels: false,
                unselectedIconTheme: const IconThemeData(color: Colors.black38),
                selectedIconTheme: const IconThemeData(color : kSecondary),
                onTap: (value){
                  controller.setTabindex=value;
                },
                currentIndex: controller.tabindex,
                items: [
                  BottomNavigationBarItem(
                      icon: controller.tabindex==0? const Icon(AntDesign.appstore1) : const Icon(AntDesign.appstore_o), label: "Home"),
                 const  BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
                 const  BottomNavigationBarItem(
                     icon: Badge(
                       label: Text('1'),
                       child: Icon(FontAwesome.cart_plus)),
                     label: "Cart"

                     ),

                  BottomNavigationBarItem(
                      icon: controller.tabindex==3
                          ?const Icon(FontAwesome.user_circle)
                          : const Icon(FontAwesome.user_circle_o) ,
                      label: "Profile")
                ],
              ),
            ),
          )
        ],
      ),
    ),
    );
  }
}
