// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sbas/common/bitflow_theme.dart';
// import 'package:sbas/features/authentication/blocs/belong_agency_bloc.dart';
// import 'package:sbas/constants/palette.dart';

// class PatientType<T> extends ConsumerWidget {
//   const PatientType({
//     required this.id,
//     super.key,
//     required this.title,
//     required this.onChanged,
//   });
//   final String title, id;
//   final ValueChanged<bool> onChanged;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isChecked = ref.watch(isCheckedProvider);

//     return GestureDetector(
//       onTap: () => onChanged(isChecked[id]!),
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isChecked[id]! ? Colors.transparent : Colors.grey.shade300,
//           ),
//           borderRadius: BorderRadius.circular(13.5.r),
//           color: isChecked[id]! ? Palette.mainColor : Colors.transparent,
//         ),
//         padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
//         child: Text(
//           title,
//           style: CTS(
//             color: isChecked[id]! ? Colors.white : Colors.grey,
//             fontSize: 12.sp,
//             // overflow: TextOverflow.visible,
//           ),
//           maxLines: 1,
//         ),
//       ),
//     );
//   }
// }
