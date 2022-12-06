import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/user-utils.dart';

class EditContactPage extends StatefulWidget {
  final ContactEntity contactEntity;

  const EditContactPage({super.key, required this.contactEntity});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  String firstName = "";
  String lastName = "";
  String number = "";
  int birthday = 0;
  String id = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      firstName = widget.contactEntity.firstname;
      lastName = widget.contactEntity.lastname;
      number = widget.contactEntity.number;
      birthday = widget.contactEntity.birthday.millisecondsSinceEpoch;
      id = widget.contactEntity.id!;
    });
  }

  Future<void> updateFirstName(newName) async {
    newName = newName.trim();
    if (newName != firstName) {
      setState(() {
        firstName = newName;
      });
    }
  }

  String? get isFirstNameError {
    if (firstName.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  Future<void> updateLastName(newName) async {
    newName = newName.trim();
    if (newName != lastName) {
      setState(() {
        lastName = newName;
      });
    }
  }

  String? get isLastNameError {
    if (lastName.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  Future<void> updateNumber(newNumber) async {
    newNumber = newNumber.trim();
    if (newNumber != number) {
      setState(() {
        number = newNumber;
      });
    }
  }

  String? get isNumberError {
    if (number.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Contact"),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactEdited || state is ContactDeleted) {
            BlocProvider.of<ContactBloc>(context).add(
                ObserveContacts(userId: UserUtils.getCurrentUserId(context), lastDocument: null));
            AutoRouter.of(context).pop();
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is AllContactsState) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    initialValue: firstName,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        errorText: isFirstNameError),
                    onChanged: (newText) {
                      updateFirstName(newText);
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    initialValue: lastName,
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                        errorText: isLastNameError),
                    onChanged: (newText) {
                      updateLastName(newText);
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    initialValue: number,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Number +XXX',
                        border: OutlineInputBorder(),
                        errorText: isNumberError),
                    onChanged: (newNumber) {
                      updateNumber(newNumber);
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DateTimePicker(
                    initialValue: DateTime.fromMillisecondsSinceEpoch(birthday)
                        .toString(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateLabelText: 'Date',
                    onChanged: (val) {
                      final dateTime = DateTime.parse(val);
                      if (birthday != dateTime.millisecondsSinceEpoch) {
                        setState(() {
                          birthday = dateTime.millisecondsSinceEpoch;
                        });
                        print(birthday);
                      }
                    },
                    // validator: (val) {
                    //   print(val);
                    //   return null;
                    // },
                    // onSaved: (val) => print(val),
                  ),
                  // const SizedBox(height: 25),
                  // TextFormField(
                  //   minLines: 5,
                  //   maxLines: 10,
                  //   decoration: const InputDecoration(
                  //       labelText: 'Notes', border: OutlineInputBorder()),
                  // ),
                  const SizedBox(height: 45),
                  ElevatedButton.icon(
                    onPressed: firstName.isNotEmpty &&
                            lastName.isNotEmpty &&
                            number.isNotEmpty &&
                            birthday > 0
                        ? () {
                            BlocProvider.of<ContactBloc>(context).add(
                                EditContactOnFirestore(
                                    contact: ContactEntity(
                                        firstname: firstName,
                                        lastname: lastName,
                                        birthday:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                birthday),
                                        number: number,
                                        state: "initial",
                                        id: id),
                                    userId:
                                        UserUtils.getCurrentUserId(context)));
                          }
                        : null,
                    label: const Text('Edit contact'),
                    icon: const Icon(Icons.edit),
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: Text(
                                      'Are you sure you want to delete contact ${firstName} ${lastName}'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<ContactBloc>(context)
                                              .add(DeleteContact(
                                                  contact: ContactEntity(
                                                      firstname: firstName,
                                                      lastname: lastName,
                                                      birthday: DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              birthday),
                                                      number: number,
                                                      state: widget
                                                          .contactEntity.state,
                                                      id: id)));
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'))
                                  ],
                                ));
                      },
                      child: const Text('Delete Contact',
                          style: TextStyle(color: Colors.red)))
                ],
              );
            } else if (state is FailureContactState) {
              return const Center(
                child: Text("Some error"),
              );
            }

            return Center(
                child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 8,
                ),
                Text(state.runtimeType.toString())
              ],
            ));
          },
        ),
      ));
}
