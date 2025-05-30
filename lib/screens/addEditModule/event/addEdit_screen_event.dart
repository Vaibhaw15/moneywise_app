

import 'package:equatable/equatable.dart';

abstract class AddEditEvent extends Equatable {
  const AddEditEvent();
  @override
  List<Object> get props => [];
}

class AddEditLoadCategoriesEvent extends AddEditEvent {}