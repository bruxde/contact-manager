import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/domain/usecases/contact_useceses.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../domain/enitites/contact_entity.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactUsecases contactUsecases;

  StreamSubscription<Either<Failure, List<ContactEntity>>>? _streamSubscription;

  ContactBloc({required this.contactUsecases}) : super(ContactInitial()) {
    on<GetAllContacts>((event, emit) async {
      emit(LoadingContactsState());
      // await Future.delayed(const Duration(milliseconds: 1000));
      final failureOrList = await contactUsecases.getContactList();
      await failureOrList.fold((failure) async {
        emit(FailureContactState(failure: failure));
      }, (list) async {
        emit(AllContactsState(contacts: list));
      });
    });

    on<AddNewContact>((event, emit) async {
      emit(LoadingContactsState());
      final failureOrNewContact =
          await contactUsecases.addNewContact(event.newContact);
      await failureOrNewContact.fold((failure) async {
        emit(FailureContactState(failure: failure));
      }, (contact) async {
        // TODO: show the state with created new contact
      });
    });

    on<AddNewContactToFirestore>((event, emit) async {
      emit(LoadingContactsState());
      final failureOrNewContact = await contactUsecases
          .addNewContactToFirestore(event.userId, event.newContact);
      await failureOrNewContact.fold((failure) async {
        emit(FailureContactState(failure: failure));
      }, (contact) async {
        emit(NewContactIsCreated(contactEntity: contact));
      });
    });

    on<EditContact>((event, emit) async {
      emit(LoadingContactsState());
      final failureOrEditContact =
          await contactUsecases.editContact(event.contact);
      await failureOrEditContact.fold((failure) async {
        emit(FailureContactState(failure: failure));
      }, (contact) async {
        emit(ContactEdited());
      });
    });

    on<DeleteContact>((event, emit) async {
      emit(LoadingContactsState());
      final failureOrEditContact =
          await contactUsecases.deleteContact(event.contact);
      await failureOrEditContact.fold((failure) async {
        emit(FailureContactState(failure: failure));
      }, (contact) async {
        emit(ContactDeleted());
      });
    });

    on<ObserveContacts>((event, emit) async {
      emit(LoadingContactsState());
      _streamSubscription?.cancel();

      print("get user contacts of user: " + event.userId);
      _streamSubscription = contactUsecases
          .observeContacts(event.userId)
          .listen((failureOrContacts) {
        failureOrContacts.fold((failure) {
          add(ObservationFailureEvent(failure: failure));
        }, (contacts) {
          add(ObservationContactListEvent(contacts: contacts));
        });
      });
    });

    on<ObservationFailureEvent>((event, emit) {
      emit(FailureContactState(failure: event.failure));
    });

    on<ObservationContactListEvent>((event, emit) {
      emit(AllContactsState(
        contacts: event.contacts,
      ));
    });
  }
}
