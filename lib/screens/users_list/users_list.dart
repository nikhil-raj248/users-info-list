import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:users_app/screens/users_list/users_list_info.dart';

import '../../models/users_list.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  UsersListData? usersListData;
  bool isUsersListDataLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUsersList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          title: const Text("UsersList"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 40,),
            if (isUsersListDataLoading)
              const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              )),
            if (usersListData != null)
              Expanded(
                child: ListView.builder(
                  itemCount: usersListData!.users!.length,
                  itemBuilder: (ctx, idx) {
                    return Container(
                      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(72, 163, 237, 0.3), //New
                              spreadRadius: 0.1,
                              blurRadius: 1,
                              offset: Offset(1, 2))
                        ],
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(usersListData!.users![idx].name!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>  UsersListInfo(users: usersListData!.users![idx],)
                                    )
                                );
                              },
                                child: const Icon(Icons.arrow_forward)
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void getUsersList() async {
    setState(() {
      isUsersListDataLoading = true;
    });
    var dio = Dio();
    var token = widget.token;
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      var response = await dio.get('https://flutter.magadh.co/api/v1/users');
      usersListData = UsersListData.fromJson(response.data);
      setState(() {
        isUsersListDataLoading = false;
      });
    } catch (e) {
      setState(() {
        isUsersListDataLoading = false;
      });
      print(e);
    }
  }
}
