import 'package:flutter/material.dart';
import 'package:kingdom/kingdom_firebase/login_status.dart';
import 'package:kingdom/kingdom_firebase/db_ref.dart' as db_ref;

void addPost({
    String text,
    int timestamp,
    BuildContext context
}) {
    print('current user name: ');
    print(LoginStatus.globalGoogleSignIn.currentUser.displayName);
    db_ref.postRef.push().set({
        'text':text,
        'timestamp':timestamp.toString(),
        'user_id': LoginStatus.globalGoogleSignIn.currentUser.id
    }).then((res) {
        Navigator.of(context).pop();
    }).catchError((err) {
        print('COULD NOT ADD NEW POST: ');
    });
}

void addPostComment({
    String postId,
    String text
}) {
    db_ref.postCommentRef.child(postId).push().set({
        'text': text,
        'timestamp': db_ref.currentEpoch,
        'user_id': db_ref.currentUserId
    });
}