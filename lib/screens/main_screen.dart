import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/bloc/login_bloc.dart';
import 'package:job_task/bloc/login_event.dart';
import 'package:job_task/user_details/screens/users_list_screen.dart';
import 'package:job_task/utilities/validator.dart';
import 'package:job_task/values/strings.dart';
import 'package:job_task/widget/gradient_button.dart';

import '../bloc/login_state.dart';
import '../repository/http_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool validate = true;
  bool passwordValidate = true;
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

  bool isPasswordValidated(String password) {
    if (Validators.isValidPassword(password) == false) {
      setState(() {
        passwordValidate = false;
      });
      return false;
    } else {
      setState(() {
        passwordValidate = true;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (_context, state) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              print(state.response);
              state.loginStatus == LoginRequestStatus.success
                  ? showSnackBar(StringLocalization.youAreRegistered)
                  : showSnackBar(StringLocalization.issueOccurred);
            },
            child: Scaffold(
                backgroundColor: Colors.blueGrey[900],
                body: getDictionaryFormWidget(_context, state)),
          );
        },
      ),
    );
  }

  getDictionaryFormWidget(BuildContext context, LoginState state) {
    return Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: [
          const Spacer(),
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
            height: 10,
          ),
          TextField(
            controller: _passwordController,
            style: const TextStyle(color: Colors.black),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: StringLocalization.enterPassword,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.deepOrangeAccent),
              ),
              errorText: passwordValidate
                  ? null
                  : StringLocalization.enterValidPassword,
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: const Icon(
                Icons.password,
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
              if (isValidated(_userNameController.text) == true &&
                  isPasswordValidated(_passwordController.text)) {
                BlocProvider.of<LoginBloc>(context).add(LoginWithUserDetails(
                    username: _userNameController.text,
                    password: _passwordController.text));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UsersListScreen()),
                );
                // response = await postData(_userNameController.text);
                // response == '201'
                //     ? showSnackBar(StringLocalization.youAreRegistered)
                //     : showSnackBar(StringLocalization.issueOccurred);
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
