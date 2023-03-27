import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientType<T> extends ConsumerWidget {
  const PatientType({
    required this.isSelected,
    super.key,
    required this.title,
    required this.onChanged,
  });
  final bool isSelected;
  final String title;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        24,
      ),
      onTap: () => onChanged(isSelected),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          color: isSelected ? Colors.lightBlue : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          '#$title',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 14,
            overflow: TextOverflow.visible,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
