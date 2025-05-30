

import 'package:equatable/equatable.dart';

import '../../../models/categoryModel.dart';

abstract class AddEditState extends Equatable{
  const AddEditState();

  @override
  List<Object> get props => [];
}

class AddEditInitial extends AddEditState{}

class AddEditLoading extends AddEditState{}

class AddEditLoaded extends AddEditState{
  final List<CategoryModel> incomeCategories;
  final List<CategoryModel> expenseCategories;
  const AddEditLoaded({required this.incomeCategories,required this.expenseCategories});


  @override
  List<Object> get props => [incomeCategories,expenseCategories];
}

class AddEditSaved extends AddEditState{
  final String message;
  const AddEditSaved({required this.message});

  @override
  List<Object> get props => [];
}

class AddEditError extends AddEditState{
  final String message;
  const AddEditError(this.message);

  @override
  List<Object> get props => [message];
}