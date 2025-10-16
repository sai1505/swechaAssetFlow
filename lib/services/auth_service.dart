import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'r2_storage_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign up with email - Store user data in R2
  static Future<UserModel?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Validate email
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw 'Invalid email format';
      }

      // Validate password
      if (password.length < 6) {
        throw 'Password must be at least 6 characters';
      }

      // Check if user already exists
      final existingUser = await _checkUserExists(email);
      if (existingUser) {
        throw 'Email already registered';
      }

      // Create user ID
      final userId = _generateUserId(email);

      // Hash password
      final hashedPassword = _hashPassword(password);

      // Create user object
      final user = UserModel(
        id: userId,
        name: name,
        email: email,
        password: hashedPassword,
        createdAt: DateTime.now(),
      );

      // Save to R2
      final fileName = 'users/$userId.json';
      final success = await R2StorageService.uploadBytes(
        Uint8List.fromList(utf8.encode(user.toJsonString())),
        fileName,
        contentType: 'application/json',
      );

      if (success) {
        print('User created successfully: $userId');
        return user;
      } else {
        throw 'Failed to create user account';
      }
    } catch (e) {
      print('Signup error: $e');
      rethrow;
    }
  }

  /// Sign in with Google - Get user data from Firebase and store in R2
  static Future<UserModel?> signInWithGoogle() async {
    try {
      print('=== STARTING GOOGLE SIGN IN ===');

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('User cancelled Google Sign-In');
        return null; // User cancelled
      }

      print('Google user: ${googleUser.email}');

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        print('Firebase user: ${firebaseUser.uid}');
        print('Display name: ${firebaseUser.displayName}');
        print('Email: ${firebaseUser.email}');

        // Create user ID from email
        final userId = _generateUserId(firebaseUser.email!);

        // Check if user already exists in R2
        final existingUser = await _checkUserExists(firebaseUser.email!);

        if (!existingUser) {
          // New user - Create and save to R2
          final user = UserModel(
            id: userId,
            name: firebaseUser.displayName ?? 'Google User',
            email: firebaseUser.email!,
            password: '', // No password for Google sign-in
            createdAt: DateTime.now(),
          );

          // Save to R2
          final fileName = 'users/$userId.json';
          final success = await R2StorageService.uploadBytes(
            Uint8List.fromList(utf8.encode(user.toJsonString())),
            fileName,
            contentType: 'application/json',
          );

          if (success) {
            print('Google user data saved to R2');
            return user;
          } else {
            throw 'Failed to save user data';
          }
        } else {
          // Existing user - Fetch from R2
          print('Existing Google user - fetching from R2');
          final fileName = 'users/$userId.json';
          final data = await R2StorageService.downloadFile(fileName);

          if (data != null) {
            final userJson = jsonDecode(utf8.decode(data));
            return UserModel.fromJson(userJson);
          }
        }
      }

      return null;
    } catch (e) {
      print('Google sign in error: $e');
      rethrow;
    }
  }

  /// Sign out from both Google and Firebase
  static Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      print('User signed out successfully');
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  /// Check if user exists in R2
  static Future<bool> _checkUserExists(String email) async {
    try {
      final userId = _generateUserId(email);
      final fileName = 'users/$userId.json';

      final data = await R2StorageService.downloadFile(fileName);
      return data != null;
    } catch (e) {
      return false;
    }
  }

  /// Generate user ID from email
  static String _generateUserId(String email) {
    final bytes = utf8.encode(email.toLowerCase());
    final hash = sha256.convert(bytes);
    return hash.toString().substring(0, 16);
  }

  /// Hash password
  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// Login with email - Verify credentials from R2
  static Future<UserModel?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userId = _generateUserId(email);
      final fileName = 'users/$userId.json';

      // Download user data
      final data = await R2StorageService.downloadFile(fileName);
      if (data == null) {
        throw 'User not found';
      }

      // Parse user data
      final userJson = jsonDecode(utf8.decode(data));
      final user = UserModel.fromJson(userJson);

      // Verify password
      final hashedPassword = _hashPassword(password);
      if (user.password != hashedPassword) {
        throw 'Invalid password';
      }

      return user;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }
}
