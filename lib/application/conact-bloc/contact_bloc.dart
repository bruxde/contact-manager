import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/domain/usecases/contact_useceses.dart';
import 'package:meta/meta.dart';

import '../../domain/enitites/contact_entity.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactUsecases contactUsecases;

  ContactBloc({required this.contactUsecases}) : super(ContactInitial()) {
    on<GetAllContacts>((event, emit) async {
      emit(LoadingContactsState());
      await Future.delayed(const Duration(milliseconds: 1000));
      final failureOrList = await contactUsecases.getContactList();
      await failureOrList.fold((failure) async {
        emit(FailureContactState(failure: failure));
      }, (list) async {
        emit(AllContactsState(contacts: list));
      });
    });
  }
}
