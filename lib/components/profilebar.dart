import 'package:flutter/material.dart';
import 'package:tukdak/config/services/userprofile.dart';
import 'package:tukdak/screens/profilescreen.dart';

class Profilebar extends StatelessWidget {
  const Profilebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserprofile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error : ${snapshot.error} ");
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text("User information not available");
        } else {
          final userData = snapshot.data!;
          final name = userData["username"];
          final email = userData["email"];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name  ??  "Name not available",
                      style: const TextStyle(
                        color: Color(0xFF44576D),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email ?? "Email not available",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
