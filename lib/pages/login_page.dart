import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.timer, size: 80, color: Colors.pinkAccent),
              const SizedBox(height: 12),
              const Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
              const SizedBox(height: 20),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()), obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // simple flow: accept any non-empty credentials
                  if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
                    Get.offNamed('/timer');
                  } else {
                    Get.snackbar('Error', 'Email & password wajib diisi',
                        backgroundColor: Colors.pink[100], snackPosition: SnackPosition.BOTTOM);
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              ),
              const SizedBox(height: 12),
              TextButton(onPressed: () => Get.toNamed('/register'), child: const Text('Belum punya akun? Daftar')),
            ],
          ),
        ),
      ),
    );
  }
}
