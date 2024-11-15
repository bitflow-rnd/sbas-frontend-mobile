import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/patient/providers/patient_provider.dart';
import 'package:sbas/features/patient/views/widgets/patient_list_widget.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({Key? key,
    required this.automaticallyImplyLeading
  }): super(key: key);

  final bool automaticallyImplyLeading;

  static String routeName = 'lookup';
  static String routeUrl = '/lookup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMyGroup = ref.watch(isMyGroupProvider);

    void changGroup() {
      ref.read(isMyGroupProvider.notifier).state = !isMyGroup;
    }
    return Scaffold(
      backgroundColor: Palette.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "환자 목록",
          style: CTS.medium(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.watch(patientListProvider.notifier).init();
          // await ref.watch(patientLookupProvider.notifier).refresh();
        },
        child: patientListWidget(context, ref, isMyGroup, changGroup),
      ),
    );
  }
}

final isMyGroupProvider = StateProvider<bool>((ref) => true);