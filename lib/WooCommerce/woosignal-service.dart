import 'package:woosignal/models/response/customer.dart';
import 'package:woosignal/models/response/product.dart';
import 'package:woosignal/woosignal.dart';
import 'package:flutter/material.dart';

import 'package:woosignal/woosignal.dart';

class WooSignalService {
  static const _appKey = "app_842c37c5a8066c3c8a8384b48ffc75";

  WooSignalService._();
  static final WooSignalService service = WooSignalService._();

  static WooSignal? _api;

  static Future<WooSignal> get _instance async {
    if (_api != null){
      return _api!;
    }
    else {
      await WooSignal.instance.init(appKey: _appKey);
      _api = WooSignal.instance;
      return _api!;
    }
  }


  Future <List<Product>> getProduct() async {
    var ins = await _instance;
    return  await ins.getProducts();//Unhandled Exception: type 'Null' is not a subtype of type 'List<dynamic>' in type cast
  }

  // Future <List<Customer>> getCustomers() async {
  //   return (await _instance).getCustomers();
  // }

  // WooSignalService._();
  // static  WooSignalService get instnce => WooSignalService._();
  //
  //
  // static Future<void> initializeWooSignal() async {
  //     WooSignal.instance.init(appKey: _appKey);
  // }
  //
  // static WooSignal getInstance() => instance;
}
