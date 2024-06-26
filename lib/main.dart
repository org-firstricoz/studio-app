import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:upgrader/upgrader.dart';
// import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // await Upgrader.clearSavedSettings();
  await Hive.openBox('USER');

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: App());
  }
}

Upgrader upgrader = Upgrader(
  debugLogging: true,
  messages: UpgraderMessages(
    code: "en",
  ),

  minAppVersion: "2.5.0",
  countryCode: "IN",
  // durationUntilAlertAgain: Duration(days: 1),
);
