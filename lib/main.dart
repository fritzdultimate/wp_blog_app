import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/providers/brightness_provider.dart';
import 'package:wp_blog_app/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(BrightnessProviderAdapter());
  Hive.init(document.path);
  final stateOfApp = await Hive.openBox(appState);
  if (stateOfApp.get('state') == null) {
    stateOfApp.put("state", BrightnessProvider());
  }
  runApp(
    WatchBoxBuilder(
      box: Hive.box(appState),
      builder: (_, box) => App(),
    ),
  );
}
