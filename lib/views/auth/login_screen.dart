import 'package:jalan_in/views/main/main_layout.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart'; // Import layar register di sini

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Mendefinisikan warna sesuai mockup agar konsisten
  final Color primaryRed = const Color(0xFF8A0B14); // Merah gelap
  final Color bgPink = const Color(0xFFFEF9F9); // Latar belakang utama
  final Color fieldBgColor = const Color(0xFFF7EBEA); // Latar belakang textfield
  final Color textDark = const Color(0xFF333333);
  final Color textGrey = const Color(0xFF666666);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPink,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo jalan.in
                Center(
                  child: Text(
                    'jalan.in',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: primaryRed,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // 2. Judul & Subjudul
                Text(
                  'Selamat datang kembali',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Masuk ke akun Anda untuk lanjut melaporkan\ndan memperbaiki infrastruktur jalan kita.',
                  style: TextStyle(
                    fontSize: 15,
                    color: textGrey,
                    height: 1.4, 
                  ),
                ),
                const SizedBox(height: 40),

                // 3. Form Input Email
                Text(
                  'EMAIL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: textDark.withOpacity(0.8),
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'nama@integrity.org',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.alternate_email, color: textDark.withOpacity(0.7)),
                    filled: true,
                    fillColor: fieldBgColor,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Form Input Kata Sandi & Lupa Kata Sandi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KATA SANDI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: textDark.withOpacity(0.8),
                        letterSpacing: 1.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Tambahkan navigasi ke Lupa Kata Sandi nantinya
                      },
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryRed,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  obscureText: true, 
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    hintStyle: TextStyle(color: Colors.grey.shade500, letterSpacing: 4.0),
                    prefixIcon: Icon(Icons.lock_outline, color: textDark.withOpacity(0.7)),
                    filled: true,
                    fillColor: fieldBgColor,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 5. Tombol Masuk
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainLayout()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 6. Teks Belum Punya Akun -> Daftar
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // NAVIGASI KE HALAMAN REGISTER DITAMBAHKAN DI SINI
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Belum punya akun? ',
                        style: TextStyle(color: textGrey, fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Daftar',
                            style: TextStyle(
                              color: primaryRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
