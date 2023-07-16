import 'package:aljouf/auth/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../models/user.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authController = Get.put(AuthController());

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;
    final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    try {
      await _auth
          .signInWithProvider(googleAuthProvider)
          .then((userCredential) async {
        print(userCredential.credential!.providerId);
        print(userCredential.user!.email!);
        print('My Phone Number -----------> : ${userCredential.user!.phoneNumber!}');
        print('Access Token: ${userCredential.credential!.accessToken!}');
        user = await _authController.loginUsingSocialMedia(
          context: context,
          provider: 'google',
          email: userCredential.user!.email!,
          accessToken: userCredential.credential!.accessToken!,
        );
      });
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signInWithApple({required BuildContext context}) async {
    User? user;
    final AuthorizationResult appleResult =
        await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    final AuthCredential credential = OAuthProvider('apple.com').credential(
      accessToken:
          String.fromCharCodes(appleResult.credential!.authorizationCode!),
      idToken: String.fromCharCodes(appleResult.credential!.identityToken!),
    );
    try {
      await _auth.signInWithCredential(credential).then((userCredential) async {
        print('Apple User: ${userCredential.user}');
        print('Access Token: ${userCredential.credential!.accessToken!}');
        print(userCredential.credential!.providerId);
        print(userCredential.user!.providerData.first.email);
        print(userCredential.credential!.accessToken!);
        user = await _authController.loginUsingSocialMedia(
          context: context,
          provider: 'apple',
          email: userCredential.user!.providerData.first.email!,
          accessToken: userCredential.credential!.accessToken!,
        );
      });
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
