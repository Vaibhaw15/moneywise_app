



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moneywise/models/categoryModel.dart';
import 'package:moneywise/models/transactionModel.dart';
import 'package:moneywise/screens/history/bloc/history_screen_bloc.dart';
import 'package:moneywise/screens/history/event/history_screen_event.dart';
import 'package:moneywise/screens/history/state/history_screen_state.dart';
import 'package:moneywise/util/addEditDataWraper.dart';
import '../../../util/screen/transaction_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const BackButton(color: Colors.white),
          title: const Text('History', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HistoryError) {
                return Center(
                  child: Text(state.message, style: const TextStyle(color: Colors.red)),
                );
              } else if (state is HistoryLoaded) {
                final income = state.income;
                final expenses = state.expenses;
                final transactions = state.transactions;
                final List<CategoryModel> categories = state.category;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Summary',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildSummaryCard('Income', '₹${income.toStringAsFixed(2)}'),
                        const SizedBox(width: 16),
                        _buildSummaryCard('Expenses', '₹${expenses.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Transactions',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          final isExpense = tx.categoryTypeName == 'Expenses';
                          final transaction = TransactionModel(
                            id: tx.id,
                            userId: tx.userId,
                            txnAmount: tx.transactionAmount,
                            txnCategoryId: tx.transactionCategoryId,
                            txnDate: tx.transactionDate,
                            txnMessage: tx.transactionMessage,
                            txnDateInt: tx.transactionDateInt,
                            isModify: tx.isModify,
                            modifyCount: tx.transactionModificationCount
                          );

                          return GestureDetector(
                            onTap: () {
                              final matchedCategory = categories.firstWhere(
                                    (element) => element.categoryName == tx.categoryName,
                                orElse: () => CategoryModel(), // fallback if not found
                              );

                              context.push(
                                '/addEditScreen',
                                extra: AddEditScreenArgs(
                                  transaction: transaction,
                                  category: matchedCategory,
                                  isExpense: isExpense,
                                ),
                              );
                            },
                            child: TransactionTile(
                              icon: Icons.currency_rupee_outlined,
                              title: tx.categoryName ?? 'Unknown',
                              subtitle: tx.transactionMessage ?? '',
                              amount:
                              "${isExpense ? '-' : '+'}₹${tx.transactionAmount?.toStringAsFixed(2) ?? '0.00'}",
                              isExpense: isExpense,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink(); // Default state
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/addEditScreen'); // Blank for new transaction
          },
          backgroundColor: Colors.greenAccent[400],
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}


