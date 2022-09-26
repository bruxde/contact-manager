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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../add-contact-page/add_contact_page.dart' as _i2;
import '../contact-list-page/contact_list_page.dart' as _i1;
import '../edit-contact-page/edit_contact_page.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ContactListPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ContactListPage(),
      );
    },
    AddContactPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AddContactPage(),
      );
    },
    EditContactPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EditContactPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/list',
          fullMatch: true,
        ),
        _i4.RouteConfig(
          ContactListPageRoute.name,
          path: '/list',
        ),
        _i4.RouteConfig(
          AddContactPageRoute.name,
          path: '/add',
        ),
        _i4.RouteConfig(
          EditContactPageRoute.name,
          path: '/edit',
        ),
      ];
}

/// generated route for
/// [_i1.ContactListPage]
class ContactListPageRoute extends _i4.PageRouteInfo<void> {
  const ContactListPageRoute()
      : super(
          ContactListPageRoute.name,
          path: '/list',
        );

  static const String name = 'ContactListPageRoute';
}

/// generated route for
/// [_i2.AddContactPage]
class AddContactPageRoute extends _i4.PageRouteInfo<void> {
  const AddContactPageRoute()
      : super(
          AddContactPageRoute.name,
          path: '/add',
        );

  static const String name = 'AddContactPageRoute';
}

/// generated route for
/// [_i3.EditContactPage]
class EditContactPageRoute extends _i4.PageRouteInfo<void> {
  const EditContactPageRoute()
      : super(
          EditContactPageRoute.name,
          path: '/edit',
        );

  static const String name = 'EditContactPageRoute';
}
