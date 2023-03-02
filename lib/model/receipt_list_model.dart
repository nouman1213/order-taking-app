class RecieptListModel {
  dynamic cODE;
  String? fKCUST;
  String? nAME;
  String? pTYPE;
  dynamic aMOUNT;
  String? uSID;
  String? vDATE;
  String? bNAME;

  RecieptListModel(
      {this.cODE,
      this.fKCUST,
      this.nAME,
      this.pTYPE,
      this.aMOUNT,
      this.uSID,
      this.vDATE,
      this.bNAME});

  RecieptListModel.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    fKCUST = json['FKCUST'];
    nAME = json['NAME'];
    pTYPE = json['PTYPE'];
    aMOUNT = json['AMOUNT'];
    uSID = json['USID'];
    vDATE = json['VDATE'];
    bNAME = json['BNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODE'] = this.cODE;
    data['FKCUST'] = this.fKCUST;
    data['NAME'] = this.nAME;
    data['PTYPE'] = this.pTYPE;
    data['AMOUNT'] = this.aMOUNT;
    data['USID'] = this.uSID;
    data['VDATE'] = this.vDATE;
    data['BNAME'] = this.bNAME;
    return data;
  }
}
