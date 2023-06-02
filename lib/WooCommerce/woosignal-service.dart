
import 'package:woosignal/models/response/customer.dart';
import 'package:woosignal/models/response/order.dart';
import 'package:woosignal/models/response/product.dart';
import 'package:woosignal/woosignal.dart';


/// WooSignal wrapper
///
/// Must be initialized before use
class WooSignalService {

  static Future<void> init(String appKey) async{
    await WooSignal.instance.init(appKey: appKey);
  }

  static Future <List<Product>> getProducts() async {
    return WooSignal.instance.getProducts();
  }

  static Future <List<Customer>> getCustomers() async {
    return WooSignal.instance.getCustomers();
  }

  static Future<List<Order>> getOrders() async {
    return WooSignal.instance.getOrders();
  }

  // static Future<> getOrders() async {
  //   return WooSignal.instance.
  // }
  //
  // static Future<>  () async {
  //   return WooSignal.instance.
  // }
  //
  // static Future< >  () async {
  //   return WooSignal.instance.
  // }
  //
  // static Future< >  () async {
  //   return WooSignal.instance.
  // }
  //
  // static Future< >  () async {
  //   return WooSignal.instance.
  // }
  // static Future< >  () async {
  //   return WooSignal.instance.
  // }
  //
  // static Future< >  () async {
  //   return WooSignal.instance.
  // }
  //



}
