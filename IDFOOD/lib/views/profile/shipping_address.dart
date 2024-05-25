// ignore_for_file: prefer_collection_literals

import 'dart:convert';
//import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/user_location_controller.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/addres_model.dart';
import 'package:idfood/views/auth/widget/email_text_field.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {

  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  LatLng? _selectedPosition;


  final TextEditingController _searchController=TextEditingController();
  final TextEditingController _postalCode=TextEditingController();
  final TextEditingController _instructions=TextEditingController();
  //_instructions
  //_postalColde
  List<dynamic> _placeList = [];
  final List<dynamic> _selectedPlace = [];

 // _getPlaceDetails(_placeList[index]['place_id']);
 // _selectedPlace.add(_placeList[index]);


  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String searchQuery) async {
    if(searchQuery.isNotEmpty){
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery,&key=$googleApiKey');
      final response = await http.get(url);
      print(" response code : ${response.statusCode}");
      print("url : $url");

      if (response.statusCode==200){
        setState(() {
         // _placeList = jsonDecode(response.body)['predictions'];
          _placeList = json.decode(response.body)['predictions'];
          //print("_placeList : $_placeList");
        });
      }
    }else{
      _placeList = [];
    }
  }

  void _getPlaceDetails(String placeId) async{
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId,&key=$googleApiKey');
    final response = await http.get(url);

    if (response.statusCode==200){
      final location = json.decode(response.body);
     // ['results']['predictions']
     // ['location']as Map<String, dynamic>;
      final lat = location['result']['geometry']['location']['lat'] as double;
      final lng=location['result']['geometry']['location']['lng'] as double;

      final address = location['result']['formatted_address'];

      String postalCode ="";
      final addressComponents = location['result']['address_components'];

      for(var component in  addressComponents){
          if(component['types'].contains('postal_code')){
            postalCode=component['long_name'];
            break;
          }
      }
      print("address : $address");
      print("postalCode : $postalCode");
     // _mapController!.animateCamera(CameraUpdate.newCameraPosition(
       //   CameraPosition(target: LatLng(lat, lng), zoom: 15)));
      setState(() {
        _selectedPosition=LatLng(lat, lng);
        _searchController.text= address;
        _postalCode.text = postalCode;
        moveToSelectedPosition();
        _placeList =[];
      });
    }
   // print("placeId : $placeId");
  }

  void moveToSelectedPosition(){
   if (_selectedPosition!=null&& _mapController!=null){
     _mapController!.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(
         target: _selectedPosition!,
         zoom: 16,
       ),
     ));
   }
  }

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(UserLocationController());
    // print("position : ${locationController.position}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kRed,
        title:  Text("Shipping Address",
          style: appStyle(18, kLightWhite, FontWeight.bold),
        ),
        leading: Obx(()=>Padding(padding: EdgeInsets.only(right: 0.w ),
          child: locationController.tabIndex==0? IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(
            AntDesign.closecircle,
              color: kLightWhite,
            ),
          ):IconButton(
              onPressed: () {
                locationController.setTabIndex=0;
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              icon: const  Icon(
                AntDesign.leftcircleo,
                color: kLightWhite,
              ),
          ),
        ),
        ),
        actions: [
          Obx(() => locationController.tabIndex==1?
          const SizedBox.shrink()
              :Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: IconButton(onPressed: () {
                  locationController.setTabIndex=1;
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                  );
                          },
                icon: const Icon(
                    AntDesign.rightcircleo,
                    color:kLightWhite ,
                )
                          ),
              )
          )
        ],
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
          children: [
            Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    // set the current position after
                    target:
                        _selectedPosition ?? const LatLng(34.020778, -6.830022),
                    zoom: 16,
                  ),
                  markers: _selectedPosition == null
                      ? Set.of([
                          Marker(
                            markerId: const MarkerId("Your Location"),
                            position: const LatLng(34.020778, -6.830022),
                            draggable: true,
                            onDragEnd: (LatLng position) {
                              locationController.getUserAddress(position);
                              setState(() {
                                _selectedPosition=position;
                              });

                              //print("position address : ${locationController.address}");
                            },
                          ),
                        ])
                      : Set.of([
                          Marker(
                            markerId: const MarkerId("Your Location"),
                            position: _selectedPosition!,
                            draggable: true,
                            onDragEnd: (LatLng position) {
                              locationController.getUserAddress(position);
                              setState(() {
                                _selectedPosition=position;
                              });
                            },
                          ),
                        ]),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      color: kLightWhite,
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: const InputDecoration(
                          hintText: "Search for your address ...",
                        ),
                      ),
                    ),
                    _placeList.isEmpty?
                        const SizedBox.shrink():
                        Expanded(
                            child:ListView(
                              children: List.generate(
                                  _placeList.length, (index){
                                   return Container(
                                     color: kLightWhite,
                                     child: ListTile(
                                       visualDensity: VisualDensity.compact,
                                       title: Text(
                                         _placeList[index]['description'],
                                        // style: appStyle(14, kGrayLight, FontWeight.w400),
                                       ),
                                       onTap:(){
                                         _getPlaceDetails(_placeList[index]['place_id']);
                                         _selectedPlace.add(_placeList[index]);
                                       } ,
                                     ),
                                   );
                              }),
                            )
                        ),

                  ],
                )
              ],
            ),
           BackGroundContainer(
             image: "assets/images/restaurant_bk.png",
             opacity: 0.7,
             color:kLightWhite,
             child: ListView(
               padding: EdgeInsets.symmetric(horizontal: 12.w),
               children: [
                 SizedBox(
                   height: 30.h,
                 ),
                 EmailTextField(
                   controller: _searchController,
                   hintText: "Your Address",
                   prefixIcon: const Icon(Ionicons.home),
                   keyboardType: TextInputType.number,
                 ),
                 SizedBox(
                   height: 20.h,
                 ),
                 EmailTextField(
                   //initialValue: _postalCode.text,
                   controller: _postalCode,
                   hintText: "Postal Code",
                   prefixIcon: const Icon(Ionicons.location_sharp),
                   keyboardType: TextInputType.number,
                 ),
                 SizedBox(
                   height: 20.h,
                 ),
                 EmailTextField(
                   //initialValue: _postalCode.text,
                   controller: _instructions,
                   hintText: "Your Delivery Instructions",
                   prefixIcon: const Icon(Ionicons.information_circle_outline),
                   keyboardType: TextInputType.number,
                 ),
                 SizedBox(
                   height: 20.h,
                 ),
                 Padding(
                   padding:  EdgeInsets.only(left: 8.w),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       ReusableText(
                           text: "Set address as default",
                           style: appStyle(12, kPrimary, FontWeight.w600),
                       ),
                       Obx(() => CupertinoSwitch(
                         thumbColor: kSecondary,
                           trackColor: kPrimary,
                           value: locationController.isDefault,
                           onChanged:(value){
                           locationController.setIsDefault=value;
                           } ,
                       ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 15.h,
                 ),
                 CustomButton(
                   bntHeight: 45.h,
                   text: 'S U B M I T',
                   onTap: (){
                     if(_searchController.text.isNotEmpty
                         && _postalCode.text.isNotEmpty
                         && _instructions.text.isNotEmpty){
                         AddressModel model = AddressModel(
                           addressLine1: _searchController.text,
                           postalCode: _postalCode.text,
                           addressModelDefault: locationController.isDefault,
                           deliveryInstructions: _instructions.text,
                           latitude: _selectedPosition!.latitude,
                           longitude: _selectedPosition!.longitude);

                       String dada = addressModelToJson(model);
                     }

                   },
                 )
               ],
             ) ,
           ),
          ],
        ),
      ),
    );
  }
}
