import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/features/authentication/blocs/user_reg_req_bloc.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/affiliation_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/auth_group_widget.dart';
import 'package:sbas/features/authentication/views/user_reg_widgets/detail_auth_widget.dart';

class JobRole extends ConsumerStatefulWidget {
  const JobRole({
    required this.detailAuthTitles,
    required this.detailAuthSubTitles,
    required this.authGroupSubTitles,
    required this.authGroupSelectedImages,
    required this.authGroupDisabledImages,
    required this.authGroupTitles,
    required this.title,
    required this.affiliationType,
    super.key,
  });
  final List<String> title,
      affiliationType,
      authGroupSelectedImages,
      authGroupDisabledImages,
      authGroupTitles,
      authGroupSubTitles,
      detailAuthTitles,
      detailAuthSubTitles;

  @override
  ConsumerState<JobRole> createState() => _JobRoleState();
}

class _JobRoleState extends ConsumerState<JobRole> {
  @override
  Widget build(BuildContext context) {
    final ocpCd = ref.watch(userRegProvider).ocpCd;
    final jobCd = ref.watch(userRegProvider).jobCd;
    final attcId = ref.watch(userRegProvider).attcId;

    if (attcId != null && attcId.isNotEmpty) {
      detailAuthSelectedIndex = widget.detailAuthTitles.indexOf(attcId);
    }
    if (jobCd != null && jobCd.isNotEmpty) {
      authGroupSelectedIndex = widget.authGroupTitles.indexOf(jobCd);
    }
    if (ocpCd != null && ocpCd.isNotEmpty) {
      affiliationSelectedIndex = widget.affiliationType.indexOf(ocpCd);
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          _getTitie(0),
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
                selectedIndex: affiliationSelectedIndex,
                onChanged: (value) => setState(
                  () {
                    affiliationSelectedIndex = value ?? 0;
                    ref.read(userRegProvider).ocpCd =
                        widget.affiliationType[affiliationSelectedIndex];
                  },
                ),
              ),
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          _getTitie(1),
          SizedBox(
            height: 128 * 3 + 22,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: widget.authGroupTitles.length,
              itemBuilder: (context, index) => AuthorizationGroup(
                selectedIndex: authGroupSelectedIndex,
                index: index,
                disabledImage: widget.authGroupDisabledImages[index],
                selectedImage: widget.authGroupSelectedImages[index],
                title: widget.authGroupTitles[index],
                subTitle: widget.authGroupSubTitles[index],
                onChanged: (value) => setState(() {
                  authGroupSelectedIndex = value ?? 0;
                  ref.read(userRegProvider).jobCd =
                      widget.authGroupTitles[index];
                }),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          _getTitie(2),
          SizedBox(
            height: 128,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              itemCount: widget.detailAuthTitles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                childAspectRatio: 8.75 / 1,
              ),
              itemBuilder: (context, index) => DetailAuthorization(
                title: widget.detailAuthTitles[index],
                subTitle: widget.detailAuthSubTitles[index],
                index: index,
                selectedIndex: detailAuthSelectedIndex,
                onChanged: (value) => setState(
                  () {
                    detailAuthSelectedIndex = value ?? 0;
                    ref.read(userRegProvider).attcId =
                        widget.detailAuthTitles[detailAuthSelectedIndex];
                  },
                ),
              ),
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTitie(int index) => Row(
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
  int affiliationSelectedIndex = -1,
      authGroupSelectedIndex = -1,
      detailAuthSelectedIndex = -1;
}
