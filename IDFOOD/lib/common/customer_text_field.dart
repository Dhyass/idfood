
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:idfood/constants/constants.dart';

class CustomerTextWidget extends StatefulWidget {
  const CustomerTextWidget({
    Key? key,
    this.keyboardType,
    this.controller,
    this.onEditingComplete,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.maxLines,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final int? maxLines;

  @override
  _CustomerTextWidgetState createState() => _CustomerTextWidgetState();
}

class _CustomerTextWidgetState extends State<CustomerTextWidget> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.h),
      padding: EdgeInsets.only(left: 6.h),
      height: 60.h,
      decoration: BoxDecoration(
        border: Border.all(color: kGray, width: 0.4.w),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: TextFormField(
        maxLines: widget.maxLines??1,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onEditingComplete: widget.onEditingComplete,
        obscureText: widget.obscureText ?? false,
        cursorColor: Colors.orange,
        cursorHeight: 30.h,
        cursorWidth: 2.w,
        validator: widget.validator,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _isFocused ? '' : widget.hintText,
          hintStyle: TextStyle(fontSize: 16.sp, color: kDark, fontWeight: FontWeight.normal),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }
}
