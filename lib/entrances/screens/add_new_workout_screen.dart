import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/home_screen.dart';
import 'package:view_and_layout_sample/models/workout.dart';
import 'package:view_and_layout_sample/providers/workout_provider.dart';
import 'package:view_and_layout_sample/workouts_screen.dart';

import '../../main.dart';

class AddNewWorkoutScreen extends StatefulWidget {
  final WorkoutProvider workoutProvider;
  AddNewWorkoutScreen({super.key,
  required this.workoutProvider});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<AddNewWorkoutScreen> createState() => _AddNewWorkoutScreenState();
}

class _AddNewWorkoutScreenState extends State<AddNewWorkoutScreen> {

  String workoutTitle = '';
  String distance = '';
  String duration = '';

  late WorkoutProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    provider = widget.workoutProvider;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTittle(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildTitleInput(),
                    _buildDistanceInput(),
                    _buildDurationInput()
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSaveButton(),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildTittle() {
    return Center(
      child: Text(
        'Add new workout',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  /* Widget _buildUserInputs() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: );
  }*/

  Widget _buildTitleInput() {
    return Container(
        child: TextField(
      decoration: InputDecoration(hintText: 'Title'),
      style: TextStyle(
          color: Color(0xff414141),
          fontSize: 14,
          fontWeight: FontWeight.normal),
      onChanged: (value) {
        this.workoutTitle = value;
      },
      onSubmitted: (value) {},
    ));
  }

  Widget _buildDistanceInput() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Distance',
            ),
        style: TextStyle(
            color: Color(0xff414141),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          this.distance = value;
        },
        onSubmitted: (value) {},
      ),
    );
  }

  Widget _buildDurationInput() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Duration',
            ),
        style: TextStyle(
            color: Color(0xff414141),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          this.duration = value;
        },
        onSubmitted: (value) {},
      ),
    );
  }

  Widget _buildSaveButton() {
    Color bgColor = Color(0xff823cff);

    return Container(
      child: TextButton(
          onPressed: () {
            this.doSaveWorkout();
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
                  'Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }

  void doSaveWorkout() {
    Workout workout = provider.createNewWorkout(workoutTitle, distance, duration);

    Navigator.of(context).pop(workout);
  }
}
