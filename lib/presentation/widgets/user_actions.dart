import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/user-bloc/user_bloc.dart';

class UserActions extends StatelessWidget {
  const UserActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) {
        return [const PopupMenuItem<int>(value: 0,child: Text("Logout"))];
      },
      onSelected: (item){
        switch(item){
          case 0:
            // Logout
            BlocProvider.of<UserBloc>(context).add(SignOut());
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 35,
          height: 35,
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return CircleAvatar(
                radius: 30,
                backgroundImage: (userState is UserAuthenticatedState &&
                        userState.photoURL != null)
                    ? NetworkImage(userState.photoURL!)
                    : null,
                backgroundColor: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}
