class GetCustomersModel {
  String? pKCODE;
  String? nAME;
  String? aDRS;

  GetCustomersModel({this.pKCODE, this.nAME, this.aDRS});

  GetCustomersModel.fromJson(Map<String, dynamic> json) {
    pKCODE = json['PKCODE'];
    nAME = json['NAME'];
    aDRS = json['ADRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PKCODE'] = this.pKCODE;
    data['NAME'] = this.nAME;
    data['ADRS'] = this.aDRS;
    return data;
  }
}
