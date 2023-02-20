class PendingOrderModel {
  String? uSID;
  dynamic cODE;
  String? oDATE;
  String? fKCUST;
  String? cUSTNAME;
  String? fKMAST;
  String? iTEMNAME;
  dynamic qTY;
  dynamic rATE;
  dynamic aMOUNT;

  PendingOrderModel(
      {this.uSID,
      this.cODE,
      this.oDATE,
      this.fKCUST,
      this.cUSTNAME,
      this.fKMAST,
      this.iTEMNAME,
      this.qTY,
      this.rATE,
      this.aMOUNT});

  PendingOrderModel.fromJson(Map<String, dynamic> json) {
    uSID = json['USID'];
    cODE = json['CODE'];
    oDATE = json['ODATE'];
    fKCUST = json['FKCUST'];
    cUSTNAME = json['CUSTNAME'];
    fKMAST = json['FKMAST'];
    iTEMNAME = json['ITEMNAME'];
    qTY = json['QTY'].toInt();
    rATE = json['RATE'];
    aMOUNT = json['AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USID'] = this.uSID;
    data['CODE'] = this.cODE;
    data['ODATE'] = this.oDATE;
    data['FKCUST'] = this.fKCUST;
    data['CUSTNAME'] = this.cUSTNAME;
    data['FKMAST'] = this.fKMAST;
    data['ITEMNAME'] = this.iTEMNAME;
    data['QTY'] = this.qTY;
    data['RATE'] = this.rATE;
    data['AMOUNT'] = this.aMOUNT;
    return data;
  }
}
