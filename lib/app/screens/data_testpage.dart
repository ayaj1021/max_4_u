import 'package:flutter/material.dart';
import 'package:max_4_u/app/model/data_plans_model.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:provider/provider.dart';

class TestData extends StatefulWidget {
  const TestData({super.key});

  @override
  State<TestData> createState() => _TestDataState();
}

class _TestDataState extends State<TestData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false).fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(builder: (context, data, child) {
      return Scaffold(
        body: data.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder<DataPlans>(
                future: data.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.data.products.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.data.products[index];
                      return ListTile(
                        title: Text(
                          "${data.duration == "1" ? "Daily" : data.duration == "7" ? "Weekly" : "Monthly"}${data.name}",
                        ),
                      );
                    },
                  );
                },
              ),
      );
    });
  }
}
