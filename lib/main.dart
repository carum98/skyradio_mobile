import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/deep_links.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/theme.dart';
import 'package:skyradio_mobile/core/toast.dart';

import 'core/bottom_sheet.dart';
import 'core/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DI(
      child: SkBottomSheet(
        child: SkDialog(
          child: SkToast(child: const MyApp()),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = DI.of(context).state;

    // Initialize deep links
    Future.delayed(
      const Duration(seconds: 2),
      () => DeepLinks(context: context),
    );

    return ListenableBuilder(
      listenable: state,
      builder: (_, __) => MaterialApp(
        title: 'SkyRadio',
        debugShowCheckedModeBanner: false,
        theme: SkTheme.light,
        darkTheme: SkTheme.dark,
        themeMode: state.themeMode,
        onGenerateRoute: RouterGenerator.generate,
        navigatorKey: state.navigatorKey,
      ),
    );
  }
}
