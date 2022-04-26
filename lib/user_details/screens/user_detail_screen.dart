import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_task/user_details/model/user_details_model.dart';

class UserDetailScreen extends StatefulWidget {
  final Data data;

  const UserDetailScreen(this.data, {Key? key}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100.0, 0, 30),
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage:
                          NetworkImage(widget.data.avatar.toString()),
                    ),
                  ),
                ],
              ),
              Text(
                '${widget.data.firstName}' ' ' '${widget.data.lastName}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.data.email}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
