//@dart=2.9
import '/main.dart';
import '/services/provider.dart';
import '/screens/home_screen.dart';
import '/services/requests.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../services/constants.dart';
import '../widget/input_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

const thingsBoardApiEndpoint = 'http://192.168.0.35:8080/';
const username = 'api-test@de.local';
const password = 'api-test';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String error = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // tbClient = ThingsboardClient(thingsBoardApiEndpoint);
  }

  login(context) async {
    setState(() {
      isLoading = true;
      error = "";
    });
    var res = await Provider.of<DataProvider>(context, listen: false).login(
        username: emailTextController.text,
        password: passwordTextController.text);
    if (!res["success"]) {
      setState(() {
        isLoading = false;
        error = res["payload"].toString();
      });
    } else
      setState(() {
        isLoading = false;
        error = "";
      });
    // print(await API.loginUser(username: "kidus", password: "kidus"));
    // final res = await Provider.of<DataProvider>(context)
    //     .login(emailTextController.text, passwordTextController.text);
    // print(res);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 100,
            right: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kPrimaryColor),
            )),
        Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kPrimaryColor),
            )),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/login1.json',
                      height: MediaQuery.of(context).size.height * 0.3),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  InputContainer(
                      child: TextField(
                    controller: emailTextController,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        icon: Icon(Icons.mail, color: kPrimaryColor),
                        hintText: 'Username',
                        border: InputBorder.none),
                  )),
                  InputContainer(
                      child: TextField(
                    controller: passwordTextController,
                    cursorColor: kPrimaryColor,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: kPrimaryColor),
                        hintText: 'Password',
                        border: InputBorder.none),
                  )),
                  SizedBox(height: 20),
                  InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Text(
                          (isLoading ? 'Please wait...' : 'LOGIN'),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      onTap: () async {
                        login(context);
                        // setState(() {
                        //   error = "";
                        //   isLoading = true;
                        // });
                        // final res = await login(context);
                        // if (tbClient.isAuthenticated() == true) {
                        //   Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) => HomeScreen()));
                        // } else
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                      }),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
