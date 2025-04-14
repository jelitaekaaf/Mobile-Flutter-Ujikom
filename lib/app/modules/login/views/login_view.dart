import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: HexColor('#feeee8'), // Warna latar soft
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Judul Inventera dengan Emoji & Font Menarik
              Text(
                '📦 Inventera',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color:  Colors.purple.shade400,
                ),
              ),
              const SizedBox(height: 40),

              // Form Email
              _buildInputField(
                controller.emailController,
                Icons.email,
                'Email',
                false,
              ),

              const SizedBox(height: 15),

              // Form Password
              _buildInputField(
                controller.passwordController,
                Icons.lock,
                'Password',
                true,
              ),

              const SizedBox(height: 20),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => controller.loginNow(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.purple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Input Field (Email & Password)
  Widget _buildInputField(
      TextEditingController controller, IconData icon, String hint, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color:  Colors.purple.shade400), // Ikon dalam form
        hintText: hint,
        filled: true,
        fillColor: Colors.white, // Background form putih
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Sudut membulat
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(focused: true),
      ),
    );
  }

  // Border untuk form input
  OutlineInputBorder _buildBorder({bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: focused ?  Colors.purple.shade400 : Colors.transparent,
        width: 2,
      ),
    );
  }
}
 