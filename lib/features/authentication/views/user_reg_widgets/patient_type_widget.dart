import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';

class PatientType<T> extends ConsumerWidget {
  const PatientType({
    required this.id,
    super.key,
    required this.title,
    required this.onChanged,
  });
  final String title, id;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(isCheckedProvider);

    return InkWell(
      borderRadius: BorderRadius.circular(
        24,
      ),
      onTap: () => onChanged(isChecked[id]!),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isChecked[id]! ? Colors.transparent : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          color: isChecked[id]! ? Colors.lightBlue : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          '#$title',
          style: TextStyle(
            color: isChecked[id]! ? Colors.white : Colors.grey,
            fontSize: 14,
            overflow: TextOverflow.visible,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
