import 'package:moneywise/models/categoryModel.dart';
import 'package:moneywise/models/transactionModel.dart';

class AddEditScreenArgs {
  final TransactionModel? transaction;
  final CategoryModel? category;

  AddEditScreenArgs({this.transaction, this.category});
}