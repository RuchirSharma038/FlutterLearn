import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

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
            child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
              child: Icon(Icons.person),
            ),

            SizedBox(height: 5),
            Text(
              '@user_name',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              'User Full Name',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'Useremailid@mail.com',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'User Mobile no.',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'DD/MM/YYYY',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
