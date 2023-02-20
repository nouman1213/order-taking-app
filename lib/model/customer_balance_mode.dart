class CustomerBalanceModel {
  final String? fkunit;
  final String? pkcode;
  final String? name;
  final double? debit;
  final double? credit;
  final double? balance;

  CustomerBalanceModel({
    required this.fkunit,
    required this.pkcode,
    required this.name,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  factory CustomerBalanceModel.fromJson(Map<String, dynamic> json) {
    return CustomerBalanceModel(
      fkunit: json['FKUNIT'],
      pkcode: json['PKCODE'],
      name: json['NAME'],
      debit: json['DEBIT'],
      credit: json['CREDIT'],
      balance: json['BAL'],
    );
  }
}
