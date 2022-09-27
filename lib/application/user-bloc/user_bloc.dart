import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logInViaCredentials({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('User connected');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  UserBloc() : super(UserInitial()) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        add(UserIsSignedOut());
      } else {
        print('${user.email} is signed in!');

        add(UserIsSignedIn(
            userId: user.uid,
            name: user.displayName,
            email: user.email,
            photoURL: user.photoURL));
      }
    });

    on<UserIsSignedOut>((event, emit) async {
      emit(UserUnAuthenticatedState());
    });

    on<UserIsSignedIn>((event, emit) async {
      emit(UserAuthenticatedState(
          userId: event.userId,
          name: event.name,
          email: event.email,
          photoURL: event.photoURL));
    });

    on<LoginViaGoogle>((event, emit) async {
      emit(UserLoadingState());
      await signInWithGoogle();
    });

    on<SignOut>((event, emit) async {
      emit(UserLoadingState());
      await FirebaseAuth.instance.signOut();
    });
    on<LoginViaCredential>((event, emit) async {
      emit(UserLoadingState());
      await logInViaCredentials(
          email: event.email.toString(), password: event.password.toString());
    });
  }
}
