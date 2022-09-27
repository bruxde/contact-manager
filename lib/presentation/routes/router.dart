import 'package:auto_route/annotations.dart';
import 'package:contactmanager/presentation/add-contact-page/add_contact_page.dart';
import 'package:contactmanager/presentation/contact-list-page/contact_list_page.dart';
import 'package:contactmanager/presentation/edit-contact-page/edit_contact_page.dart';
import 'package:contactmanager/presentation/login-page/login_page.dart';
import 'package:contactmanager/presentation/splash-page/splash-page.dart';

// Script to generate : flutter packages pub run build_runner build --delete-conflicting-outputs

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: "/spash", page: SplashPage, initial: true),
  AutoRoute(path: "/list", page: ContactListPage),
  AutoRoute(path: "/add", page: AddContactPage),
  AutoRoute(path: "/edit", page: EditContactPage),
  AutoRoute(path: "/login", page: LoginPage),
])
class $AppRouter {}
