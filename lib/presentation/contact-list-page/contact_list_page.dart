import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(GetAllContacts());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contact List'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, contactState) {
          if (contactState is ContactInitial ||
              contactState is LoadingContactsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (contactState is AllContactsState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contactState.contacts
                  .map((contact) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration:
                              const BoxDecoration(color: Colors.blueGrey),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact.id.toString(),
                                textAlign: TextAlign.start,
                              ),
                              Wrap(
                                children: [
                                  Text(contact.firstname),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(contact.lastname)
                                ],
                              ),
                              Text(contact.birthday.toIso8601String())
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          } else if (contactState is FailureContactState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contactState.failure is ServerFailure
                      ? "Server error! Try again!"
                      : "Some failure! Try again!"),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<ContactBloc>(context)
                            .add(GetAllContacts());
                      },
                      child: const Text("RETRY"))
                ],
              ),
            );
          }
          return const Center(child: Text('Unknown state'));
        }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            AutoRouter.of(context).push(const AddContactPageRoute());
          },
        ),
      );
}
