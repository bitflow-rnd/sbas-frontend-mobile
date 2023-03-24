import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/affiliation_widget.dart';

class JobRole extends ConsumerStatefulWidget {
  const JobRole({
    required this.title,
    required this.affiliationType,
    super.key,
  });
  final List<String> title, affiliationType;

  @override
  ConsumerState<JobRole> createState() => _JobRoleState();
}

class _JobRoleState extends ConsumerState<JobRole> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getTitie(0),
        SizedBox(
          height: 128,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            itemCount: widget.affiliationType.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 16,
              childAspectRatio: 3 / 1,
            ),
            itemBuilder: (context, index) => Affiliation(
              title: widget.affiliationType[index],
              index: index,
              selectedIndex: selectedIndex,
              onChanged: (value) => setState(() => selectedIndex = value ?? 0),
            ),
          ),
        ),
        getTitie(1),
        Container(
          margin: const EdgeInsets.only(
            top: 6,
            bottom: 12,
          ),
        ),
        getTitie(2),
        Container(
          margin: const EdgeInsets.only(
            top: 6,
            bottom: 12,
          ),
        ),
      ],
    );
  }

  Widget getTitie(int index) => Row(
        children: [
          Text(
            widget.title[index],
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const Text(
            '*',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      );
  int selectedIndex = 3;
}
