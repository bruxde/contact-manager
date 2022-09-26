import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({super.key});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final int contactID = 5631671361601536;
  
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(EditContact(contact: ContactEntity(id: contactID, firstname: '', lastname: '', birthday: DateTime.now(), number: '') ));
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Contact"),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactInitial || state is ContactIsEdited) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      errorText: 'Required Field'),
                  // onChanged: () {},
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                      errorText: 'Required Field'),
                  // onChanged: (newText) {
                  //   updateLastName(newText);
                  // },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: 'Number +XXX',
                      border: OutlineInputBorder(),
                      errorText: 'Required Field'),
                  // onChanged: (newNumber) {
                  //   updateNumber(newNumber);
                  // },
                ),
                const SizedBox(
                  height: 25,
                ),
                DateTimePicker(
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  dateLabelText: 'Date',
                  // onChanged: (val) {
                  //   final dateTime = DateTime.parse(val);
                  //   if (birthday != dateTime.millisecondsSinceEpoch) {
                  //     setState(() {
                  //       birthday = dateTime.millisecondsSinceEpoch;
                  //     });
                  //     print(birthday);
                  //   }
                  // },
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
                  onPressed: () {},
                  label: const Text('Edit contact'),
                  icon: const Icon(Icons.edit),
                  // firstName.isNotEmpty &&
                  //         lastName.isNotEmpty &&
                  //         number.isNotEmpty &&
                  //         birthday > 0
                  //     ? () {
                  //         BlocProvider.of<ContactBloc>(context).add(
                  //             AddNewContact(
                  //                 newContact: ContactEntity(
                  //                     firstname: firstName,
                  //                     lastname: lastName,
                  //                     birthday:
                  //                         DateTime.fromMillisecondsSinceEpoch(
                  //                             birthday),
                  //                     number: number,
                  //                     id: null)));
                  //       }
                  //     : null,
                  // icon: const Icon(Icons.save),
                  // label: const Text(
                  //   'Save',
                  // ),
                ),
              ],
            );
          } else if (state is FailureContactState) {
            return const Center(
              child: Text("Some error"),
            );
          }

          return const CircularProgressIndicator();
        },
      ));
}
