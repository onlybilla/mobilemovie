import 'package:flutter/material.dart';

class UserAccountPage extends StatelessWidget {
  final String userName = 'Nabilla'; // Ganti dengan nama pengguna
  final String userEmail = 'nabilla@example.com'; // Ganti dengan email pengguna
  final String userProfilePic =
      'https://www.w3schools.com/w3images/avatar2.png'; // Ganti dengan URL avatar pengguna Anda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'User Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        // Menggunakan Center untuk memastikan seluruh konten di tengah
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Agar konten berada di tengah vertikal
            crossAxisAlignment: CrossAxisAlignment
                .center, // Agar konten berada di tengah horizontal
            children: [
              // Avatar Section
              CircleAvatar(
                radius: 60, // Ukuran avatar
                backgroundImage: NetworkImage(
                    userProfilePic), // Ganti dengan URL gambar pengguna
              ),
              SizedBox(height: 16),
              // User Name Section
              Text(
                userName, // Pastikan userName tidak null
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              // User Email Section
              Text(
                userEmail, // Pastikan userEmail tidak null
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32),
              // Option to Edit Profile or Sign Out (Simple Buttons)
              ElevatedButton(
                onPressed: () {
                  // Handle Edit Profile action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle Sign Out action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
