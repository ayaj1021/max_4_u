import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/user_stats_widget.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_app_users_provider.dart';

class UserStatsSection extends StatelessWidget {
  const UserStatsSection({
    super.key,
    required this.getAllAppUsers,
  });

  final GetAllAppUsers getAllAppUsers;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 85.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Color(0xffE6E6E6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UsersStatsWidget(
              title: 'Total Users',
              number: '${getAllAppUsers.allAppUsers.totalData ?? 0}'),
          //horizontalSpace(15),
          SizedBox(
            height: 34,
            child: VerticalDivider(),
          ),
          //horizontalSpace(15),
          UsersStatsWidget(
              title: 'Active Users',
              number: '${getAllAppUsers.allAppUsers.totalActiveConsumer ?? 0}'),
          // horizontalSpace(15),
          SizedBox(
            height: 34,
            child: VerticalDivider(),
          ),
          // horizontalSpace(24),
          UsersStatsWidget(
              title: 'Inactive Users',
              number: '${getAllAppUsers.allAppUsers.totalInactiveConsumer ?? 0}'),
        ],
      ),
    );
  }
}
