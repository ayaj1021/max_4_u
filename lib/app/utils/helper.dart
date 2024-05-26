import 'package:max_4_u/app/database/database.dart';

class ProductHelper {
  // final String? productCode;

  // ProductHelper({
  //   this.productCode,
  // });
  getProducts(String network) async {
    final code = await SecureStorage().getUserProducts();

    final networksList = code
        .where((code) => code['name'] == network)
        .map((code) => code['code'])
        .toList();
    // final networks = networksList.isNotEmpty ? networksList.first : '';
    final networks = networksList.first;

    return networks;
  }
}
