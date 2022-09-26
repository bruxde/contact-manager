import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl == service locator

Future<void> init() async {
  //! application layer
  sl.registerLazySingleton(() => ContactBloc());
}
