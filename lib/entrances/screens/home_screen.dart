import 'dart:io';

import 'package:flutter/material.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/edit_profile_screen.dart';
import 'package:view_and_layout_sample/models/user.dart';
import 'package:view_and_layout_sample/providers/user_provider.dart';
import 'package:view_and_layout_sample/workouts_screen.dart';

import '../../helpers/file_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  late UserProvider _userProvider;
  late File avatarImageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userProvider = UserProvider();
    _user = _userProvider.getFirstUser();

    FileManager.instance
        .retrieveImage(_user.avatarURL ?? 'avatar_photo')
        .then((value) {
      if (value != null) {
        setState(() {
          avatarImageFile = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: _buildAvatar(),
        leadingWidth: 200,
      ),
      backgroundColor: Color(0xfff3f3f3),
      body: Container(
          child: WorkoutList(
        user: _user,
      )),
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
                radius: 35, backgroundImage: AssetImage(avatarImageFile.path)),
            Text(
              '@${_user.userName}',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddnewWorkoutButton() {
    Color bgColor = Color(0xff823cff);

    return Container(
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
                  'Add new workout',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ))),
    );
  }

  void gotoEditUserProfile() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => EditProfileScreen(user: _user),
    ))
        .then((value) {
      
      setState(() {
        _user = _userProvider.getUserById(_user.id)!;
      });

      FileManager.instance
          .retrieveImage(_user.avatarURL ?? 'avatar_photo')
          .then((value) {
        if (value != null) {
          setState(() {
            avatarImageFile = value;
          });
        }
      });
    });
  }
}
