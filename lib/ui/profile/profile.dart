import 'package:capstone/provider/user_provider.dart';
import 'package:capstone/provider/wishlist_provider.dart';
import 'package:capstone/style/skincare_text_style.dart';
import 'package:capstone/ui/profile/widget/expanded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bottom_navbar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Teks Full Name dan Address di kiri
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: SkincareTextStyle.headlineSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "address@domain.com",
                              style: SkincareTextStyle.titleSmall,
                            ),
                          ],
                        ),
                      ),

                      // Jarak antara teks dan tombol
                      const SizedBox(width: 8),

                      // Tombol love dengan background biru dan lingkaran
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff007BFF), // biru
                          shape: BoxShape
                              .circle, // bisa diganti BoxShape.rectangle untuk kotak
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/wishlist');
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      right: 16,
                      left: 16,
                    ),
                    child: Text(
                      style: SkincareTextStyle.titleMedium,
                      "Profile",
                    ),
                  ),
                ],
              ),
              ExpandedButton(
                title: "Change Name",
                description: "Update your profile name.",
                ontap: () {
                  Navigator.pushNamed(context, '/ganti_nama');
                },
              ),
              ExpandedButton(
                title: "Change Email",
                description: "Update the email address linked to your account.",
                ontap: () {
                  Navigator.pushNamed(context, '/ganti_email');
                },
              ),
              ExpandedButton(
                title: "Change Password",
                description:
                    "Update your password to keep your account secure.",
                ontap: () {
                  Navigator.pushNamed(context, '/ganti_password');
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      // Akses provider
                      final userProvider = Provider.of<UserProvider>(
                        context,
                        listen: false,
                      );
                      final wishlistProvider = Provider.of<WishlistProvider>(
                        context,
                        listen: false,
                      );

                      // Hapus semua data user dan wishlist
                      userProvider.logout();
                      wishlistProvider.clearWishlist();

                      // Arahkan ke halaman login dan hapus semua route sebelumnya
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },

                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xff007BFF)),
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xFFF9FAFB),
                    ),
                    child: Text(
                      "Logout",
                      style: SkincareTextStyle.titleMedium.copyWith(
                        color: const Color(0xff007BFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cek_kombinasi');
          }
          if (index == 2) return;
        },
      ),
    );
  }
}
