import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moneywise/models/transactionModel.dart';
import 'package:moneywise/screens/addEditModule/event/addEdit_screen_event.dart';
import 'package:moneywise/util/component/button.dart';

import '../../../models/categoryModel.dart';
import '../../../packages/SharedPreferenceService.dart';
import '../../../util/component/textfield.dart';
import '../bloc/addEdit_screen_bloc.dart';
import '../state/addEdit_screen_state.dart';



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
  CategoryModel? selectedCategory;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditBloc, AddEditState>(
      listener: (context, state) {
        if (state is AddEditSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop();
        } else if (state is AddEditError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        List<CategoryModel> shownCategories = [];

        if (state is AddEditLoaded) {
          shownCategories =
          isExpense ? state.expenseCategories : state.incomeCategories;
        }

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  context.pop();
                },
              ),
              centerTitle: true,
              title: const Text("Add Transaction", style: TextStyle(color: Colors.white)),
            ),
            body: state is AddEditLoading
                ? const Center(child: CircularProgressIndicator())
                : state is AddEditError
                ? Center(child: Text(state.message, style: const TextStyle(color: Colors.red)))
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(labelText: 'Amount', controller: amountController),
                  const SizedBox(height: 16),
                  _buildToggleButtons(),
                  const SizedBox(height: 16),
                  _buildCategoryDropdown(shownCategories),
                  const SizedBox(height: 16),
                  CustomTextField(labelText: 'Date', controller: dateController),
                  const SizedBox(height: 16),
                  CustomTextField(
                      maxLines: 5,
                      labelText: 'Notes(Optional)',
                      controller: messageController),
                  const Spacer(),
                  CustomButton(
                      text: "Save",
                      color: const Color(0xFF54D12B),
                      onPressed: () {
                        _saveTransaction();
                      }),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E3829),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildToggleButton("Expense", isExpense, () {
            setState(() {
              isExpense = true;
              selectedCategory = null;
            });
          }),
          _buildToggleButton("Income", !isExpense, () {
            setState(() {
              isExpense = false;
              selectedCategory = null;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF54D12B) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(List<CategoryModel> categoryList) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E3829),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: DropdownButtonFormField<int>(
          dropdownColor: const Color(0xFF2E3829),
          value: selectedCategory?.id,
          hint: const Text('Category', style: TextStyle(color: Colors.white70)),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(border: InputBorder.none),
          items: categoryList.map((cat) {
            return DropdownMenuItem<int>(
              value: cat.id,
              child: Text(cat.categoryName ?? ''),
            );
          }).toList(),
          onChanged: (selectedId) {
            setState(() {
              selectedCategory =
                  categoryList.firstWhere((cat) => cat.id == selectedId);
            });
          },
        ),
      ),
    );
  }


  void _saveTransaction() {
    final amount = double.tryParse(amountController.text);
    final date = dateController.text;
    final note = messageController.text;
    final category = selectedCategory;

    if (amount == null || category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    context.read<AddEditBloc>().add(
      AddEditSaveTransactionEvent(TransactionModel.withoutId(
        userId: int.parse(SharedPreferenceService.getString("userId")!),
        txnAmount: int.parse(amount.toStringAsFixed(2).replaceAll('.', '')),
        txnCategoryId: category.id,
        txnDate: _getCurrentDateFormatted1(),
        txnMessage: note,
        txnDateInt: int.parse(_getCurrentDateFormatted()),
        isModify: 0,
        modifyCount: 0,
      )
      ),
    );
  }

  String _getCurrentDateFormatted() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd');
    return formatter.format(now); // → "20250529"
  }

  String _getCurrentDateFormatted1() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}