import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/application/user-bloc/user_bloc.dart';
import 'package:contactmanager/domain/usecases/contact_useceses.dart';
import 'package:contactmanager/infrastructure/datasources/contact_firestore_datasource.dart';
import 'package:contactmanager/infrastructure/datasources/contact_remote_datasource.dart';
import 'package:contactmanager/infrastructure/repositories/contact_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import 'domain/repositories/contact_repository.dart';

final sl = GetIt.instance; // sl == service locator

Future<void> init() async {
  //! application layer
  sl.registerLazySingleton(() => ContactBloc(contactUsecases: sl()));
  sl.registerLazySingleton(() => UserBloc());

  //! usecases
  sl.registerLazySingleton(() => ContactUsecases(contactRepository: sl()));

  //! repositories
  sl.registerLazySingleton<ContactRepository>(() => ContactRepositoryImpl(
      contactRemoteDatasource: sl(), contactFirestoreDatasource: sl()));

  //! datasources
  sl.registerLazySingleton<ContactRemoteDatasource>(
      () => ContactRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ContactFirestoreDatasource>(
      () => ContactFirestoreDatasourceImpl(firestore: sl()));

  //! extern
  sl.registerLazySingleton<RetryClient>(() => RetryClient(http.Client()));
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
}
