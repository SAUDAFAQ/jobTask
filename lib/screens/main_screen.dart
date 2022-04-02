import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_task/utilities/validator.dart';
import 'package:job_task/values/strings.dart';
import 'package:job_task/widget/gradient_button.dart';

import '../services/http_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _userNameController = TextEditingController();
  bool validate = true;
  String response = '';

  bool get isPopulated => _userNameController.text.isNotEmpty;

  bool isValidated(String name) {
    if (Validators.isValidName(name) == true) {
      setState(() {
        validate = false;
      });
      return false;
    } else {
      setState(() {
        validate = true;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: getDictionaryFormWidget(context));
  }

  getDictionaryFormWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: [
          Spacer(),
          const Text(
            StringLocalization.registerApp,
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _userNameController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: StringLocalization.enterYourName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.deepOrangeAccent),
              ),
              errorText: validate ? null : StringLocalization.enterValidName,
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Colors.deepOrangeAccent,
              ),
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          GradientButton(
            width: 150,
            height: 45,
            onPressed: () async {
              if (isValidated(_userNameController.text) == true) {
                response = await postData(_userNameController.text);
                response == '201'
                    ? showSnackBar(StringLocalization.youAreRegistered)
                    : showSnackBar(StringLocalization.issueOccurred);
              }
            },
            text: const Text(
              StringLocalization.submit,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  showSnackBar(String label) {
    final snackBar = SnackBar(
      content: Text(label),
      action: SnackBarAction(
        label: StringLocalization.ok,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<String> postData(String userName) async {
    try {
      final response = await HttpService.getRequest(userName);
      return response.statusCode.toString();
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }
}
