import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/constants/gaps.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_detail_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_proof_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/agency_region_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/patient_type_widget.dart';

class BelongAgency extends ConsumerStatefulWidget {
  BelongAgency({
    required this.titles,
    super.key,
  });
  final Map<String, bool> mapSelectedTypes = {};
  final List<String> titles;

  @override
  ConsumerState<BelongAgency> createState() => _BelongAgencyState();
}

class _BelongAgencyState extends ConsumerState<BelongAgency> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(belongAgencyProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Colors.lightBlueAccent,
              ),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          data: (data) {
            for (var e in data) {
              String id = e.id?.cdId ?? '';

              if (id.isNotEmpty) {
                widget.mapSelectedTypes[id] = false;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitle(
                  widget.titles[0],
                  true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: AgencyRegion(
                    inputDecoration: _inputDecoration,
                  ),
                ),
                Gaps.v16,
                _getTitle(
                  widget.titles[1],
                  true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: AgencyDetail(
                    inputBorder: _inputBorder,
                    inputDecoration: _inputDecoration,
                  ),
                ),
                Gaps.v16,
                _getTitle(
                  widget.titles[2],
                  false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: AgencyProof(),
                ),
                Gaps.v16,
                _getTitle(
                  widget.titles[3],
                  false,
                ),
                SizedBox(
                  height: 128,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2.15 / 1,
                    ),
                    itemBuilder: (context, index) {
                      String id = data[index].id?.cdId ?? '';

                      PatientType(
                        title: data[index].cdNm ?? '',
                        onChanged: (value) => setState(
                            () => widget.mapSelectedTypes[id] = !value),
                        isSelected: widget.mapSelectedTypes[id] ?? false,
                      );
                      return null;
                    },
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            );
          },
        );
  }

  InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey.shade300,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      );

  InputDecoration get _inputDecoration => InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
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
