// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:snowflake_client/auth/service/auth.service.dart';
//
// class AuthAppleService extends IAuthService {
//   AuthAppleService(this.ref);
//
//   final Ref ref;
//
//   @override
//   Future<dynamic> signIn([bool isEntry = false]) async {
//     // if (ref.read(authLocalRepositoryProvider.notifier).idToken != null) {
//     //   return _verify();
//     // }
//     if (isEntry) {
//       return null;
//     }
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );
//     final oauthCredential = OAuthProvider('apple.com').credential(
//       idToken: appleCredential.identityToken,
//       accessToken: appleCredential.authorizationCode,
//     );
//     await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//     final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
//     if (idToken == null) {
//       return null;
//     }
//     ref.read(authLocalRepositoryProvider.notifier)
//       ..setAuthType(AuthType.APPLE)
//       ..setIdToken(idToken);
//     return _verify();
//   }
//
//   dynamic _verify() async {
//     try {
//       final data = await ref.read(authRestRepositoryProvider).verify();
//       final uid = data['uid'] as String;
//       final customToken = data['customToken'] as String;
//       ref.read(authControllerProvider.notifier).setUId(uid);
//       ref.read(authLocalRepositoryProvider.notifier).setCustomToken(customToken);
//       await Hive.openBox(uid);
//       return data;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   @override
//   Future<void> delete() async => ref.read(authControllerProvider.notifier).delete();
// }
