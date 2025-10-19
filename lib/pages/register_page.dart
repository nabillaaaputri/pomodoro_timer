import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.pinkAccent),
              const SizedBox(height: 12),
              const Text('Register', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
              const SizedBox(height: 20),
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()), obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (nameCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
                    Get.offNamed('/login');
                    Get.snackbar('Sukses', 'Registrasi berhasil, silakan login', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.pink[100]);
                  } else {
                    Get.snackbar('Error', 'Semua field harus diisi', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.pink[100]);
                  }
                },
                icon: const Icon(Icons.app_registration),
                label: const Text('Daftar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              ),
              const SizedBox(height: 12),
              TextButton(onPressed: () => Get.offNamed('/login'), child: const Text('Sudah punya akun? Login')),
            ],
          ),
        ),
      ),
    );
  }
}
