import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbas/common/providers/loading_notifier.dart';
import 'package:sbas/common/widgets/progress_indicator_widget.dart';

class LoadingSpinner extends ConsumerWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    return isLoading
      ? const SBASProgressIndicator()
      : const SizedBox.shrink();
  }
}