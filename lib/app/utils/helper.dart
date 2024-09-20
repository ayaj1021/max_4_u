import 'dart:developer';

import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/model/load_data_model.dart';

class ProductHelper {
  getAirtimeProducts(String network) async {
  final storage = await SecureStorage();
  final List<Product>? productsList = await storage.getUserProducts();
  
  try {
    if (productsList != null) {
      final airtimeProducts = productsList
          .where((product) => product.category == 'airtime' && product.serviceName == network)
          .map((product) => product.code)
          .toList();

      final networks = airtimeProducts.isNotEmpty ? airtimeProducts.first : '';
     
      return networks;
    } else {
      log('No products found.');
      return null;
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
}


  // getAirtimeProducts(String network) async {
  //   final storage = await SecureStorage();
  //   final code = await storage.getUserProducts();
  //   try {
  //     final networksList = code!
  //         .where((code) => code.name == network)
  //         .map((code) => code.code)
  //         .toSet()
  //         .toList();
  //     // final networks = networksList.isNotEmpty ? networksList.first : '';
  //     final networks = networksList.first;
  //     log('This is airtime networks ${networks}');
  //     return networks;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  getDataProducts(String network) async {
    final storage = await SecureStorage();
    final code = await storage.getUserProducts();
    try {
      final networksList = code!
          .where((code) => code.code == network)
          .map((code) => code.code)
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
