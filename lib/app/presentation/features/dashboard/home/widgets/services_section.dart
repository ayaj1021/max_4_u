import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/views/buy_airtime_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_data/presentation/views/buy_data_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/service_component.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/sell_airtime_data/sell_airtime_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/sell_airtime_data/sell_data_screen.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    super.key,
    required this.userServices,
    required this.servicesIcon,
    required this.reloadData,
  });

  final List<Service> userServices;
  final List servicesIcon;
  final ReloadUserDataProvider reloadData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: userServices.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => nextScreen(
                    context,
                    index == 0 ? BuyDataScreen() : BuyAirtimeScreen(),
                  ),
                  child: ServiceComponent(
                    margin: 20,
                    serviceColor: Color(0xffDEEDF7),
                    serviceName: '${userServices[index].category}',

                    serviceIcon: servicesIcon[index],
                    //Icons.call_outlined,
                  ),
                );
              }),
        ),

        verticalSpace(
            //  vendor.isVendor == '1'
            //  authProv.resDataData.userData![0].level == '1'
            reloadData.loadData.userData?[0].level == '1' ? 0 : 16),
        //    vendor.isVendor == '1'
        reloadData.loadData.userData?[0].level == '1'
            // authProv.resDataData.userData![0].level == '1'
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => nextScreen(
                      context,
                      const SellAirtimeScreen(),
                    ),
                    child: const ServiceComponent(
                      serviceColor: Color(0xffDEEDF7),
                      serviceName: 'Sell Airtime',
                      serviceIcon: Icons.call_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => nextScreen(
                      context,
                      const SellDataScreen(),
                    ),
                    child: const ServiceComponent(
                      serviceColor: Color(0xffE8D6FE),
                      serviceName: 'Sell Data',
                      serviceIcon: Icons.network_wifi_outlined,
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
