import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/login_request.dart';
import '../../models/otp_verified.dart';
import '../user_info.dart';

class UserLandingScreen extends StatefulWidget {
  const UserLandingScreen({Key? key}) : super(key: key);

  @override
  State<UserLandingScreen> createState() => _UserLandingScreenState();
}

class _UserLandingScreenState extends State<UserLandingScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isLoginRequestLoading = false;
  bool isOtpVerifyingLoading = false;
  String? showErrorMessage;
  LoginRequest? loginRequest;
  OtpVerified? otpVerified;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users - Info'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 50, bottom: 50),
                child: TextField(
                  controller: mobileNumberController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    hintText: "Enter Mobile Number",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                    labelText: "Enter Mobile Number",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(214, 31, 38, 1), width: 2),
                      //borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              if (isLoginRequestLoading)
                const CircularProgressIndicator(
                  color: Colors.red,
                ),
              if (!isLoginRequestLoading)
                GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    requestLogin();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayingScreen2(isMobileFirst: true,)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              if (loginRequest != null)
                Container(
                    margin: const EdgeInsets.all(40),
                    child: Text(
                      'OTP -> ' + loginRequest!.otp.toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )),
              if (loginRequest != null)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 50, bottom: 50),
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: "Enter OTP",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelText: "Enter OTP",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(214, 31, 38, 1), width: 2),
                        //borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              if (loginRequest != null && isOtpVerifyingLoading)
                const CircularProgressIndicator(
                  color: Colors.red,
                ),
              if (loginRequest != null && !isOtpVerifyingLoading)
                GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    verifyLogin();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Send OTP',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              if (showErrorMessage != null)
                Container(
                    margin: const EdgeInsets.all(40),
                    child: Text(
                      showErrorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w600),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  void requestLogin() async {
    setState(() {
      isLoginRequestLoading = true;
      showErrorMessage = null;
    });
    Map<String, dynamic> data = {'phone': mobileNumberController.value.text};
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post(
          'https://flutter.magadh.co/api/v1/users/login-request',
          data: formData);
      loginRequest = LoginRequest.fromJson(response.data);
      setState(() {
        isLoginRequestLoading = false;
      });
    } catch (e) {
      DioException temp = e as DioException;
      setState(() {
        isLoginRequestLoading = false;
        showErrorMessage = temp.response?.statusMessage;
      });
    }
  }

  void verifyLogin() async {
    setState(() {
      isOtpVerifyingLoading = true;
      showErrorMessage = null;
    });
    Map<String, dynamic> data = {
      'phone': mobileNumberController.value.text,
      'otp': otpController.value.text,
    };
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post(
          'https://flutter.magadh.co/api/v1/users/login-verify',
          data: formData);
      otpVerified = OtpVerified.fromJson(response.data);
      setState(() {
        isOtpVerifyingLoading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  UserInfoScreen(otpVerified: otpVerified!,)
          )
      );
    } catch (e) {
      DioException temp = e as DioException;
      setState(() {
        isOtpVerifyingLoading = false;
        showErrorMessage = temp.response?.statusMessage;
      });
    }
  }
}
