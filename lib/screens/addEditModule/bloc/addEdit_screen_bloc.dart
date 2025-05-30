

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneywise/models/transactionModel.dart';
import 'package:moneywise/networking/categoryApi.dart';
import 'package:moneywise/screens/addEditModule/state/addEdit_screen_state.dart';
import '../../../models/categoryModel.dart';
import '../../../networking/addEditApi.dart';
import '../event/addEdit_screen_event.dart';

class AddEditBloc extends Bloc<AddEditEvent, AddEditState>{
    final CategoryApi categoryApi;

    AddEditBloc(this.categoryApi): super(AddEditInitial()){
      on<AddEditEventLoadCategories>(_onCategoryLoad);
      on<AddEditSaveTransactionEvent>(_onSaveTransaction);
    }

    Future<void> _onCategoryLoad(
        AddEditEventLoadCategories event,
        Emitter<AddEditState> emit,
        )async{
       emit(AddEditLoading());

       try{
         final categoriesList = await categoryApi.getCategory();
         final List<CategoryModel> categories = categoriesList;

         final List<CategoryModel> incomeCategories = categories
             .where((category) => category.categoryTypeId == 1)
             .toList();

         final List<CategoryModel> expenseCategories = categories
             .where((category) => category.categoryTypeId == 2)
             .toList();

         if(categories.isNotEmpty){
           emit(AddEditLoaded(
             incomeCategories: incomeCategories,
             expenseCategories: expenseCategories,
           ));
         } else {
           emit(AddEditError('No categories found.'));
         }
       }catch (e) {
         emit(AddEditError('Failed to load categories: $e'));
       }
    }

    Future<void> _onSaveTransaction(
        AddEditSaveTransactionEvent event,
        Emitter<AddEditState> emit,
        ) async {
      emit(AddEditLoading());

      try {
        // Save logic here — example:
        await AddEditApi().saveTransaction(event.transaction);

        emit(AddEditSaved(message: 'Transaction saved successfully!'));
      } catch (e) {
        emit(AddEditError("Failed to save transaction: $e"));
      }
    }
}