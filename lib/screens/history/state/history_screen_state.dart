
import '../../../Screens/history/event/history_screen_event.dart';
import '../../../models/historyModel.dart';


class HistoryLoaded extends HistoryState {
  final List<HistoryModel> transactions;
  final double income;
  final double expenses;

  const HistoryLoaded({
    required this.transactions,
    required this.income,
    required this.expenses,
  });

  @override
  List<Object> get props => [transactions, income, expenses];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}