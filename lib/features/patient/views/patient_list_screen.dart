import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/bitflow_theme.dart';
import 'package:sbas/constants/palette.dart';
import 'package:sbas/features/lookup/blocs/patient_lookup_bloc.dart';
import 'package:sbas/features/patient/views/widgets/patient_list_widget.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({Key? key}): super(key: key);

  static String routeName = 'lookup';
  static String routeUrl = '/lookup';

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
            await ref.watch(patientLookupProvider.notifier).refresh();
          },
          child: patientListWidget(context, ref),
        ),
      );

}
