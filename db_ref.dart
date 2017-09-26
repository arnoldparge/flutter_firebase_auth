import 'package:firebase_database/firebase_database.dart';
import 'package:kingdom/kingdom_firebase/login_status.dart';

int currentEpoch = new DateTime.now().toUtc().millisecondsSinceEpoch;

String currentUserId = LoginStatus.globalGoogleSignIn.currentUser.id;

//Root reference
DatabaseReference rootRef = FirebaseDatabase.instance.reference().child('v1');

//First node references
DatabaseReference userRef = rootRef.child('users');
DatabaseReference postRef = rootRef.child('posts');
DatabaseReference postCommentRef = rootRef.child('post_comments');