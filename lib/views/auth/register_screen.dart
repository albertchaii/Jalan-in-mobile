import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Palet warna sesuai desain Jalan.in
  final Color primaryRed = const Color(0xFF8A0B14);
  final Color bgPink = const Color(0xFFFEF9F9);
  final Color fieldBgColor = const Color(0xFFF7EBEA);
  final Color textDark = const Color(0xFF333333);
  final Color textGrey = const Color(0xFF666666);

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryRed),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        // Menggunakan ListView agar halaman bisa di-scroll ke bawah
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            // 1. Judul (Heading)
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: textDark,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
                children: [
                  const TextSpan(text: 'Jadilah Bagian dari\nDenyut Kotamu\nLewat '),
                  TextSpan(
                    text: 'jalan.in',
                    style: TextStyle(color: primaryRed),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Subjudul
            Text(
              'Bantu komunitas Anda ciptakan jalan\nyang lebih baik dengan melaporkan\nkondisi infrastruktur di sekitar Anda.',
              style: TextStyle(
                fontSize: 15,
                color: textGrey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // 3. Input: Nama Lengkap
            _buildInputLabel('NAMA LENGKAP'),
            _buildTextField(
              hint: 'nama lengkap',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),

            // 4. Input: Email
            _buildInputLabel('EMAIL'),
            _buildTextField(
              hint: 'guardian@city.in',
              icon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // 5. Input: Kata Sandi
            _buildInputLabel('KATA SANDI'),
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: TextStyle(color: Colors.grey.shade500, letterSpacing: 4.0),
                prefixIcon: Icon(Icons.lock_outline, color: textDark.withOpacity(0.7)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: textDark.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
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

            // 6. Tombol Buat Akun
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi pendaftaran
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
                      'Buat Akun',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.local_police_outlined, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 7. Footer: Pindah ke Login
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: RichText(
                  text: TextSpan(
                    text: 'Sudah Punya Akun? ',
                    style: TextStyle(color: textGrey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Masuk',
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
            const SizedBox(height: 30), // Ruang tambahan di bawah agar tidak terlalu mepet
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textDark.withOpacity(0.8),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Icon(icon, color: textDark.withOpacity(0.7)),
        filled: true,
        fillColor: fieldBgColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}