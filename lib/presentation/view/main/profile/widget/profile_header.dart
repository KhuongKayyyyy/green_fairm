import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/view/main/profile/widget/user_avatar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileHeader extends StatefulWidget {
  final bool needsRefresh;
  final User user;
  const ProfileHeader(
      {super.key, this.needsRefresh = false, required this.user});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.currentUser?.reload().then((_) {
        return FirebaseAuth.instance.currentUser;
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Hero(tag: 'avatar', child: UserAvatar()),
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 20,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 20,
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (!snapshot.hasData) {
          return const Text('User not found');
        }
        final User? updatedUser = snapshot.data;

        return Column(
          children: [
            const SizedBox(height: 100),
            const Hero(tag: 'avatar', child: UserAvatar()),
            const SizedBox(height: 20),
            Text(
              updatedUser?.displayName ?? 'No display name',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              updatedUser?.email ?? 'No email',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
