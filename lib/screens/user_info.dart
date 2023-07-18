import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:users_app/screens/image_update/update_image.dart';
import 'package:users_app/screens/users_list/users_list.dart';

import '../models/otp_verified.dart';


class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key,
  required this.otpVerified}) : super(key: key);

  final OtpVerified otpVerified;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  OtpVerified? otpVerified;

  @override
  void initState() {
    super.initState();
    otpVerified = widget.otpVerified;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          title: const Text("UserInfo"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle
                  ),
                  alignment: Alignment.center,
                  height: 200,
                  clipBehavior: Clip.hardEdge,
                  child: (otpVerified!.user!.image != null && otpVerified!.user!.image!.isNotEmpty) ?
                  Image.network(
                    'https://flutter.magadh.co/${otpVerified!.user!.image}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: const Text(
                          'Whoops!',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ) :
                  const Text(
                    'Image Not Available',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                ),
                ),
              const SizedBox(height: 40,),
              Text(
                'Name - ${otpVerified!.user!.name!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Phone - ${otpVerified!.user?.phone}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Email - ${otpVerified!.user?.email!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Created At - ${otpVerified!.user?.createdAt!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Updated At - ${otpVerified!.user?.updatedAt!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              if(otpVerified!.user?.location != null)
                Text(
                'Latitude - ${otpVerified!.user?.location!.latitude!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              if(otpVerified!.user?.location != null)
                Text(
                'Longitude - ${otpVerified!.user?.location!.longitude!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 60,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>   UpdateImage(token: otpVerified!.token!,)
                      )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'Update Image and Location',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  UsersList(token: otpVerified!.token! ,)
                      )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'View Users List',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
