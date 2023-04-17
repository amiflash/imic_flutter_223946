class UserInfo {
  String userName;
  String email;
  String sex;
  String dateOfBird;
  double height;
  double weight;

  UserInfo({
    required this.userName,
    required this.email,
    this.sex = 'Male',
    this.dateOfBird = '',
    this.height = 0,
    this.weight = 0,
  });
}