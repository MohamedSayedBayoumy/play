// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../data/models/register_model.dart';

abstract class RegisterBlocEvent {}

class RegisterByAuthenticationEvent extends RegisterBlocEvent {}

class RegisterByFirebaseDataBaseEvent extends RegisterBlocEvent {
  RegisterModel? model;
  RegisterByFirebaseDataBaseEvent({
    this.model,
  });
}

class RegisterByTwitterEvent extends RegisterBlocEvent {}


class RegisterByGoogleEvent extends RegisterBlocEvent {}

