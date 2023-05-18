import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ClassLinkResources());
}

class ClassLinkResources extends StatelessWidget {
  const ClassLinkResources({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
            fontFamily: GoogleFonts.poppins().fontFamily),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            fontFamily: GoogleFonts.poppins().fontFamily),
        title: "ClassLink Resources",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
}
