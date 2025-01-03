import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/network/server.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);
    loginWithGoogleToServer();
    return userCredential.user!;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (kDebugMode) {
        print("Successfully signed in with email and password");
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error signing in with email and password: $e");
      }
      rethrow;
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String name, String password) async {
    try {
      // Attempt to create the user with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Update the user's profile with the provided name
      await userCredential.user!.updateProfile(
          displayName: name,
          photoURL:
              "https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg");
      await userCredential.user!.reload();
      if (kDebugMode) {
        print("Successfully created user with email and password");
      }

      // Return the UserCredential object
      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        print("Error creating user with email and password: $e");
      }
      // Rethrow the error to be handled at the call site
      rethrow;
    }
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> saveNewUserToServer(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(API.register));
      request.headers.set('content-type', 'application/json');
      request.write(
          '{"username": "$name", "email": "$email", "password": "$password"}');
      var response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('Failed to save user to server');
      } else {
        if (kDebugMode) {
          print('User saved to server successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user to server: $e');
      }
      rethrow;
    }
  }

  Future<void> loginToServer(
      {required String email, required String password}) async {
    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(API.login));
      request.headers.set('content-type', 'application/json');
      request.write('{ "email": "$email", "password": "$password"}');
      var response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('Failed to save user to server');
      } else {
        if (kDebugMode) {
          print('User saved to server successfully');
          final responseBody = await response.transform(utf8.decoder).join();
          final responseData = jsonDecode(responseBody);
          if (responseData['statusCode'] == 200) {
            const storage = FlutterSecureStorage();
            await storage.write(
                key: AppSetting.userUid,
                value: responseData['metadata']['_id']);
            if (kDebugMode) {
              print('User ID saved to secure storage successfully');
              print(await const FlutterSecureStorage()
                  .read(key: AppSetting.userUid));
            }
          } else {
            throw Exception('Failed to save user ID to secure storage');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user to server: $e');
      }
      rethrow;
    }
  }

  Future<void> loginWithGoogleToServer() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var client = HttpClient();
        var request = await client.postUrl(Uri.parse(API.loginWithGoogle));
        request.headers.set('content-type', 'application/json');

        // URL encode the username to handle special characters
        String encodedUsername = Uri.encodeComponent(user.displayName ?? "");

        request.write(jsonEncode({
          "email": user.email,
          "username": encodedUsername, // Use the encoded username
          "avatar": user.photoURL,
        }));

        var response = await request.close();
        if (response.statusCode != 200) {
          throw Exception('Failed to save user to server');
        } else {
          if (kDebugMode) {
            print('User saved to server successfully');
            final responseBody = await response.transform(utf8.decoder).join();
            final responseData = jsonDecode(responseBody);
            if (responseData['statusCode'] == 200) {
              const storage = FlutterSecureStorage();
              await storage.write(
                  key: AppSetting.userUid,
                  value: responseData['metadata']['_id']);
              if (kDebugMode) {
                print('User ID saved to secure storage successfully');
                print(await storage.read(key: AppSetting.userUid));
              }
            } else {
              throw Exception('Failed to save user ID to secure storage');
            }
          }
        }
      } else {
        throw Exception('No user is signed in');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user to server: $e');
      }
      rethrow;
    }
  }
}
