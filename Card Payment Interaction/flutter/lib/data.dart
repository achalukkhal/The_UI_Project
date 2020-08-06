import 'package:flutter/material.dart';

import 'payment_card_model.dart';

final List<PaymentCardModel> cardData = [
  PaymentCardModel(
      cardNo: '4111 1111 1111 1111',
      nameOnCard: 'ACHAL Ukkhal',
      merchentType: MerchentType.VISA,
      cardColors: [Colors.yellow, Colors.deepOrange, Colors.deepOrangeAccent],
      cardName: 'Bussiness',
      expiryDate: '12/20'),
  PaymentCardModel(
      cardNo: '5105 1051 0510 5100',
      nameOnCard: 'ACHAL Ukkhal',
      merchentType: MerchentType.MASTER,
      cardColors: [Colors.blueAccent, Colors.blue, Colors.deepPurple],
      cardName: 'Platinum',
      expiryDate: '02/24'),
  PaymentCardModel(
      cardNo: '3782 8224 6310 005',
      nameOnCard: 'ACHAL Ukkhal',
      merchentType: MerchentType.AMERICAN_EXPRESS,
      cardColors: [Colors.lightGreen, Colors.green, Colors.greenAccent],
      cardName: 'Corporate',
      expiryDate: '02/24'),
];
