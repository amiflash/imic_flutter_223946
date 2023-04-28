import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/home_screen.dart';
import 'package:view_and_layout_sample/workouts_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String title;

  ForgotPasswordScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late String title;
  bool isPasswordShowing = false;
  bool isConfirmPasswordShowing = false;
  
  String passwowrd = '';
  String confirmPassword = '';

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
              
                    _buildEmailInput(),
                    _buildPasswordInput(),
                    _buildConfirmPasswordInput(),
                    _buildPasswordValidations(),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildContinueButton(),
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

 
  Widget _buildEmailInput() {
    return Container(
        child: TextField(
      decoration: InputDecoration(hintText: 'Email'),
      style: TextStyle(
          color: Color(0xff414141),
          fontSize: 14,
          fontWeight: FontWeight.normal),
      onChanged: (value) {
        
      },
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

  Widget _buildConfirmPasswordInput() {
    String iconImageName = (isConfirmPasswordShowing)
        ? 'assets/images/icon-eye-slash.png'
        : 'assets/images/icon-eye.png';
    return Container(
      child: TextField(
        obscureText: isConfirmPasswordShowing,
        decoration: InputDecoration(
            hintText: 'Confirm password',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isConfirmPasswordShowing = !isConfirmPasswordShowing;
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
            confirmPassword = value;
          });
        },
        onSubmitted: (value) {},
      ),
    );
  }

  Widget _buildPasswordValidations() {
    String minCharacterRequiredString = '3/8 characters required ';
    String symbolAndNumberString = 'Add symbols and numbers ';
    String uppercaseString = 'Add uppercase ';

    bool hasMinCharacters = passwowrd.length >= 3;
    bool hasSymbolAndNumber = isPasswordHasSymbolsAndNumbers(passwowrd);
    bool hasUppercaseCharacter = isPasswordHasUppercase(passwowrd);
    /*if (!hasMinCharacters) {
      minCharacterRequiredString += '-';
    }*/
    return Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  minCharacterRequiredString,
                ),
                Visibility(visible: !hasMinCharacters, child: Text('-')),
                Visibility(
                    visible: hasMinCharacters,
                    child: Icon(Icons.check_circle_rounded,
                        color: Color(0xff68e7da), size: 20))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  symbolAndNumberString,
                ),
                Visibility(visible: !hasSymbolAndNumber, child: Text('-')),
                Visibility(
                    visible: hasSymbolAndNumber,
                    child: Icon(Icons.check_circle_rounded,
                        color: Color(0xff68e7da), size: 20))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  uppercaseString,
                ),
                Visibility(visible: !hasUppercaseCharacter, child: Text('-')),
                Visibility(
                    visible: hasUppercaseCharacter,
                    child: Icon(Icons.check_circle_rounded,
                        color: Color(0xff68e7da), size: 20))
              ],
            ),
          ],
        ));
  }

 

  Widget _buildContinueButton() {
    Color bgColor = Color(0xffD9C5FA);

    bool isRegistrationEnable = true;

    if (isRegistrationEnable) {
      bgColor = Color(0xff823cff);
    }

    return Container(
      child: TextButton(
          onPressed: () {
            if (isRegistrationEnable) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
            }
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

  bool isPasswordHasSymbolsAndNumbers(String password) {
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasDigits && hasSpecialCharacters;
  }

  bool isPasswordHasUppercase(String password) {
    return password.contains(new RegExp(r'[A-Z]'));
  }

  bool isEmailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isRegisterCompliant(String password, String email, [int minLength = 3]) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    //bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  

    bool emailValidation = isEmailValidation(email);
    return hasDigits &
        hasUppercase &
        hasSpecialCharacters &
        emailValidation;
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
