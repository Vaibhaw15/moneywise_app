import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/transactionModel.dart';
import '../../../packages/SharedPreferenceService.dart';
import '../../../util/screen/transaction_tile.dart';



import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:go_router/go_router.dart';


class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<ChartData> chartData = [
    ChartData('Week 1', 1000, 400),
    ChartData('Week 2', 1200, 700),
    ChartData('Week 3', 800, 300),
    ChartData('Week 4', 1500, 600),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black,
          drawer: Drawer(
            backgroundColor: Colors.black,
            child: Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Center(
                    child: Text(
                      'HI, ${SharedPreferenceService.getString("userName")!.toUpperCase()} !',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.add_circle_outline_sharp, color: Colors.white),
                  title: const Text('Add New Transaction', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    context.push('/addEditScreen');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.white),
                  title: const Text('History', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    context.push('/historyScreen');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text('Logout', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    SharedPreferenceService.clear();
                    context.go('/loginSignup');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out')),
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF9BE37C),
            child: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              context.push('/addEditScreen');
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Balance
                const Text(
                  '₹12,345.67',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text('Current Balance (Income - Expense)', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 30),

                const Text(
                  'This Month',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 15),

                // Income & Expense Cards
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Income', style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text(
                              '₹2,500.00',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Expenses', style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text(
                              '₹1,200.00',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Income & Expenses', style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        context.push('/historyScreen'); // Or another route for full transaction history
                      },
                      child: const Text(
                        'See All Transactions',
                        style: TextStyle(fontSize:16, color: Colors.blue), // light green color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '₹1,300',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                const Text('This Month +10%', style: TextStyle(color: Colors.green)),
                const SizedBox(height: 20),

                // Graph
                Expanded(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Week')),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Amount (₹)'),
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    legend: Legend(isVisible: true, textStyle: const TextStyle(color: Colors.white)),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    backgroundColor: Colors.transparent,
                    plotAreaBorderWidth: 0,
                    series: [
                      ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.period,
                        yValueMapper: (ChartData data, _) => data.income,
                        name: 'Income',
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.period,
                        yValueMapper: (ChartData data, _) => data.expense,
                        name: 'Expense',
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String period;
  final double income;
  final double expense;

  ChartData(this.period, this.income, this.expense);
}
