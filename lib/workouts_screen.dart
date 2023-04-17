import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutsScreen extends StatefulWidget {
  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.settings)),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more))
        ],
      ),
      backgroundColor: Color(0xfff3f3f3),
        body: Container(
          margin: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          _buildHeaderTitle(),
          _buildDesText(),
          _buildWorkouts(),
          _buildContinueButton()
        ],
      ),
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

  Widget _buildWorkouts() {
    return Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return buildWorkoutItem(index);
            }));
  }

  Widget buildWorkoutItem(index) {
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
              child: Text('05/04/2022, 12:30am', 
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffb9b9b9))),),
          ),
          Padding(padding: EdgeInsets.all(16), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Image.asset('assets/images/Icon-run.png', width: 18, height: 18,),
             SizedBox(width: 15,),
             Text('10.71'),
             SizedBox(width: 5,),
             Text('km'),
              SizedBox(width: 15,),
              Text('10.71'),
               SizedBox(width: 5,),
             Text('km'),
              SizedBox(width: 15,),
              Text('10.71'),
               SizedBox(width: 5,),
             Text('km'),

          ],),)
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    //Color bgColor = Color(0xffD9C5FA);

    // if (isRegistrationEnable) {
    Color bgColor = Color(0xff823cff);
    // }

    return Container(
       margin: EdgeInsets.only(top: 20, bottom: 40),
      child: TextButton(
          onPressed: () {},
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
                  'Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }
}
