import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_text_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: size.width,
          constraints: const BoxConstraints(maxWidth: 1200), // Optional: limits max width for large screens
          padding: const EdgeInsets.symmetric(horizontal: 16), // Responsive padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
            children: [
              // Logo and Heading
              Icon(
                Icons.school_rounded,
                size: 80,
                color: Colors.indigo.shade800,
              ),
              const SizedBox(height: 24),
              Text(
                'VIDHYATRA',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Admin Portal',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo.shade800,
                ),
              ),
              const SizedBox(height: 32),
              // Description
              Container(
                width: size.width * 0.7,
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  'Manage your college app efficiently with our comprehensive admin dashboard. '
                      'Access student data, course information, and notifications in one place.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  textStyle: AppTextStyles.button.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('LOGIN TO DASHBOARD'),
              ),
              // Footer (optional, placed outside main centered content if centering is priority)
            ],
          ),
        ),
      ),
      // Footer placed here to avoid interfering with centering
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 24),
        child: Text(
          '© ${DateTime.now().year} Vidhyatra. All rights reserved.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.indigo.shade800, // Adjusted for better visibility
          ),
        ),
      ),
    );
  }
}