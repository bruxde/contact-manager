import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contact List'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, contactState) {
          return const Center(child: Text('No Contacts'));
        }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            AutoRouter.of(context).push(const AddContactPageRoute());
          },
        ),
      );
}
