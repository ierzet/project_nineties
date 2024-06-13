import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:project_nineties/core/utilities/cache.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class AuthenticationInitiation {
  AuthenticationInitiation({
    firebase_auth.FirebaseAuth? firebaseAuth,
    CacheClient? cache,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _cache = cache ?? CacheClient();
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final CacheClient _cache;
  static const userCacheKey = '__user_cache_key__';
  Stream<UserAccountEntity> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? UserAccountEntity.empty : firebaseUser.toUser;

      return user;
    });
  }

  UserAccountEntity get currentUser {
    return _cache.read<UserAccountEntity>(key: userCacheKey) ??
        UserAccountEntity.empty;
  }
}

extension on firebase_auth.User {
  UserAccountEntity get toUser {
    return UserAccountEntity(
        userId: uid, email: email, name: displayName, photo: photoURL);
  }
}
