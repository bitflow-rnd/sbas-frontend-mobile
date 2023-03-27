import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/models/belong_agency_model.dart';

class AgencyDetail extends ConsumerStatefulWidget {
  const AgencyDetail({
    required this.inputBorder,
    super.key,
    required this.inputDecoration,
    required this.agencyModel,
  });
  final InputBorder inputBorder;
  final InputDecoration inputDecoration;
  final BelongAgencyModel agencyModel;

  @override
  ConsumerState<AgencyDetail> createState() => _AgencyDetailState();
}

class _AgencyDetailState extends ConsumerState<AgencyDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InputDecorator(
            decoration: widget.inputDecoration,
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
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
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
                  items: widget.agencyModel.debuggingList
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
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: widget.inputBorder,
              focusedBorder: widget.inputBorder,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.5,
                horizontal: 18,
              ),
              hintText: '소속기관명',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
