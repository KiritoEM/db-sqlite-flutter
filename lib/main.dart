// ignore_for_file: unreachable_switch_default

import 'package:counter_mvc/utils/colors.dart';
import 'package:counter_mvc/viewmodels/create_task_viewmodel.dart';
import 'package:counter_mvc/viewmodels/task_list_viewmodel.dart';
import 'package:counter_mvc/viewmodels/user_viewmodel.dart';
import 'package:counter_mvc/views/create_task_view/create_task_view.dart';
import 'package:counter_mvc/views/login_view/login_view.dart';
import 'package:counter_mvc/views/splash_screen_view.dart';
import 'package:counter_mvc/views/task_list_view/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskListViewmodel()),
        ChangeNotifierProvider(create: (context) => UserViewmodel()),
        ChangeNotifierProvider(create: (context) => CreateTaskViewmodel()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (_) => SplashScreenView(),
          '/login': (_) => LoginView(),
          '/list': (_) => TaskListView(),
          '/create': (_) => CreateTaskView(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme)
              .copyWith(
                headlineLarge: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cal-sans",
                ),
                headlineMedium: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cal-sans",
                  height: 1.2,
                ),
                displaySmall: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cal-sans",
                  fontSize: 32,
                ),
                titleLarge: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cal-sans",
                ),
                titleMedium: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cal-sans",
                ),
              ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontWeight: FontWeight.w500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              elevation: 0,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
