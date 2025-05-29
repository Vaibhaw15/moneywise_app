class TransactionModel {
  int? id;
  int? userId;
  int? txnAmount;
  int? txnCategoryId;
  String? txnDate;
  String? txnMessage;
  int? txnDateInt;
  int? isModify;
  int? modifyCount;


  TransactionModel({
    this.id,
    this.userId,
    this.txnAmount,
    this.txnCategoryId,
    this.txnDate,
    this.txnMessage,
    this.txnDateInt,
    this.isModify,
    this.modifyCount,
  });

  // Constructor without id
  TransactionModel.withoutId({
    this.userId,
    this.txnAmount,
    this.txnCategoryId,
    this.txnDate,
    this.txnMessage,
    this.txnDateInt,
    this.isModify,
    this.modifyCount,
  });

  // Constructor with id
  TransactionModel.withId({
    required this.id,
    this.userId,
    this.txnAmount,
    this.txnCategoryId,
    this.txnDate,
    this.txnMessage,
    this.txnDateInt,
    this.isModify,
    this.modifyCount,
  });

  // From JSON
  // From JSON factory constructor
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel.withId(
      id: json['id'],
      userId: json['userId'],
      txnAmount: json['txnAmount'],
      txnCategoryId: json['txnCategoryId'],
      txnDate: json['txnDate'],
      txnMessage: json['txnMessage'],
      txnDateInt: json['txnDateInt'],
      isModify: json['isModify'],
      modifyCount: json['modifyCount'],
    );
  }


  // To JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['userId'] = userId;
    data['txnAmount'] = txnAmount;
    data['txnCategoryId'] = txnCategoryId;
    data['txnDate'] = txnDate;
    data['txnMessage'] = txnMessage;
    data['txnDateInt'] = txnDateInt;
    data['isModify'] = isModify;
    data['modifyCount'] = modifyCount;
    return data;
  }
}
