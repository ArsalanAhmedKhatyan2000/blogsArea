import 'package:blogs_area/pages/LoginPage/components/user_detail.dart';
import 'package:blogs_area/pages/LoginPage/login_page.dart';
import 'package:blogs_area/pages/MyProfile/my_profile.dart';
import 'package:blogs_area/pages/aboutUs/about_us.dart';
import 'package:blogs_area/pages/myBlogs/my_blogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String? userName = UserDetails.getName();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text(UserDetails.getName()!),
              accountEmail: Text(UserDetails.getEmail()!),
            ),
          ),
          ListTile(
            title: const Text("Profile"),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyProfile()));
            },
          ),
          ListTile(
            title: const Text("My Blogs"),
            leading: const Icon(Icons.post_add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyBlogs()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Support"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("About Us"),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.pushNamed(context, AboutUS.aboutUsRoute);
            },
          ),
          ListTile(
            title: const Text("Signout"),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
