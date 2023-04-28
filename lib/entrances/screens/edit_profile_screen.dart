import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/welcome_screen.dart';
import 'package:view_and_layout_sample/helpers/file_manager.dart';
import 'package:view_and_layout_sample/main.dart';
import 'package:view_and_layout_sample/models/user.dart';
import 'package:view_and_layout_sample/providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User _user;
  String userName = '';
  File? avatarImageFile;
  late TextEditingController userNameTextController;
  String avatarImageName = '';
  UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    userName = _user.userName;

    userNameTextController = TextEditingController(text: userName);

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
        leadingWidth: 200,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(_user);
          },
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Icon(Icons.arrow_back_ios),
              Text(
                '@${_user.userName}',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            _buildUsernameInput(),
            _buildAvatar(),
            _buildSaveButton(),
            SizedBox(
              height: 20,
            ),
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
          controller: userNameTextController,
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

  Widget _buildAvatar() {
    String imageName = (avatarImageFile == null)
        ? 'assets/images/entrance/icon-avatar.png'
        : avatarImageFile!.path;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: InkWell(
          child: CircleAvatar(
              radius: 65,
              foregroundImage: AssetImage(
                imageName,
              )),
          onTap: () {
            showGallery();
          },
        ));
  }

  void showGallery() {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        avatarImageFile = File(value!.path);
        avatarImageName = avatarImageFile?.uri.pathSegments.last ?? '';
      });
    });
  }

  Widget _buildSaveButton() {
    Color bgColor = userName.isEmpty ? Color(0xffD9C5FA) : Color(0xff823cff);

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
    FileManager.instance
        .saveImage(File(avatarImageFile!.path), avatarImageName)
        .then((value) {
        print('new avatar file: ${value.path},');
         _userProvider.updateUserNameAndAvatarURL(
        userName,value.uri.pathSegments.last , _user.id)!;
         Future.delayed(Duration(milliseconds: 300), () {
           Navigator.of(context).pop(_user);
         });
    });

   
  }

  void doLogout() {
    // pref.setBool('kLogined', false);
    _userProvider.updateLoginStatus(_user.id, false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
