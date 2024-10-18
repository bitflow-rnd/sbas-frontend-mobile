import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final patientImageProvider = StateProvider<XFile?>((ref) => null);
final patientAttcProvider = StateProvider<String?>((ref) => null);
final patientIsUploadProvider = StateProvider<bool>((ref) => true);
