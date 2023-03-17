import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_api/pro/api/api_response.dart';
import 'package:training_api/pro/api/controllers/users_api_controller.dart';
import 'package:training_api/pro/models/user.dart';

import '../../api/controllers/auth_api_controller.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserApiController().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Image.asset(
                "images/api.png",
                height: 150,
                width: 200,
              )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '''Developed By :
Mohammed Badawe &
Mohammed Salem''',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 1,
                thickness: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(Icons.person),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                thickness: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                thickness: 3,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await _logoutPerform();
                    },
                    icon: const Icon(Icons.logout_outlined),
                  ),
                  InkWell(
                      onTap: () async {
                        await _logoutPerform();
                      },
                      child: const Text(
                        "LOGOUT",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              const Divider(
                height: 1,
                thickness: 3,
              ),
            ]),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("User Data"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/images_screen');
                },
                icon: const Icon(Icons.image)),
          ],
        ),
        body: FutureBuilder<List<User>>(
            future: UserApiController().getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage("${snapshot.data![index].image}"),
                          ),
                          title: Text("${snapshot.data![index].firstName}"
                              "${snapshot.data![index].lastName}"),
                          subtitle: Text("${snapshot.data![index].email}"),
                        );
                      });
                }
              }
            }),
      ),
    );
  }

  Future get_Users() async {
    await UserApiController().getUsers();
  }

  Future<void> _logoutPerform() async {
    ApiResponse apiResponse = await AuthApiController().logout();
    if (apiResponse.success) {
      Get.offNamed('/login_screen');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "${apiResponse.message}",
        ),
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
