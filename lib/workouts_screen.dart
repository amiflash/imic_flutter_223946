import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:view_and_layout_sample/entrances/screens/add_new_workout_screen.dart';
import 'package:view_and_layout_sample/models/user.dart';
import 'package:view_and_layout_sample/models/workout.dart';
import 'package:view_and_layout_sample/providers/workout_provider.dart';

class WorkoutsScreen extends StatefulWidget {
  final User user;

  const WorkoutsScreen({super.key, 
  required this.user});

  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text('Workouts'),
        leading: TextButton(child: Text('Back', 
        style: TextStyle(color: Colors.black),), 
        onPressed: () {
            Navigator.of(context).pop();
        },),
      ),
      backgroundColor: Color(0xfff3f3f3),
        body: Container(
          margin: EdgeInsets.only(top: 20),
      child: WorkoutList(user: user)
    ));
  }

  Widget _buildHeaderTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        'Apple Health',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDesText() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        'Select one workout to sync with Liv3ly',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }
}

class WorkoutList extends StatefulWidget {
   final User user;

  const WorkoutList({super.key, 
  required this.user});

  @override
  _WorkoutsListState createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutList> {
  List<Workout> workouts = [];
  late WorkoutProvider workoutProvider;
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = widget.user;

    workoutProvider = WorkoutProvider(user: user);

    final pWorkouts = workoutProvider.getWorkouts();

    setState(() {
      workouts = pWorkouts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          //_buildHeaderTitle(),
         // _buildDesText(),
          _buildWorkouts(),
          _buildAddNewWorkoutButton()
        ],
      );
  }

  Widget _buildWorkouts() {
    return Expanded(
        child: ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              return buildWorkoutItem(workouts[index]);
            }));
  }

  Widget buildWorkoutItem(Workout workout) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.all(16),
              child: Text(workout.workoutTitle, 
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffb9b9b9))),),
          ),
          Padding(padding: EdgeInsets.all(16), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Image.asset('assets/images/Icon-run.png', width: 18, height: 18,),
             SizedBox(width: 15,),
             Text(workout.distance),
             SizedBox(width: 5,),
             Text('km'),
              SizedBox(width: 15,),
              Text(workout.duration),
               SizedBox(width: 5,),
             Text('Time'),
              SizedBox(width: 15,),
              Text(workout.duration), //Should change to pace info
               SizedBox(width: 5,),
             Text('Pace'),

          ],),)
        ],
      ),
    );
  }

  Widget _buildAddNewWorkoutButton() {
    //Color bgColor = Color(0xffD9C5FA);

    // if (isRegistrationEnable) {
    Color bgColor = Color(0xff823cff);
    // }

    return Container(
       margin: EdgeInsets.only(top: 20, bottom: 40),
      child: TextButton(
          onPressed: () {
            gotoAddNewWorkoutScreen();
          },
          child: Container(
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: bgColor,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Add new workout',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }

  void gotoAddNewWorkoutScreen() {
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => AddNewWorkoutScreen(workoutProvider: workoutProvider),
    ),
  ).then((workout) {
      setState(() {
        workouts.add(workout);
      });
  });
  }
}
