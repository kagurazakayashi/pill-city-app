import 'package:flutter/material.dart';

class WelcomeViewController extends StatelessWidget {
  const WelcomeViewController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎页'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('登录'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}
