import 'package:flutter/material.dart';

enum MerchentType { VISA, MASTER, AMERICAN_EXPRESS }

class PaymentCardModel {
  final String cardNo;
  final String bankName;
  final String nameOnCard;
  final MerchentType merchentType;
  final String expiryDate;
  final String cardName;
  final List<Color> cardColors;

  PaymentCardModel(
      {this.expiryDate,
      this.cardNo,
      this.nameOnCard,
      this.merchentType,
      this.cardName,
      this.cardColors,
      this.bankName});
}
