import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDetails extends StatefulWidget {
  final String? username;
  final String? name;
  final String? mailid;
  final String? mobile;
  final String? dOB;
  final String? profilepic;
  final VoidCallback onSave;
  const EditDetails({
    super.key,
    required this.username,
    required this.name,
    required this.mailid,
    required this.mobile,
    required this.dOB,
    required this.profilepic,
    required this.onSave,
  });

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  late TextEditingController usernameC;
  late TextEditingController nameC;
  late TextEditingController mailidC;
  late TextEditingController mobileC;
  late TextEditingController dOBC;
  late TextEditingController profilepicC;

  @override
  void initState() {
    super.initState();
    usernameC = TextEditingController(text: widget.username);
    nameC = TextEditingController(text: widget.name);
    mailidC = TextEditingController(text: widget.mailid);
    mobileC = TextEditingController(text: widget.mobile);
    dOBC = TextEditingController(text: widget.dOB);
    profilepicC = TextEditingController(text: widget.profilepic);
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameC.text);
    await prefs.setString('name', nameC.text);
    await prefs.setString('mailid', mailidC.text);
    await prefs.setString('mobile', mobileC.text);
    await prefs.setString('dOB', dOBC.text);
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'NewsApp',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          TextField(
            controller: profilepicC,
            decoration: InputDecoration(labelText: 'Profile Image link'),
          ),
          SizedBox(height: 40),
          TextField(
            controller: usernameC,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 40),
          TextField(
            controller: nameC,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 40),
          TextField(
            controller: mailidC,
            decoration: InputDecoration(labelText: 'Email ID'),
          ),
          SizedBox(height: 40),
          TextField(
            controller: mobileC,
            decoration: InputDecoration(labelText: 'Mobile No.'),
          ),
          SizedBox(height: 40),
          TextField(
            controller: dOBC,
            decoration: InputDecoration(labelText: 'DOB'),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await _saveData();

              if (!mounted) return;

              Navigator.pop(context);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
