import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/gaps.dart';

class AssignBedScreen extends ConsumerStatefulWidget {
  const AssignBedScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  ConsumerState<AssignBedScreen> createState() => _AssignBedScreenState();

  final bool automaticallyImplyLeading;
}

class _AssignBedScreenState extends ConsumerState<AssignBedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bitflow.getAppBar(
        '병상 배정 현황',
        widget.automaticallyImplyLeading,
        0.5,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            child: Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search_rounded,
                          ),
                        ),
                        fillColor: Colors.grey[250],
                        filled: true,
                        hintText: '이름, 휴대폰번호 또는 주민등록번호 앞 6자리',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  Gaps.h6,
                  Expanded(
                    flex: 1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            value: _currentSelectedItem,
                            isDense: true,
                            isExpanded: true,
                            items: _valueList
                                .map(
                                  (value) => DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _currentSelectedItem = value),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  late String? _currentSelectedItem = _valueList.first;

  final _valueList = [
    '최근1개월',
  ];
}
