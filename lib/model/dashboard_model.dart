import 'package:flutter/material.dart';

class DashboardModel{
  final double amount;
  final IconData iconData;
  final String nature;
  DashboardModel({
    required this.nature,
    required this.amount,
    required this.iconData,
  });
}


List<DashboardModel> dashModel = [
  DashboardModel(nature: 'Sales', amount: 342500000, iconData: Icons.wallet_giftcard_rounded),
  DashboardModel(nature: 'Purchases', amount: 13000, iconData: Icons.shopping_cart),
  DashboardModel(nature: 'Cash', amount: 0, iconData: Icons.attach_money),
  DashboardModel(nature: 'Bank', amount: 300255, iconData: Icons.account_balance),
];
