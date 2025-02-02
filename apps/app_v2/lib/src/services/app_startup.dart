import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_sizes.dart';

part 'app_startup.g.dart';

// // // https://codewithandrea.com/articles/robust-app-initialization-riverpod/
// @Riverpod(keepAlive: true)
// Future<void> appStartup(AppStartupRef ref) async {
//   // ref.onDispose(() {
//   //   // ensure dependent providers are disposed as well
//   //   ref.invalidate(onboardingRepositoryProvider);
//   // });
//   // // await for all initialization code to be complete before returning
//   // await ref.watch(onboardingRepositoryProvider.future);
// }

@Riverpod(keepAlive: true)
class AppStartup extends _$AppStartup {
  @override
  Future<void> build() async {}
}

/// Widget class to manage asynchronous app initialization
class AppStartupWidget extends HookConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);

    return appStartupState.when(
      data: (_) => onLoaded(context),
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.headlineSmall),
            gapH16,
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
