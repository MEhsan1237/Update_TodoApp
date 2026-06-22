
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo_app/provider/provider_class.dart';
import 'main_screen/home_navigation.dart';
import 'notes_model/notes_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
  ));

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>("notes");
  await Hive.openBox('settings');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stunning Todo',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF0F0F12),
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
      home: const HomeNavigation(),
    );
  }
}
