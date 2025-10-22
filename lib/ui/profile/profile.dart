import 'package:capstone/style/skincare_text_style.dart';
import 'package:capstone/ui/profile/widget/expanded_button.dart';
import 'package:flutter/material.dart';

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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage(
                          "assets/blank_profile.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        style: SkincareTextStyle.headlineMedium,
                        "Nama Lengkap",
                      ),
                    ),
                    Text(
                      style: SkincareTextStyle.titleMedium,
                      "address@domain.com",
                    ),
                  ],
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
                    child: Text(style: SkincareTextStyle.titleLarge, "Profil"),
                  ),
                ],
              ),
              ExpandedButton(
                title: "Ganti Nama",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
                ontap: () {},
              ),
              ExpandedButton(
                title: "Ganti Email",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
                ontap: () {},
              ),
              ExpandedButton(
                title: "Ganti Password",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
                ontap: () {},
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xFFF9FAFB),
                    ),
                    child: Text("Keluar", style: SkincareTextStyle.titleMedium),
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
