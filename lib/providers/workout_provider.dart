import 'package:view_and_layout_sample/main.dart';
import 'package:view_and_layout_sample/models/user.dart';
import 'package:view_and_layout_sample/models/workout.dart';
import 'package:view_and_layout_sample/objectbox.g.dart';

class WorkoutProvider {
  final User user;

WorkoutProvider({required this.user});

  final workoutBox = objectbox.store.box<Workout>();

  Workout createNewWorkout(String title, 
  String distance,
   String duration) {
    final workout = Workout(workoutTitle: title, 
    distance: distance, duration: duration);
    workout.user.target = user;
    
    workoutBox.put(workout);

    return workout;
  }

  List<Workout> getWorkouts() {
    return user.workouts;
  }
}