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
  String? dateOfBirth;
  double? height;
  double? weight;
  bool isLogined;

  @Backlink('user')
  final workouts = ToMany<Workout>();

  User({
     this.userName = '', 
     this.email = '',
  this.isLogined = false});

}