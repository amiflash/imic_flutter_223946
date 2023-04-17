import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/welcome_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final UserInfo userInfo;

EditProfileScreen({super.key,
 required this.userInfo});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();

}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserInfo _userInfo;
  String userName = '';

@override
void initState() {
    // TODO: implement initState
    super.initState();
    _userInfo = widget.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: InkWell(onTap: () {
            Navigator.of(context).pop();
        },
          child:  Row(children: [
            SizedBox(width: 15,),
          Icon(Icons.arrow_back_ios),
          Text('@${_userInfo.userName}', style: TextStyle(fontSize: 20),)

        ],),),
      ),
      body: Container(
          child: Column(
            children: [
              SizedBox(height: 50,),
              _buildUsernameInput(),
              _buildSaveButton(),
              SizedBox(height: 20,),
              _buildLogoutButton()
            ],
          ),
      ),
    );
  }

  Widget _buildUsernameInput() {
    return Container(
      margin: EdgeInsets.all(16),
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
      onSubmitted: (value) {

      },
    ));
  }

   Widget _buildSaveButton() {
    Color bgColor =  userName.isEmpty ? Color(0xffD9C5FA) :Color(0xff823cff);

    return Container(
      child: TextButton(
          onPressed: () {
            if (userName.isEmpty) {
              return;
            }

            this.doSaveUserInfo();
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

  Widget _buildLogoutButton() {
    Color bgColor = Colors.white;

    return Container(
      child: TextButton(
          onPressed: () {
          this.doLogout();
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
                  'Sign out',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }

  void doSaveUserInfo() {
    _userInfo.userName = userName;

    Navigator.of(context).pop(_userInfo);
  }

  void doLogout() {
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => WelcomeScreen(),
    ),
  );
  }
}