// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../add-contact-page/add_contact_page.dart' as _i3;
import '../contact-list-page/contact_list_page.dart' as _i2;
import '../edit-contact-page/edit_contact_page.dart' as _i4;
import '../login-page/login_page.dart' as _i5;
import '../splash-page/splash-page.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    ContactListPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.ContactListPage(),
      );
    },
    AddContactPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AddContactPage(),
      );
    },
    EditContactPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EditContactPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/spash',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          SplashPageRoute.name,
          path: '/spash',
        ),
        _i6.RouteConfig(
          ContactListPageRoute.name,
          path: '/list',
        ),
        _i6.RouteConfig(
          AddContactPageRoute.name,
          path: '/add',
        ),
        _i6.RouteConfig(
          EditContactPageRoute.name,
          path: '/edit',
        ),
        _i6.RouteConfig(
          LoginPageRoute.name,
          path: '/login',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i6.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/spash',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.ContactListPage]
class ContactListPageRoute extends _i6.PageRouteInfo<void> {
  const ContactListPageRoute()
      : super(
          ContactListPageRoute.name,
          path: '/list',
        );

  static const String name = 'ContactListPageRoute';
}

/// generated route for
/// [_i3.AddContactPage]
class AddContactPageRoute extends _i6.PageRouteInfo<void> {
  const AddContactPageRoute()
      : super(
          AddContactPageRoute.name,
          path: '/add',
        );

  static const String name = 'AddContactPageRoute';
}

/// generated route for
/// [_i4.EditContactPage]
class EditContactPageRoute extends _i6.PageRouteInfo<void> {
  const EditContactPageRoute()
      : super(
          EditContactPageRoute.name,
          path: '/edit',
        );

  static const String name = 'EditContactPageRoute';
}

/// generated route for
/// [_i5.LoginPage]
class LoginPageRoute extends _i6.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login',
        );

  static const String name = 'LoginPageRoute';
}
