import 'dart:developer';

import 'package:max_4_u/app/database/database.dart';

class ProductHelper {
  // final String? productCode;

  // ProductHelper({
  //   this.productCode,
  // });
  // getAirtimeProducts(String network) async {
  //   final code = await SecureStorage().getUserProducts();
  //   try {
  //     final networksList = code
  //         .where((code) => code['name'] == network)
  //         .map((code) => code['code'])
  //         .toList();
  //     // final networks = networksList.isNotEmpty ? networksList.first : '';
  //     final networks = networksList.first;
  //     log('This is networks ${networks}');
  //     return networks;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }


   getAirtimeProducts(String network) async {
    final code = await SecureStorage().getUserProducts();
    try {
      final networksList = code
          .where((code) => code['name'] == network)
          .map((code) => code['code'])
          .toList();
      // final networks = networksList.isNotEmpty ? networksList.first : '';
      final networks = networksList.first;
      log('This is networks ${networks}');
      return networks;
    } catch (e) {
      log(e.toString());
    }
  }



   getDataProducts(String network) async {
    final code = await SecureStorage().getUserProducts();
    try {
      final networksList = code
          .where((code) => code['service_name'] == network)
          .map((code) => code['code'])
          .toList();
      // final networks = networksList.isNotEmpty ? networksList.first : '';
      final networks = networksList.first;
      log('This is networks ${networks}');
      return networks;
    } catch (e) {
      log(e.toString());
    }
  }
}
