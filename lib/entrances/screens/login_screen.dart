import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/home_screen.dart';
import 'package:view_and_layout_sample/workouts_screen.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  final String title;
  Function onRegisterPress;

  LoginScreen({super.key, required this.title, required this.onRegisterPress});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String title;
  bool isPasswordShowing = false;

  String uoEmail = '';
  String passwowrd = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.title;
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
                    _buildUsernameInput(),
                    _buildPasswordInput(),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLoginButton(),
                _buildNotAccount(),
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
        this.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  /* Widget _buildUserInputs() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: );
  }*/

  Widget _buildUsernameInput() {
    return Container(
        child: TextField(
      decoration: InputDecoration(hintText: '@Username'),
      style: TextStyle(
          color: Color(0xff414141),
          fontSize: 14,
          fontWeight: FontWeight.normal),
      onChanged: (value) {},
      onSubmitted: (value) {},
    ));
  }

  Widget _buildPasswordInput() {
    String iconImageName = (isPasswordShowing)
        ? 'assets/images/icon-eye-slash.png'
        : 'assets/images/icon-eye.png';
    return Container(
      child: TextField(
        obscureText: isPasswordShowing,
        decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordShowing = !isPasswordShowing;
                });
              },
              icon: Image.asset(iconImageName),
            )),
        style: TextStyle(
            color: Color(0xff414141),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        onChanged: (value) {
          setState(() {
            passwowrd = value;
          });
        },
        onSubmitted: (value) {},
      ),
    );
  }

  Widget _buildLoginButton() {
    Color bgColor = Color(0xff823cff);

    return Container(
      child: TextButton(
          onPressed: () {
            UserInfo userInfo = this.createUserInfo();

            pref.setBool('kLogined', true);

            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => HomeScreen(
                userInfo: userInfo,
              ),
            ))
                .then((value) {
              setState(() {});
            });
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
                  'Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }

  Widget _buildNotAccount() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text('Don\'t have an account yet?'),
          TextButton(
              onPressed: () {
                widget.onRegisterPress();
              },
              child: Container(child: Text('Sign up')))
        ],
      ),
    );
  }

  UserInfo createUserInfo() {
    UserInfo userInfo =
        UserInfo(userName: 'binhle', email: 'binh.le@gmail.com');
    return userInfo;
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel booking'),
          content: Text('Are you sure want to cancel booking?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
