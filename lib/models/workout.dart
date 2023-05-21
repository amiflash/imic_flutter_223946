import 'package:objectbox/objectbox.dart';
import 'package:view_and_layout_sample/models/user.dart';
import 'package:view_and_layout_sample/objectbox.g.dart';

@Entity()
class Workout {
  @Id()
  int workoutId = 0;
  String workoutTitle;
  String distance; //distance in meter
  String duration;  // duration in second

  final user = ToOne<User>();

  Workout({required this.workoutTitle, 
  required this.distance,
  required this.duration});
}