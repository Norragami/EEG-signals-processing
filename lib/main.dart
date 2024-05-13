import 'dart:io';
import 'package:eeg_processing/Pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(1400, 800),
      size: Size(1400, 800),
      center: true,
      backgroundColor: Colors.transparent,
      // skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'Приложение для обработки ЭЭГ сигнала',
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp( const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      supportedLocales: [
        Locale('ru'),
      ],
    );
  }
}

