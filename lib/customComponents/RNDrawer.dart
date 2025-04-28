import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routi_n/enumsAndConstants/enums.dart';

class Rndrawer extends Drawer {
  Rndrawer({super.key, Function()? crossButton, Function()? logoutButton})
    : super(
        elevation: 20,
        child: userProfileDetails(
          crossButton: crossButton,
          logoutButton: logoutButton,
        ),
      );

  static Widget userProfileDetails({
    Function()? crossButton,
    Function()? logoutButton,
  }) {
    final firebaseAuthInstance = FirebaseAuth.instance;
    return Builder(
      builder:
          (context) => Column(
            spacing: 10,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8),

                    color: Colors.red,
                    child: Row(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              backgroundImage:
                                  firebaseAuthInstance.currentUser?.photoURL !=
                                          null
                                      ? NetworkImage(
                                        firebaseAuthInstance
                                            .currentUser!
                                            .photoURL!,
                                      )
                                      : null,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              firebaseAuthInstance.currentUser?.email ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      splashColor: Colors.transparent,

                      onPressed: crossButton,
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: DrawerButtonItems.values.length,
                  padding: EdgeInsets.all(10),

                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(DrawerButtonItems.values[index].icon),
                          label: Text(DrawerButtonItems.values[index].name),
                        ),
                      ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    onPressed: logoutButton,
                    label: Text('Logout'),
                    icon: Icon(Icons.logout),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  spacing: 2,
                  children: [
                    Text(
                      '© 2023 YourAppName',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    Text(
                      'Version 1.0.0',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
