import 'package:flutter/material.dart';

import '../../../util/screen/transaction_tile.dart';



class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildSummaryCard('Income', '\$2,500'),
                const SizedBox(width: 16),
                _buildSummaryCard('Expenses', '\$1,200'),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Transactions',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  TransactionTile(
                    icon: Icons.shopping_cart,
                    title: 'Supermarket',
                    subtitle: 'Grocery',
                    amount: '-\$50.00',
                    isExpense: true,
                  ),
                  TransactionTile(
                    icon: Icons.work,
                    title: 'Tech Corp',
                    subtitle: 'Salary',
                    amount: '+\$2,000.00',
                    isExpense: false,
                  ),
                  TransactionTile(
                    icon: Icons.restaurant,
                    title: 'Restaurant',
                    subtitle: 'Dinner',
                    amount: '-\$75.00',
                    isExpense: true,
                  ), ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.greenAccent[400],
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String amount) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 8),
            Text(amount,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}