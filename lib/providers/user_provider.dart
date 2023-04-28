import 'package:view_and_layout_sample/main.dart';
import 'package:view_and_layout_sample/models/user.dart';
import 'package:view_and_layout_sample/objectbox.g.dart';

class UserProvider {
  final userBox = objectbox.store.box<User>();

bool checkIfUserExisting() {
  QueryBuilder queryBuilder = userBox.query(User_.isLogined.equals(true));
  Query query = queryBuilder.build();
  return (query.count() > 0);
}

  User createUser(String userName, String email) {
    final user = User(userName: userName, email: email);
    user.isLogined = true;
    userBox.put(user);

    return user;
  }

  bool userByUserNameExisting(String userName) {
    print('username need to check: $userName');
    QueryBuilder queryBuilder = userBox.query(User_.userName.equals(userName));
    Query query = queryBuilder.build();
    return (query.count() > 0);
  }

  User? getUserByUserName(String userName) {
    QueryBuilder queryBuilder = userBox.query(User_.userName.equals(userName));
    Query query = queryBuilder.build();
    return query.findFirst();
  }

  User? updateUserName(String userName, int userId) {
    User? user = getUserById(userId);

    if (user != null) {
      user.userName = userName;
      userBox.put(user);
    }

    return user;
  }

  User? updateAvatarUrl(String avatarURL, int userId) {
    User? user = getUserById(userId);

    if (user != null) {
      user.avatarURL = avatarURL;
      userBox.put(user);
    }

    return user;
  }

  User? updateUserNameAndAvatarURL(String userName,
   String avatarURL,
   int userId) {
    User? user = getUserById(userId);

    if (user != null) {
      user.userName = userName;
      user.avatarURL = avatarURL;
      userBox.put(user);
    }

    return user;
   }

  void updateLoginStatus(int userId, bool isLogined) {
    User? user = getUserById(userId);

    if (user != null) {
      user.isLogined = isLogined;

      userBox.put(user);
    }
  }

  User? getUserById(int userId) {
    return userBox.get(userId);
  }

  User getFirstUser() {
    QueryBuilder queryBuilder = userBox.query(User_.isLogined.equals(true));
    Query query = queryBuilder.build();
    return query.findFirst();
  }
}