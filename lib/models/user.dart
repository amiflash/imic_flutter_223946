import 'package:objectbox/objectbox.dart';
import 'package:view_and_layout_sample/models/workout.dart';
import 'package:view_and_layout_sample/objectbox.g.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  String userName;
  String email;
  String? avatarURL;
  String? sex;
  String? dateOfBird;
  double? height;
  double? weight;
  bool isLogined;
  String? avartarURL;

  @Backlink('user')
  final workouts = ToMany<Workout>();

  User({required this.userName, 
  required this.email,
  this.isLogined = false});
}