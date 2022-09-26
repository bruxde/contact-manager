import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
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
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        AutoRouter.of(context)
                            .push(const EditContactPageRoute());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: contactState.contacts
                            .map((contact) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 218, 218, 218),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                      ),
                    ),
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
