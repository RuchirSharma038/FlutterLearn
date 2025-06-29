import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/edit_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? username;
  String? name;
  String? mailid;
  String? mobile;
  String? dOB;
  String? profilepic;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '@user_name';
      name = prefs.getString('name') ?? 'User Full Name';
      mailid = prefs.getString('mailid') ?? 'Usermailid@mail.com';
      mobile = prefs.getString('mobile') ?? 'User mobile no.';
      dOB = prefs.getString('dOB') ?? 'DD/MM/YYYY';
      profilepic =
          prefs.getString('profilepic') ??
          'https://dummyimage.com/300x150/cccccc/ffffff&text=.';
    });
  }

  Future<void> _refreshData() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDetails(
                      username: username,
                      name: name,
                      mailid: mailid,
                      mobile: mobile,
                      dOB: dOB,
                      profilepic: profilepic,
                      onSave: _loadData,
                    ),
                  ),
                );
                _refreshData();
              },
              icon: Icon(Icons.edit),
            ),
          ),
        ],
        title: Text(
          'NewsApp',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              child: profilepic != null && profilepic!.isEmpty
                  ? Image.network(
                      profilepic!,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.person);
                      },
                    )
                  : const Icon(Icons.person),
            ),

            SizedBox(height: 5),
            Text(
              (username == null || username == '') ? '@user_name' : '$username',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              (name == null || name == '') ? 'User Full Name' : '$name',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              (mailid == null || mailid == '')
                  ? 'Useremailid@mail.com'
                  : '$mailid',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              (mobile == null || mobile == '') ? 'User Mobile no.' : '$mobile',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              (dOB == null || dOB == '') ? 'DD/MM/YYYY' : '$dOB',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
