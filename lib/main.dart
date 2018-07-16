import 'package:flutter/material.dart';
import 'package:taskshare/app.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:taskshare/util/app_logger.dart';

void main() {
  AppLogger.configure();
  final account = AccountModel();
  runApp(new App(account: account,));
}
