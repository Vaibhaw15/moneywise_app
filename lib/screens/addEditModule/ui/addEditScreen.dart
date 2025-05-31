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
  final TransactionModel? transaction;
  final CategoryModel? category;
  final bool isExpense;
  const AddEditScreen({super.key, this.transaction, this.category, required this.isExpense});

  @override
  State<AddEditScreen> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddEditScreen> {
  bool isExpense = true;
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  CategoryModel? selectedCategory;
  int? dateInt;



  @override
  void initState() {
    super.initState();
    if (widget.transaction != null && widget.category != null) {
      final txn = widget.transaction!;
      isExpense = widget.isExpense;
      amountController.text = (txn.txnAmount ?? 0.0).toStringAsFixed(0);
      dateController.text = txn.txnDate ??"";
      messageController.text = txn.txnMessage ?? '';
      selectedCategory = widget.category;
      dateInt = txn.txnDateInt;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditBloc, AddEditState>(
      listener: (context, state) {
        if (state is AddEditSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.go('/landing');
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
                onPressed: () => context.pop(),
              ),
              centerTitle: true,
              title: Text(
                widget.transaction == null ? 'Add Transaction' : 'Edit Transaction',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: state is AddEditLoading
                ? const Center(child: CircularProgressIndicator())
                : state is AddEditError
                ? Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            )
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                      labelText: 'Amount',
                      controller: amountController),
                  const SizedBox(height: 16),
                  _buildToggleButtons(),
                  const SizedBox(height: 16),
                  _buildCategoryDropdown(shownCategories),
                  const SizedBox(height: 16),
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Date",
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF2E3829),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF54D12B)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                      maxLines: 5,
                      labelText: 'Notes(Optional)',
                      controller: messageController),
                  const Spacer(),
                  CustomButton(
                    text: widget.transaction == null ? "Save" : "Update",
                    color: const Color(0xFF54D12B),
                    onPressed: _saveTransaction,
                  ),
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
          value: categoryList.any((cat) => cat.id == selectedCategory?.id)
              ? selectedCategory?.id
              : null,
          hint:
          const Text('Category', style: TextStyle(color: Colors.white70)),
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

    final isEdit = widget.transaction != null;

    final txnModel = TransactionModel(
      id: widget.transaction?.id,
      userId: int.parse(SharedPreferenceService.getString("userId")!),
      txnAmount: amount.toInt(),
      txnCategoryId: category.id,
      txnDate: dateController.text,
      txnMessage: note,
      txnDateInt: dateInt,
      isModify: isEdit ? 1 : 0,
      modifyCount: isEdit ? (widget.transaction?.modifyCount ?? 0) + 1 : 0,
    );

    context.read<AddEditBloc>().add(
      AddEditSaveTransactionEvent(txnModel),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF54D12B), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF54D12B), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.tryParse(dateController.text)) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        dateInt = int.parse(DateFormat('yyyyMMdd').format(picked));
      });
    }
  }
}




