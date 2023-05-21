
import 'package:flutter/material.dart';
import 'package:view_and_layout_sample/entrances/screens/login_screen.dart';
import 'package:view_and_layout_sample/entrances/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomeScreenState();
  }

}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
        child: Stack(children: [
          Image.asset('assets/images/entrance/bg-welcome.png', fit: BoxFit.cover,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('Hi there!',
                 style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('We’re excited to have you on our team as we have fun and cheer each other on towards leading an active lifestyle!',
                 maxLines: 4,
                 textAlign: TextAlign.center,
                 style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),),),
                ),
                _buildGetStartButton(),
                _buildAlreadyAccount(),
                SizedBox(height: 40,)
          ],)
        ],),
    );
  }

  Widget _buildGetStartButton() {
    Color bgColor = Color(0xff823cff);

    return Container(
      child: TextButton(
          onPressed: () {
           this.gotoRegisterScreen();
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
                  'Get Start',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }

  Widget _buildAlreadyAccount() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text('Already have an account?'),
          TextButton(onPressed: () {
            this.gotoLoginScreen();
          }, child: Container(child: Text('Login')))
        ],
      ),
    );
  }

  void gotoLoginScreen() {
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => LoginScreen(title: 'Login', onRegisterPress: () {
        Navigator.of(context).pop();
         this.gotoRegisterScreen();
      }

     
      ,),
    ),
  );
  }

  void gotoRegisterScreen() {
     Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => RegisterScreen(title: 'Register',
       onLoginPress: () {
         Navigator.of(context).pop();
         this.gotoLoginScreen();
      },),
    ),
  );
  }

}