import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/contact-list-page/widget/contact_view.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
import 'package:contactmanager/presentation/widgets/user_actions.dart';
import 'package:contactmanager/utils/user-utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../application/user-bloc/user_bloc.dart';

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
    BlocProvider.of<ContactBloc>(context).add(ObserveContacts(
        userId: UserUtils.getCurrentUserId(context), lastDocument: null));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contact List'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: const [UserActions()],
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, contactState) {
          if (contactState is ContactInitial ||
              contactState is LoadingContactsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (contactState is AllContactsState) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullUp: contactState.hasMore,
              onLoading: () {
                BlocProvider.of<ContactBloc>(context).add(ObserveContacts(
                    userId: UserUtils.getCurrentUserId(context),
                    lastDocument: contactState.lastDocument));
              },
              onRefresh: () {
                BlocProvider.of<ContactBloc>(context).add(ObserveContacts(
                    userId: UserUtils.getCurrentUserId(context),
                    lastDocument: null));
              },
              child: BlocListener<ContactBloc, ContactState>(
                listener: (context, state) {
                  _refreshController.refreshCompleted();
                  _refreshController.loadComplete();
                },
                child: SingleChildScrollView(
                  child: contactState.contacts.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: contactState.contacts
                              .map((contact) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ContactView(
                                    contact: contact,
                                  )))
                              .toList()
                            ..add(contactState.hasMore
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8),
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: Colors.redAccent),
                                      child: const Center(
                                          child: Text("No more records!")),
                                    ),
                                  )),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text("You don't have any contacts yet")),
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
                        BlocProvider.of<ContactBloc>(context).add(
                            ObserveContacts(
                                userId: UserUtils.getCurrentUserId(context),
                                lastDocument: null));
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
