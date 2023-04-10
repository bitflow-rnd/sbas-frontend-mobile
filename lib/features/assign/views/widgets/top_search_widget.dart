import 'package:flutter/material.dart';
import 'package:sbas/constants/gaps.dart';

class TopSearch extends StatefulWidget {
  const TopSearch({super.key});

  @override
  State<TopSearch> createState() => _TopSearchState();
}

class _TopSearchState extends State<TopSearch> {
  @override
  Widget build(BuildContext context) {
    return Form(
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
                fillColor: Colors.white,
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
                      overflow: TextOverflow.ellipsis,
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
    );
  }

  late String? _currentSelectedItem = _valueList.first;

  final _valueList = [
    '최근1개월',
  ];
}
