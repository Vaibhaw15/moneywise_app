import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/transactionModel.dart';
import '../../../packages/SharedPreferenceService.dart';
import '../../../util/screen/transaction_tile.dart';



class LandingScreen extends StatelessWidget {
   LandingScreen({super.key});
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key:_scaffoldKey,
          backgroundColor: Colors.black,
          drawer: Drawer(
              surfaceTintColor:Colors.black,
            backgroundColor: Colors.black,
            child: Column(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title:  Text(
                    'Logout',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                  onTap: () {
                    SharedPreferenceService.clear();
                    // Add your logout logic here
                    context.go('/loginSignup');
                    Navigator.pop(context); // Close drawer
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
              context.push('/addEditScreen',extra: TransactionModel());
            },
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Overview',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Current Balance',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'This Month',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                                '\$2,500.00',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                              Text('Expenses',
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Text(
                                '₹1,200.00',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Net Balance
                  const Text(
                    'Income & Expenses',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\₹1,300',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'This Month +10%',
                    style: TextStyle(color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  // Chart (fake placeholder)
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white.withOpacity(0.05),
                                  Colors.white.withOpacity(0.01),
                                ],
                              ),
                            ),
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              primaryYAxis: NumericAxis(
                                axisLine: const AxisLine(width: 0),
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              plotAreaBorderWidth: 0,
                              series: <CartesianSeries>[
                                // Line series with smooth curve
                                LineSeries<_ChartData, String>(
                                  dataSource: [
                                    _ChartData('Jan', 60),
                                    _ChartData('Feb', 40),
                                    _ChartData('Mar', 50),
                                    _ChartData('Apr', 30),
                                    _ChartData('May', 60),
                                  ],
                                  xValueMapper: (_ChartData data, _) => data.month,
                                  yValueMapper: (_ChartData data, _) => data.value,
                                  color: Colors.white.withOpacity(0.6),
                                  width: 3,
                                  markerSettings: const MarkerSettings(isVisible: true, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // Recent Transactions
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Recent Transactions',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.push('/historyScreen');
                                    },
                                    child: const Text(
                                      'See All Transactions',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: ListView(
                                  children: const [
                                    TransactionTile(
                                      icon: Icons.shopping_cart,
                                      title: 'Supermarket',
                                      subtitle: 'Grocery',
                                      amount: '-₹50.00',
                                      isExpense: true,
                                    ),
                                    TransactionTile(
                                      icon: Icons.work,
                                      title: 'Tech Corp',
                                      subtitle: 'Salary',
                                      amount: '+₹2,000.00',
                                      isExpense: false,
                                    ),
                                    TransactionTile(
                                      icon: Icons.restaurant,
                                      title: 'Restaurant',
                                      subtitle: 'Dinner',
                                      amount: '-₹75.00',
                                      isExpense: true,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class _ChartData {
  final String month;
  final double value;

  _ChartData(this.month, this.value);
}