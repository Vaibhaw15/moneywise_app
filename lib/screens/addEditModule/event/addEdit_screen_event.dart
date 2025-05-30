

import 'package:equatable/equatable.dart';
import 'package:moneywise/models/transactionModel.dart';

abstract class AddEditEvent extends Equatable {
  const AddEditEvent();

  @override
  List<Object> get props => [];
}

class AddEditEventLoadCategories extends AddEditEvent {}

class AddEditSaveTransactionEvent extends AddEditEvent {
final TransactionModel transaction;
  const AddEditSaveTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}