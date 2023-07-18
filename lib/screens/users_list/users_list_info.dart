import 'package:flutter/material.dart';

import '../../models/users_list.dart';

class UsersListInfo extends StatefulWidget {
  const UsersListInfo({Key? key,required this.users}) : super(key: key);

  final Users users;

  @override
  State<UsersListInfo> createState() => _UsersListInfoState();
}

class _UsersListInfoState extends State<UsersListInfo> {
  Users? users;
  
  @override
  void initState() {
    super.initState();
    users = widget.users;
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
                child: (users!.image != null && users!.image!.isNotEmpty) ?
                Image.network(
                  'https://flutter.magadh.co/${users!.image}',
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
                'Name - ${users!.name!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Phone - ${users?.phone}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Email - ${users?.email!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Created At - ${users?.createdAt!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Updated At - ${users?.updatedAt!}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              if(users?.location != null)
                Text(
                  'Latitude - ${users?.location!.latitude!}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              if(users?.location != null)
                Text(
                  'Longitude - ${users?.location!.longitude!}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),

              const SizedBox(height: 60,),

            ],
          ),
        ),
      ),
    );
  }
}
