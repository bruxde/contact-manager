import 'package:contactmanager/views/addContact.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contact List'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: const Center(child: Text('No Contacts')),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AddContact())));
          },
        ),
      );
}
