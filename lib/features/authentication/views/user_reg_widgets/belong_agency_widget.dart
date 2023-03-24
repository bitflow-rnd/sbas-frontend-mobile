import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';

class BelongAgency extends ConsumerStatefulWidget {
  const BelongAgency({
    required this.titles,
    super.key,
  });
  final List<String> titles;

  @override
  ConsumerState<BelongAgency> createState() => _BelongAgencyState();
}

class _BelongAgencyState extends ConsumerState<BelongAgency> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getTitle(
          widget.titles[0],
          true,
        ),
        ref.watch(belongAgencyProvider).when(
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
              data: (data) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InputDecorator(
                        decoration: _getInputDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 8,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  '시/도 선택',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              isDense: true,
                              isExpanded: true,
                              value: ref
                                  .watch(belongAgencyProvider.notifier)
                                  .currentSelectedItem,
                              /*
                                TODO: exchange debuggingList
                              */
                              items: data.debuggingList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: e,
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => setState(() => ref
                                  .read(belongAgencyProvider.notifier)
                                  .currentSelectedItem = value ?? ''),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h14,
                    Expanded(
                      flex: 1,
                      child: InputDecorator(
                        decoration: _getInputDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 8,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const SizedBox(
                                width: 150,
                                child: Text(
                                  '시/도 선택',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              isDense: true,
                              isExpanded: true,
                              value: ref
                                  .watch(belongAgencyProvider.notifier)
                                  .currentSelectedItem,
                              /*
                                TODO: exchange debuggingList
                              */
                              items: data.debuggingList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: e,
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => setState(() => ref
                                  .read(belongAgencyProvider.notifier)
                                  .currentSelectedItem = value ?? ''),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        _getTitle(
          widget.titles[1],
          true,
        ),
        _getTitle(
          widget.titles[2],
          false,
        ),
        _getTitle(
          widget.titles[3],
          false,
        ),
      ],
    );
  }

  InputDecoration _getInputDecoration() => InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
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
              8,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
      );
  Widget _getTitle(String title, bool isRequired) => Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          Text(
            isRequired ? '*' : '',
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      );
}
