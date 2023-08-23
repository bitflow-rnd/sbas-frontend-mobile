import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/assign/presenters/assign_bed_presenter.dart';

class TopSearch extends ConsumerStatefulWidget {
  const TopSearch({super.key});
  final List<String> dropdownList = const ['최근1개월', '최근3개월', '최근1년'];

  @override
  ConsumerState<TopSearch> createState() => _TopSearchState();
}

class _TopSearchState extends ConsumerState<TopSearch> {
  String selectedDropdown = '최근1개월';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 5,
            child: TextFormField(
              controller: ref.read(assignBedProvider.notifier).searchTextController,
              onEditingComplete: () {
                //검색 로직.
                FocusScope.of(context).unfocus();
                ref.read(assignBedProvider.notifier).search();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,

                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                ),
                fillColor: Colors.white,
                // filled: true,
                hintText: '이름, 휴대폰번호 또는 생년월일 6자리',
                hintStyle: CTS(
                  color: Colors.grey,
                  fontSize: 11,
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
            ),
          ),
          Gaps.h6,
          Expanded(
            flex: 2,
            child: DropdownButtonFormField(
              borderRadius: BorderRadius.circular(4.r),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.greyText_20, width: 1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.greyText_20, width: 1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.greyText_20, width: 1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              value: selectedDropdown,
              items: widget.dropdownList.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: CTS(fontSize: 11, color: Palette.greyText_60),
                  ),
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectedDropdown = value;
                });
              },
            ),
            // child: DropdownButtonHideUnderline(
            //   child: DropdownButton(
            //     style: const TextStyle(
            //       fontSize: 12,
            //       color: Colors.grey,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //     value: _currentSelectedItem,
            //     isDense: true,
            //     isExpanded: true,
            //     items: _valueList
            //         .map(
            //           (value) => DropdownMenuItem(
            //             alignment: Alignment.center,
            //             value: value,
            //             child: Text(value),
            //           ),
            //         )
            //         .toList(),
            //     onChanged: (value) =>
            //         setState(() => _currentSelectedItem = value),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
