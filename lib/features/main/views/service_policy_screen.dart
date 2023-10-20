import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/main/blocs/terms_presenter.dart';

import 'body_widget.dart';

class ServicePolicyScreen extends ConsumerStatefulWidget {
  const ServicePolicyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServicePolicyScreenState();

}

class _ServicePolicyScreenState extends ConsumerState<ServicePolicyScreen> {

  List<String> dropdownList = [];
  List<String> versionList = [];
  int selectedDropdown = 0;
  String detail = '';

  @override
  void initState() {
    super.initState();

    _loadData(selectedDropdown);
  }

  Future<void> _loadData(int selectedIndex) async {
    final termsList = await ref.read(termsPresenter.notifier).getTermsList('02');

    dropdownList.clear();
    versionList.clear();
    for (var terms in termsList) {
      final effectiveDt = terms.id.effectiveDt;
      final formattedDt =
          '시행일 ${effectiveDt.substring(0, 4)}.${effectiveDt.substring(4, 6)}.${effectiveDt.substring(6)}';
      dropdownList.add(formattedDt);
      versionList.add(terms.id.termsVersion);
    }

    final termsDetail = await ref.read(termsPresenter.notifier).getTermsDetail('02', versionList[selectedIndex]);

    setState(() {
      detail = termsDetail.detail;
    });
  }

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
                            borderSide: BorderSide(
                              color: Palette.greyText_30,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.greyText_30,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.greyText_30,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        isExpanded: true,
                        value: selectedDropdown,
                        items: dropdownList.asMap().entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(
                              entry.value,
                              style: CTS(
                                fontSize: 13,
                                color: Palette.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (int? value) async {
                          if(value != null) {
                            await _loadData(value);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: body(detail ?? ''),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
