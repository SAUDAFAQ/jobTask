import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_task/user_details/screens/user_detail_screen.dart';

import '../../widget/gradient_button.dart';
import '../model/user_details_model.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late UserDetails userDetail;
  bool isLoading = true;

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: userDetail.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    Data data = userDetail.data![index];
                    return Card(
                        child: ListTile(
                      title: Text(data.firstName.toString()),
                      subtitle: Text(data.email.toString()),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data.avatar.toString()),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetailScreen(data)),
                        );
                      },
                    ));
                  }),
            ),
    );
  }

  void loadData() async {
    String url = "https://reqres.in/api/users?per_page=13";
    final response = await http.get(Uri.parse(url));
    userDetail = UserDetails.fromJson(jsonDecode(response.body));
    setState(() {
      isLoading = false;
    });
  }
}
