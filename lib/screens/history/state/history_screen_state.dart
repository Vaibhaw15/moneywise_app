import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

// Event to load transactions
class LoadTransactionHistory extends HistoryEvent {}

// Optional: Event when a transaction tile is tapped
class TransactionTapped extends HistoryEvent {
  final String transactionId;

  const TransactionTapped(this.transactionId);

  @override
  List<Object> get props => [transactionId];
}
