import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idfood/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/addresses_response_model.dart';

import '../models/hooks_models/api_error.dart';
import '../models/hooks_models/success_model.dart';
import '../views/entrypoint.dart';
class UserLocationController extends GetxController{

  final RxBool _isDefault = false.obs;

  bool get isDefault =>_isDefault.value;

  set setIsDefault(bool value){
    _isDefault.value=value;
  }

  final RxInt _tabIndex = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int value){
    _tabIndex.value = value;
  }
  LatLng position = const LatLng(0, 0);

  void setPosition(LatLng value){
    value = position;
    update();
  }

  RxString _address =''.obs;

  String get address => _address.value;

  set setAddress(String value){
    _address.value=value;
  }

  RxString _postalCode =''.obs;

  String get postalCode=> _postalCode.value;

  set setPostalCode(String value){
    _postalCode.value=value;
  }

  void getUserAddress(LatLng position) async{
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$googleApiKey');
    final response = await http.get(url);
      //print(" response code : ${response.statusCode}");
      //print("url : $url");
    if (response.statusCode==200){
      final responseBody = jsonDecode(response.body);
      //print("responseBody : $responseBody ");
      final address = responseBody['result'][0]['formatted_address'];
      setAddress = address;

      final addressComponents = responseBody['result'][0]['address_components'];
      for(var component in addressComponents){
        if (component['types'].contains('postal_code')){
          setPostalCode= component['long-name'];
        }
      }
    }
  }

  void addAddress(String data) async{
    final box = GetStorage();

    String accessToken = box.read("token");

    Uri url = Uri.parse("$appBaseUrl/api/address");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    //print("url : $url");
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
     // print("response statusCode : ${response.statusCode}");

      if (response.statusCode == 201) {
        var successData = successModelFromJson(response.body);
        //setLoading = false;
        Get.back();
        Get.snackbar(
          "Successful adding ",
          successData.message,
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
        Get.offAll(()=>const MainScreen());
      } else {
        var errorData = apiErrorFromJson(response.body);
        Get.snackbar(
          "Failed to add",
          errorData.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(MaterialIcons.error_outline),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        //"Failed to connect to server",
        e.toString(),
        colorText: kLightWhite,
        backgroundColor: kRed,
        icon: const Icon(MaterialIcons.error_outline),
      );
    }
  }
}