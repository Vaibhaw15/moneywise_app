import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moneywise/util/component/button.dart';

import '../../../util/component/textfield.dart';



class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddEditScreen> {
  bool isExpense = true;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String? selectedCategory;
  final List<String> categories = ['Food', 'Travel', 'Shopping', 'Salary', 'Health'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              context.pop(context); // This will pop the screen
            },
          ),
          centerTitle: true,
          title: const Text(
            "Add Transaction",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(labelText: 'Amount', controller: amountController,),
              const SizedBox(height: 16),

              // Toggle Buttons
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2E3829),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _buildToggleButton("Expense", isExpense, () {
                      setState(() {
                        isExpense = true;
                      });
                    }),
                    _buildToggleButton("Income", !isExpense, () {
                      setState(() {
                        isExpense = false;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
             Container(
               decoration: BoxDecoration(
                 color: Color(0xFF2E3829),
                 borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,top: 4,bottom: 4,right: 16),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Color(0xFF2E3829),
                  value: selectedCategory,
                  hint: const Text('Category', style: TextStyle(color: Colors.white70)),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ),
            ),
              const SizedBox(height: 16),
              CustomTextField(labelText: 'Date', controller: dateController,),
              const SizedBox(height: 16),
              CustomTextField(maxLines: 5, labelText: 'Notes(Optional)', controller: messageController,),
              const Spacer(),
              CustomButton(text: "Save", color: Color(0xFF54D12B), onPressed: (){}),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildToggleButton(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: selected ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}




