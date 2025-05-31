
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moneywise/networking/categoryApi.dart';
import 'package:moneywise/screens/history/event/history_screen_event.dart';
import 'package:moneywise/screens/history/state/history_screen_state.dart';


import '../../../models/historyModel.dart';
import '../../../networking/historyApi.dart';
import '../../../packages/SharedPreferenceService.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryApi repository;
  final CategoryApi categoryRepository;

  HistoryBloc(this.repository,this.categoryRepository) : super(HistoryInitial()) {
    on<LoadTransactionHistory>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
      LoadTransactionHistory event,
      Emitter<HistoryState> emit,
      ) async {
    emit(HistoryLoading());

    try {
      // Get user credentials
      final userId = SharedPreferenceService.getString("userId");
      final token = SharedPreferenceService.getString("token");

      if (userId == null || token == null) {
        emit(HistoryError('User not authenticated.'));
        return;
      }

      // Format date: "20250529"
      final date = getCurrentYearStartAndEndDates();

      // Call API
      final response = await repository.getTransactionHistory(userId: userId,startDate: date[0],endDate: date[1], token: token);
      final categoryResponse = await categoryRepository.getCategory();

      // Convert response to list of HistoryModel
      final List<HistoryModel> transactions = response;


      // Compute income and expenses
      final income = transactions
          .where((tx) => tx.categoryTypeName == 'Income')
          .fold<double>(0.0, (sum, tx) => sum + (tx.transactionAmount ?? 0.0));

      final expenses = transactions
          .where((tx) => tx.categoryTypeName == 'Expenses')
          .fold<double>(0.0, (sum, tx) => sum + (tx.transactionAmount ?? 0.0));

      emit(HistoryLoaded(
        transactions: transactions,
        income: income,
        expenses: expenses,
        category: categoryResponse,
      ));
    } catch (e) {
      emit(HistoryError('No Data Found'));
    }
  }

  List<String> getCurrentYearStartAndEndDates() {
    final now = DateTime.now();
    final currentYear = now.year;

    final startDate = DateTime(currentYear, 1, 1);
    final endDate = DateTime(currentYear, 12, 31);

    String formatDate(DateTime date) {
      final year = date.year.toString();
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');
      return '$year$month$day';
    }

    return [
      formatDate(startDate),
      formatDate(endDate),
    ];
  }

}

