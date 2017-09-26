import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kingdom/HomePage.dart';
import 'package:kingdom/LoginWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kingdom/kingdom_firebase/db_ref.dart' as db_ref;
import 'dart:async';


class LoginStatus {
    static FirebaseAuth globalFirebaseAuth = FirebaseAuth.instance;
    static GoogleSignIn globalGoogleSignIn = new GoogleSignIn();

    static Future<Null> checkExistingUser(String userId) async {
        await db_ref.userRef.child(userId).once().then((snapshot) {
            if(snapshot.value == null) {
                print('new user');
                db_ref.userRef.child(userId).set({
                    'name': globalGoogleSignIn.currentUser.displayName,
                    'dp': globalGoogleSignIn.currentUser.photoUrl,
                    'email':globalGoogleSignIn.currentUser.email
                });
            }
            else {
                print('old user');
            }
        });
    }

    static Future<Null> initLogin(BuildContext context) async {

        GoogleSignInAccount gUser = globalGoogleSignIn.currentUser;
        if(gUser == null) {
            gUser = await globalGoogleSignIn.signInSilently();
        }

        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final FirebaseUser firebaseUser = await globalFirebaseAuth.signInWithGoogle(
            idToken: gAuth.idToken,
            accessToken: gAuth.accessToken
        ).then((res) async {
            await checkExistingUser(gUser.id);
            Navigator.of(context).pushReplacement(new HomePageRoute());
        });

    }

    static Future<Null> doLogin(BuildContext context) async {

        GoogleSignInAccount gUser = globalGoogleSignIn.currentUser;
        if(gUser == null) {
            gUser = await globalGoogleSignIn.signIn();
        }

        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final FirebaseUser firebaseUser = await globalFirebaseAuth.signInWithGoogle(
            idToken: gAuth.idToken,
            accessToken: gAuth.accessToken
        ).then((res) async {
            await checkExistingUser(gUser.id);
            Navigator.of(context).pushReplacement(new HomePageRoute());
        });

    }

    static void logOut(BuildContext context) {
        globalGoogleSignIn.signOut().then((res) {
            Navigator.of(context).pushReplacement(new LoginPageRoute());
        });
    }
}
