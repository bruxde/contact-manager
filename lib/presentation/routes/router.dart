import 'package:auto_route/annotations.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/contact-list-page/contact_list_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: "/list", page: ContactListPage, initial: true),
  AutoRoute(path: "/add", page: AddContactPage, initial: true),
])
class $AppRouter {}
