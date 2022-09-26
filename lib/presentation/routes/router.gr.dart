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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../add-contact-page/add_contact_page.dart' as _i2;
import '../contact-list-page/contact_list_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ContactListPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ContactListPage(),
      );
    },
    AddContactPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.AddContactPage(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/list',
          fullMatch: true,
        ),
        _i3.RouteConfig(
          ContactListPageRoute.name,
          path: '/list',
        ),
        _i3.RouteConfig(
          AddContactPageRoute.name,
          path: '/add',
        ),
      ];
}

/// generated route for
/// [_i1.ContactListPage]
class ContactListPageRoute extends _i3.PageRouteInfo<void> {
  const ContactListPageRoute()
      : super(
          ContactListPageRoute.name,
          path: '/list',
        );

  static const String name = 'ContactListPageRoute';
}

/// generated route for
/// [_i2.AddContactPage]
class AddContactPageRoute extends _i3.PageRouteInfo<void> {
  const AddContactPageRoute()
      : super(
          AddContactPageRoute.name,
          path: '/add',
        );

  static const String name = 'AddContactPageRoute';
}
