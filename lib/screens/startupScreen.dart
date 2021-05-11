import 'package:flutter/material.dart';

class StartupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text(
          "Logo",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
