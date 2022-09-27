import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/user-bloc/user_bloc.dart';

class UserUtils {
  static String getCurrentUserId(BuildContext context) {
    final userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserAuthenticatedState) {
      return userState.userId;
    }
    throw Error();
  }
}
