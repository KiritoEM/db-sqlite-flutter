// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_mvc/viewmodels/user_viewmodel.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final userVm = context.read<UserViewmodel>();

    await userVm.getUsername();

    if (!mounted) return;

    if (userVm.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/list');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.blue)),
    );
  }
}
