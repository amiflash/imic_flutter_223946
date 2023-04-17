import 'package:flutter/material.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  UserInfo userInfo;

  HomeScreen({super.key, required this.userInfo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserInfo _userInfo;

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
        leading: _buildAvatar(),
        leadingWidth: 200,
      ),
      body: Container(),
    );
  }

  Widget _buildAvatar() {
    return InkWell(
      onTap: () {
        this.gotoEditUserProfile();
      },
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
                radius: 35,
                child: Image.asset(
                  'assets/images/entrance/icon-avatar.png',
                )),
            Text(
              '@${_userInfo.userName}',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  void gotoEditUserProfile() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => EditProfileScreen(
        userInfo: widget.userInfo,
      ),
    ))
        .then((value) {
      setState(() {
       
      });
    });
  }
}
