import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/presentation/contact-list-page/contact_list_page.dart';
import 'package:contactmanager/utils/user-utils.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  String firstName = "";
  String lastName = "";
  String number = "";
  int birthday = 0;

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
        title: const Text('Add Contact'),
        centerTitle: true,
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is NewContactIsCreated) {
            BlocProvider.of<ContactBloc>(context).add(
                ObserveContacts(userId: UserUtils.getCurrentUserId(context)));
            AutoRouter.of(context).pop();
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactInitial || state is AllContactsState) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Create',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  // const SizedBox(height: 25),
                  // ElevatedButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.add_box),
                  //   label: const Text(
                  //     'Add Photo',
                  //   ),
                  // ),
                  const SizedBox(height: 25),
                  TextFormField(
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
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2024),
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
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
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
                                AddNewContactToFirestore(
                                    userId: UserUtils.getCurrentUserId(context),
                                    newContact: ContactEntity(
                                        firstname: firstName,
                                        lastname: lastName,
                                        birthday:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                birthday),
                                        number: number,
                                        state: "initial",
                                        id: null)));
                          }
                        : null,
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Save',
                    ),
                  ),
                ],
              );
            } else if (state is FailureContactState) {
              return const Center(
                child: Text("Some error"),
              );
            }

            return const ContactListPage();
          },
        ),
      ));
}
