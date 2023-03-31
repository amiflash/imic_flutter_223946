import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  LoginScreen({super.key, required this.title});

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
  late bool isTermAccepted;
  bool isPasswordShowing = false;
  bool isConfirmPasswordShowing = false;
  bool isGetPromotionAccepted = false;

  String userName = '';
  String email = '';
  String passwowrd = '';
  String confirmPassword = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.title;
    isTermAccepted = false;
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
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTittle(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildUsernameInput(),
                    _buildEmailInput(),
                    _buildPasswordInput(),
                    _buildConfirmPasswordInput(),
                    _buildPasswordValidations(),
                    _buildPasswordValidations(),
                    _buildPasswordValidations(),
                    _buildTermsAndConditions(),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildRegisterButton(),
                _buildAlreadyAccount(),
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
      onChanged: (value) {
        setState(() {
          userName = value;
        });
      },
      onSubmitted: (value) {},
    ));
  }

  Widget _buildEmailInput() {
    return Container(
        child: TextField(
      decoration: InputDecoration(hintText: 'Email'),
      style: TextStyle(
          color: Color(0xff414141),
          fontSize: 14,
          fontWeight: FontWeight.normal),
      onChanged: (value) {
        setState(() {
          email = value;
        });
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

  Widget _buildTermsAndConditions() {
    return Container(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Checkbox(
                    value: isTermAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermAccepted = !isTermAccepted;
                      });
                    }),
                Expanded(
                    child: Text(
                  'By signing up you accept our terms and conditions and privacy policy',
                  maxLines: 2,
                )),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: isGetPromotionAccepted,
                    onChanged: (value) {
                      setState(() {
                        isGetPromotionAccepted = !isGetPromotionAccepted;
                      });
                    }),
                Expanded(
                    child: Text(
                  'I agree to receive promotional messages and updates by email, text notifications, phone and post from LIV3LY.',
                  maxLines: 3,
                )),
              ],
            ),
          ],
        ));
  }

  Widget _buildRegisterButton() {
    Color bgColor = Color(0xffD9C5FA);

    bool isRegistrationEnable = isRegisterCompliant(passwowrd, email);

    if (isRegistrationEnable) {
      bgColor = Color(0xff823cff);
    }

    return Container(
      child: TextButton(
          onPressed: () {
            if (isRegistrationEnable) {}
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
                  'Register Now',
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
          TextButton(onPressed: () {}, child: Container(child: Text('Login')))
        ],
      ),
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
    if (userName.isEmpty) {
      return false;
    }

    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    //bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength =
        password.length >= minLength && userName.length >= minLength;

    bool emailValidation = isEmailValidation(email);
    return hasDigits &
        hasUppercase &
        hasSpecialCharacters &
        hasMinLength &
        emailValidation &
        isTermAccepted &
        isGetPromotionAccepted;
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
