import 'package:blogs_area/pages/LoginPage/login_page.dart';
import 'package:blogs_area/pages/MyProfile/my_profile.dart';
import 'package:blogs_area/pages/PostDetailsPage/post_details.dart';
import 'package:blogs_area/pages/aboutUs/about_us.dart';
import 'package:blogs_area/pages/addPostPage/add_post.dart';
import 'package:blogs_area/pages/homePage/home_page.dart';
import 'package:blogs_area/pages/myBlogs/my_blogs.dart';
import 'package:blogs_area/pages/signupPage/signup.dart';
import 'package:blogs_area/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Blogs Area',
            theme: MyTheme.lightTheme(context),
            initialRoute: LoginPage.loginPageRoute,
            debugShowCheckedModeBanner: false,
            routes: {
              LoginPage.loginPageRoute: (context) => const LoginPage(),
              Signup.signupPageRoute: (context) => const Signup(),
              Home.homePageRoute: (context) => Home(),
              AddPost.addPostRoute: (context) => AddPost(),
              MyProfile.myProfileRoute: (context) => const MyProfile(),
              PostDetails.postDetailsPageRoute: (context) => PostDetails(),
              MyBlogs.myBlogsRoute: (context) => const MyBlogs(),
              AboutUS.aboutUsRoute: (context) => const AboutUS(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}
