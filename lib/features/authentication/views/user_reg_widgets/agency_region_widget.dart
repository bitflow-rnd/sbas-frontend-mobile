import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/models/belong_agency_model.dart';

class AgencyRegion extends ConsumerStatefulWidget {
  const AgencyRegion({
    required this.agencyModel,
    required this.inputDecoration,
    super.key,
  });
  final InputDecoration inputDecoration;
  final BelongAgencyModel agencyModel;

  @override
  ConsumerState<AgencyRegion> createState() => _AgencyRegionState();
}

class _AgencyRegionState extends ConsumerState<AgencyRegion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }
}
