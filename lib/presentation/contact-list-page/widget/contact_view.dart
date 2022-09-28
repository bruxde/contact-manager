import 'package:auto_route/auto_route.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

class ContactView extends StatelessWidget {
  final ContactEntity contact;

  const ContactView({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context)
            .push(EditContactPageRoute(contactEntity: contact));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 218, 218, 218),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            SizedBox(
              height: 55,
              width: 55,
              child: contact.state == "initial"
                  ? const Icon(Icons.new_releases)
                  : contact.state == "approving"
                      ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      )
                      : contact.state == "approved"
                          ? Icon(Icons.qr_code_2)
                          : Container(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: ${contact.id}",
                  textAlign: TextAlign.start,
                ),
                Column(
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text("First Name: ${contact.firstname}"),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Last Name: ${contact.lastname}")
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Birthday: ${contact.birthday.toIso8601String()}"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
