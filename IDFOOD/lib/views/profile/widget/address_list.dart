import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idfood/constants/constants.dart';

import '../../../models/hooks_models/addresses_response_model.dart';
import 'address_tile.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.addresses});

  final List<AddressResponseModel> addresses;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
        itemBuilder:(context, index){
        final address = addresses[index];
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: kGray,
                width: 0.5,
              ),
              top: BorderSide(
                color: kGray,
                width: 0.5,
              ),
            ),
          ),
          child: AddressTile(address:address),
        );
        }
    );
  }
}
