import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OriginInfomation extends ConsumerStatefulWidget {
  OriginInfomation({
    required this.formKey,
    super.key,
  });
  final GlobalKey<FormState> formKey;
  final _homeTitles = [
    '보호자1 연락처',
    '보호자2 연락처',
    '배정 요청 메세지',
  ];
  final _hospitalTitles = [
    '진료과',
    '담당의',
    '전화번호',
    '원내 배정 여부',
    '요청 메세지',
  ];
  final _subTitles = [
    '환자 출발지',
    '배정 요청 지역',
  ];
  final _classification = [
    '자택',
    '병원',
    '기타',
  ];
  @override
  ConsumerState<OriginInfomation> createState() => _OriginInfomationState();
}

class _OriginInfomationState extends ConsumerState<OriginInfomation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < widget._subTitles.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${i + 1}.${widget._subTitles[i]}',
                  style: const TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 18,
                  ),
                ),
                if (i == 0)
                  Row(
                    children: [
                      for (int i = 0; i < widget._classification.length; i++)
                        _initClassification(
                          _selectedOriginIndex,
                          i,
                          () => setState(() {
                            _selectedOriginIndex = i;
                          }),
                        ),
                    ],
                  ),
                if (i == 0)
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: _initTextField(),
                      ),
                      Expanded(
                        flex: 3,
                        child: _initSearchBtn(),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _initTextField() => TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 22,
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9|.]'),
          ),
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        validator: (value) {
          return null;
        },
        onSaved: (newValue) {
          if (newValue != null && newValue.isNotEmpty) {}
        },
        autovalidateMode: AutovalidateMode.always,
      );
  Widget _initSearchBtn() => TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF538EF5)),
          minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              18 * 3 - 2,
            ),
          ),
        ),
        child: const Text(
          '우편번호 검색',
          style: TextStyle(
            color: Color(0xFFECEDEF),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
  Widget _initClassification(int selectedIndex, int index, Function() func) =>
      GestureDetector(
        onTap: func,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          margin: const EdgeInsets.only(
            top: 6,
            bottom: 8,
            right: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey,
                style: selectedIndex == index
                    ? BorderStyle.none
                    : BorderStyle.solid),
            color:
                selectedIndex == index ? Colors.lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(
              18,
            ),
          ),
          child: Text(
            widget._classification[index],
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
          ),
        ),
      );
  int _selectedOriginIndex = -1;
}
