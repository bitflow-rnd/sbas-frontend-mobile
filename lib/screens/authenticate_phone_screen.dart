import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/util.dart';

class AuthPhone extends StatefulWidget {
  const AuthPhone({super.key});

  @override
  State<AuthPhone> createState() => _AuthPhoneState();
}

class _AuthPhoneState extends State<AuthPhone> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: Bitflow.getAppBar(
          '휴대폰 본인인증',
          false,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      child: Text(
                        '인증번호를 입력해주세요.',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Text(
                        '인증번호',
                        style: TextStyle(
                          color: Palette.textColor1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (value) => authNumber = value,
                            maxLength: 6,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[250],
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: ElevatedButton(
                            onPressed: authNumber.length == 6 ? null : () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(
                                16,
                              ),
                            ),
                            child: const Text(
                              '인증번호 발송',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Text(
                        '유효시간 ${format(remainingTime)}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                ),
              ),
              ElevatedButton(
                onPressed: authNumber.length == 6
                    ? () {
                        Navigator.pop(context, 'lemon');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.zero,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  @override
  void initState() {
    authNumber = '';
    remainingTime = kDebugMode ? 15 : validTime;
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      onTick,
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void onTick(Timer timer) => setState(() {
        if (remainingTime == 0) {
          Navigator.pop(context);
        } else {
          remainingTime--;
        }
      });

  late Timer timer;
  late String authNumber;
  late int remainingTime;

  static const validTime = 180;
}
