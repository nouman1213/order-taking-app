class CustomerLegderModel {
  dynamic iD;
  String? pFKMAST;
  String? nAME;
  dynamic oPBAL;
  String? dPFKMAST;
  String? vDT;
  String? rMKS;
  String? cHQNO;
  String? sRNO;
  String? fKMAST;
  dynamic dEBIT;
  dynamic cREDIT;
  dynamic bALDIFF;
  String? vTYP;
  String? bRAND;
  dynamic qTY;
  dynamic rATE;

  CustomerLegderModel(
      {this.iD,
      this.pFKMAST,
      this.nAME,
      this.oPBAL,
      this.dPFKMAST,
      this.vDT,
      this.rMKS,
      this.cHQNO,
      this.sRNO,
      this.fKMAST,
      this.dEBIT,
      this.cREDIT,
      this.bALDIFF,
      this.vTYP,
      this.bRAND,
      this.qTY,
      this.rATE});

  CustomerLegderModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pFKMAST = json['PFKMAST'];
    nAME = json['NAME'];
    oPBAL = json['OPBAL'];
    dPFKMAST = json['DPFKMAST'];
    vDT = json['VDT'];
    rMKS = json['RMKS'];
    cHQNO = json['CHQNO'];
    sRNO = json['SRNO'];
    fKMAST = json['FKMAST'];
    dEBIT = json['DEBIT'];
    cREDIT = json['CREDIT'];
    bALDIFF = json['BALDIFF'];
    vTYP = json['VTYP'];
    bRAND = json['BRAND'];
    qTY = json['QTY'];
    rATE = json['RATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['PFKMAST'] = this.pFKMAST;
    data['NAME'] = this.nAME;
    data['OPBAL'] = this.oPBAL;
    data['DPFKMAST'] = this.dPFKMAST;
    data['VDT'] = this.vDT;
    data['RMKS'] = this.rMKS;
    data['CHQNO'] = this.cHQNO;
    data['SRNO'] = this.sRNO;
    data['FKMAST'] = this.fKMAST;
    data['DEBIT'] = this.dEBIT;
    data['CREDIT'] = this.cREDIT;
    data['BALDIFF'] = this.bALDIFF;
    data['VTYP'] = this.vTYP;
    data['BRAND'] = this.bRAND;
    data['QTY'] = this.qTY;
    data['RATE'] = this.rATE;
    return data;
  }
}
