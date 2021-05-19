import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextEditingController _nameControler = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String name;

  Future<void> _showAlerDiolog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Name'),
            content: TextField(
              controller: _nameControler,
              onChanged: (value) {
                name = value;
              },
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('UPDATE'),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _nameControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.face,
                            size: 50,
                          ),
                          title: Text(document.data()['name'] ?? ''),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showAlerDiolog(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(document.data()['phone'] ?? ' '),
                      trailing: Icon(Icons.edit),
                    )
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}
