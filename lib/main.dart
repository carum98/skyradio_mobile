import 'package:flutter/material.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';
import 'package:skyradio_mobile/core/dialog.dart';
import 'package:skyradio_mobile/core/theme.dart';

import 'core/bottom_sheet.dart';
import 'core/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DI(
      child: SkBottomSheet(
        child: SkDialog(
          child: const MyApp(),
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
