class PreSaleOrderRequest {
  String? fTSaleOrderNo;
  String? fTInsUser;
  String? fDInsDate;
  String? fTInsTime;
  String? fTUpdUser;
  String? fDUpdDate;
  String? fTUpdTime;
  String? fDSaleOrderDate;
  String? fTSaleOrderBy;
  String? fTQuotationNo;
  int? fNMSysCustId;
  String? fTDeliveryAddress;
  String? fDDeliveryDate;
  int? fNCreditDay;
  String? fNMSysTermOfPMId;
  String? fNMSysSaleId;
  String? fTRemark;
  int? fNSOAmt;
  int? fNSOGrandAmt;
  String? fTStateApproved;
  String? fTStateSendApproved;
  String? fTStateSendAppDate;
  String? fTStateSendAppTime;
  int? fNMSysShipId;

  PreSaleOrderRequest(
      {this.fTSaleOrderNo,
      this.fTInsUser,
      this.fDInsDate,
      this.fTInsTime,
      this.fTUpdUser,
      this.fDUpdDate,
      this.fTUpdTime,
      this.fDSaleOrderDate,
      this.fTSaleOrderBy,
      this.fTQuotationNo,
      this.fNMSysCustId,
      this.fTDeliveryAddress,
      this.fDDeliveryDate,
      this.fNCreditDay,
      this.fNMSysTermOfPMId,
      this.fNMSysSaleId,
      this.fTRemark,
      this.fNSOAmt,
      this.fNSOGrandAmt,
      this.fTStateApproved,
      this.fTStateSendApproved,
      this.fTStateSendAppDate,
      this.fTStateSendAppTime,
      this.fNMSysShipId});

  PreSaleOrderRequest.fromJson(Map<String, dynamic> json) {
    fTSaleOrderNo = json['fTSaleOrderNo'];
    fTInsUser = json['fTInsUser'];
    fDInsDate = json['fDInsDate'];
    fTInsTime = json['fTInsTime'];
    fTUpdUser = json['fTUpdUser'];
    fDUpdDate = json['fDUpdDate'];
    fTUpdTime = json['fTUpdTime'];
    fDSaleOrderDate = json['fDSaleOrderDate'];
    fTSaleOrderBy = json['fTSaleOrderBy'];
    fTQuotationNo = json['fTQuotationNo'];
    fNMSysCustId = json['fNMSysCustId'];
    fTDeliveryAddress = json['fTDeliveryAddress'];
    fDDeliveryDate = json['fDDeliveryDate'];
    fNCreditDay = json['fNCreditDay'];
    fNMSysTermOfPMId = json['fNMSysTermOfPMId'];
    fNMSysSaleId = json['fNMSysSaleId'];
    fTRemark = json['fTRemark'];
    fNSOAmt = json['fNSOAmt'];
    fNSOGrandAmt = json['fNSOGrandAmt'];
    fTStateApproved = json['fTStateApproved'];
    fTStateSendApproved = json['fTStateSendApproved'];
    fTStateSendAppDate = json['fTStateSendAppDate'];
    fTStateSendAppTime = json['fTStateSendAppTime'];
    fNMSysShipId = json['fNMSysShipId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fTSaleOrderNo'] = fTSaleOrderNo;
    data['fTInsUser'] = fTInsUser;
    data['fDInsDate'] = fDInsDate;
    data['fTInsTime'] = fTInsTime;
    data['fTUpdUser'] = fTUpdUser;
    data['fDUpdDate'] = fDUpdDate;
    data['fTUpdTime'] = fTUpdTime;
    data['fDSaleOrderDate'] = fDSaleOrderDate;
    data['fTSaleOrderBy'] = fTSaleOrderBy;
    data['fTQuotationNo'] = fTQuotationNo;
    data['fNMSysCustId'] = fNMSysCustId;
    data['fTDeliveryAddress'] = fTDeliveryAddress;
    data['fDDeliveryDate'] = fDDeliveryDate;
    data['fNCreditDay'] = fNCreditDay;
    data['fNMSysTermOfPMId'] = fNMSysTermOfPMId;
    data['fNMSysSaleId'] = fNMSysSaleId;
    data['fTRemark'] = fTRemark;
    data['fNSOAmt'] = fNSOAmt;
    data['fNSOGrandAmt'] = fNSOGrandAmt;
    data['fTStateApproved'] = fTStateApproved;
    data['fTStateSendApproved'] = fTStateSendApproved;
    data['fTStateSendAppDate'] = fTStateSendAppDate;
    data['fTStateSendAppTime'] = fTStateSendAppTime;
    data['fNMSysShipId'] = fNMSysShipId;
    return data;
  }
}

class PreSaleOrderResponse {
  int? statusCode;
  String? code;
  String? message;
  PreSaleOrderDataResponse? data;

  PreSaleOrderResponse({this.statusCode, this.code, this.message, this.data});

  PreSaleOrderResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null
        ? PreSaleOrderDataResponse.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PreSaleOrderDataResponse {
  String? saleOrderNo;
  String? insertUser;
  String? insertDate;
  String? insertTime;
  String? quotationNo;
  String? saleOrderDate;
  String? saleOrderBy;
  String? saleId;

  PreSaleOrderDataResponse(
      {this.saleOrderNo,
      this.insertUser,
      this.insertDate,
      this.insertTime,
      this.quotationNo,
      this.saleOrderDate,
      this.saleOrderBy,
      this.saleId});

  PreSaleOrderDataResponse.fromJson(Map<String, dynamic> json) {
    saleOrderNo = json['sale_order_no'];
    insertUser = json['insert_user'];
    insertDate = json['insert_date'];
    insertTime = json['insert_time'];
    quotationNo = json['quotation_no'];
    saleOrderDate = json['sale_order_date'];
    saleOrderBy = json['sale_order_by'];
    saleId = json['sale_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sale_order_no'] = saleOrderNo;
    data['insert_user'] = insertUser;
    data['insert_date'] = insertDate;
    data['insert_time'] = insertTime;
    data['quotation_no'] = quotationNo;
    data['sale_order_date'] = saleOrderDate;
    data['sale_order_by'] = saleOrderBy;
    data['sale_id'] = saleId;
    return data;
  }
}

class PreSaleOrderItemRequest {
  String? fTSaleOrderNo;
  String? fTInsUser;
  int? fNMSysProdId;
  int? fNPrice;
  int? fNQuantity;
  int? fNAmt;

  PreSaleOrderItemRequest(
      {this.fTSaleOrderNo,
      this.fTInsUser,
      this.fNMSysProdId,
      this.fNPrice,
      this.fNQuantity,
      this.fNAmt});

  PreSaleOrderItemRequest.fromJson(Map<String, dynamic> json) {
    fTSaleOrderNo = json['fTSaleOrderNo'];
    fTInsUser = json['fTInsUser'];
    fNMSysProdId = json['fNMSysProdId'];
    fNPrice = json['fNPrice'];
    fNQuantity = json['fNQuantity'];
    fNAmt = json['fNAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fTSaleOrderNo'] = fTSaleOrderNo;
    data['fTInsUser'] = fTInsUser;
    data['fNMSysProdId'] = fNMSysProdId;
    data['fNPrice'] = fNPrice;
    data['fNQuantity'] = fNQuantity;
    data['fNAmt'] = fNAmt;
    return data;
  }
}
