import 'package:flutter/material.dart';

class ListRoster extends StatefulWidget {
  const ListRoster({ Key? key }) : super(key: key);

  @override
  State<ListRoster> createState() => _ListRosterState();
}

class _ListRosterState extends State<ListRoster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
         elevation: 0,
         leading: InkWell(
         splashColor: const Color(0xff000000),
         child: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff000000),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      ),
      title: const Text(
        "List Roster",
        style: TextStyle(color: Colors.black),
      ),
      ),
    );
  }
}