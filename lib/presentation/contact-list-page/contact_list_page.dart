import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
import 'package:contactmanager/presentation/widgets/user_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                BlocProvider.of<ContactBloc>(context).add(GetAllContacts());
              },
              child: BlocListener<ContactBloc, ContactState>(
                listener: (context, state) {
                  _refreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: contactState.contacts
                        .map((contact) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 218, 218, 218),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      title: Text(
                                        contact.firstname +
                                            " " +
                                            contact.lastname,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        contact.id.toString() +
                                            "\n" +
                                            contact.birthday.toIso8601String(),
                                        textAlign: TextAlign.start,
                                      ),
                                      trailing: Container(
                                        width: 70,
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () {
                                                      AutoRouter.of(context).push(
                                                          EditContactPageRoute(
                                                              contactEntity:
                                                                  contact));
                                                    },
                                                    icon: Icon(Icons.edit))),
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  ContactBloc>(
                                                              context)
                                                          .add(DeleteContact(
                                                              oldcontact: ContactEntity(
                                                                  firstname: contact
                                                                      .firstname,
                                                                  lastname: contact
                                                                      .lastname,
                                                                  birthday: contact
                                                                      .birthday,
                                                                  id: contact
                                                                      .id,
                                                                  number: contact
                                                                      .number)));
                                                    },
                                                    icon: Icon(Icons.delete))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
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
