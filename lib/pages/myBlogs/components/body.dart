import 'package:blogs_area/pages/LoginPage/components/user_detail.dart';
import 'package:blogs_area/pages/homePage/components/post_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance
      .collection('blogs')
      .where('userid', isEqualTo: UserDetails.getUserID())
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _postStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data()! as Map;
            String documentID = document.id;
            return PostTile(
              data: data,
              documentID: documentID,
              isEditDeleteVisible: true,
            );
          }).toList(),
        );
      },
    );
  }
}
