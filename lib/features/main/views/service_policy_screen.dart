
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';

class ServicePolicyScreen extends StatefulWidget {
  const ServicePolicyScreen({super.key});

  @override
  State<ServicePolicyScreen> createState() => _ServicePolicyScreenState();
}

class _ServicePolicyScreenState extends State<ServicePolicyScreen> {
  List<String> dropdownList = ['시행일 2023.03.31', '222222', '333333'];
  String selectedDropdown = '시행일 2023.03.31';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: Bitflow.getAppBar(
        '서비스이용약관',
        true,
        0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(4.r),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.greyText_30, width: 1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        isExpanded: true,
                        value: selectedDropdown,
                        items: dropdownList.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: CTS(fontSize: 13, color: Palette.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedDropdown = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                      header("제1조 (목적)"),
                      body("내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다내용을 출력합니다"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header(String title) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: CTS.bold(fontSize: 14, color: Palette.black),
          ),
        ],
      ),
    );
  }

  Widget body(String content) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Text(
        content,
        maxLines: 9999,
        style: CTS(fontSize: 12, color: Palette.greyText_80),
      ),
    );
  }
}
