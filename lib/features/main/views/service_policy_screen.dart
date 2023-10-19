import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/main/blocs/terms_presenter.dart';

import 'body_widget.dart';

class ServicePolicyScreen extends ConsumerWidget {
  const ServicePolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(termsPresenter.notifier).getTermsList('02');

    final dropdownList = ref.read(termsPresenter.notifier).getDropdownList();
    var selectedDropdown = 0;

    final termsDetail = ref.watch(termsDetailProvider);
    final detail = termsDetail?.detail;

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
                        onChanged: (int? value) {
                          if(value != null) {
                            final item = ref.read(termsListProvider)?[value];

                            if(item != null) {
                              ref.read(termsPresenter.notifier).getTermsDetail(
                                  item.id.termsType, item.id.termsVersion);
                            }
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
