import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/app.dart';
import 'package:flutter_riverpod_base/src/utils/functions.dart';
import 'package:hive_flutter/adapters.dart';
void main() async {
  
  await Hive.initFlutter();
  
  await Hive.openBox('USER');
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: const App());
  }
}
