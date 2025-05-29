class HistoryModel {
  int? id;
  int? userId;
  int? transactionAmount;
  int? transactionCategoryId;
  String? transactionMessage;
  String? transactionDate;
  int? transactionDateInt;
  int? isModify;
  int? transactionModificationCount;
  String? categoryType;
  String? categoryName;
  String? categoryTypeName;

  HistoryModel(
      {this.id,
        this.userId,
        this.transactionAmount,
        this.transactionCategoryId,
        this.transactionMessage,
        this.transactionDate,
        this.transactionDateInt,
        this.isModify,
        this.transactionModificationCount,
        this.categoryType,
        this.categoryName,
        this.categoryTypeName});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    transactionAmount = json['transactionAmount'];
    transactionCategoryId = json['transactionCategoryId'];
    transactionMessage = json['transactionMessage'];
    transactionDate = json['transactionDate'];
    transactionDateInt = json['transactionDateInt'];
    isModify = json['isModify'];
    transactionModificationCount = json['transactionModificationCount'];
    categoryType = json['categoryType'];
    categoryName = json['categoryName'];
    categoryTypeName = json['categoryTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['transactionAmount'] = transactionAmount;
    data['transactionCategoryId'] = transactionCategoryId;
    data['transactionMessage'] = transactionMessage;
    data['transactionDate'] = transactionDate;
    data['transactionDateInt'] = transactionDateInt;
    data['isModify'] = isModify;
    data['transactionModificationCount'] = transactionModificationCount;
    data['categoryType'] = categoryType;
    data['categoryName'] = categoryName;
    data['categoryTypeName'] = categoryTypeName;
    return data;
  }
}