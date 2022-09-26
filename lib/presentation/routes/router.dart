import 'package:auto_route/annotations.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/contact-list-page/contact_list_page.dart';
import 'package:contactmanager/presentation/edit-contact-page/edit_contact_page.dart';

// Script to generate : flutter packages pub run build_runner build --delete-conflicting-outputs

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: "/list", page: ContactListPage, initial: true),
  AutoRoute(path: "/add", page: AddContactPage, initial: true),
  AutoRoute(path: "/edit", page: EditContactPage, initial: true)
])
class $AppRouter {}
