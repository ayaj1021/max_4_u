String userLevel = '1';

class UserType {
  static selectUserType(String userTypeLevel) {
// final userTypeLevel = await SecureStorage().getUserType();
print(userTypeLevel);
    switch (userTypeLevel) {
      case '1':
        userLevel = 'Become a vendor';
        //Icon()
        break;

      default:
        userLevel = 'hhhh';
    }

    return userLevel;
  }
}
