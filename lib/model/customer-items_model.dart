class CustomerItemsModel {
  String? pKCODE;
  String? nAME;

  CustomerItemsModel({this.pKCODE, this.nAME});

  CustomerItemsModel.fromJson(Map<String, dynamic> json) {
    pKCODE = json['PKCODE'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PKCODE'] = this.pKCODE;
    data['NAME'] = this.nAME;
    return data;
  }
}
