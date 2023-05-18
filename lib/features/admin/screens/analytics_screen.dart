import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/features/admin/service/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_charts_display.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? earnings;
  List<Sales>? sales;

  @override
  void initState() {
    super.initState();
    getAnalytics();
  }

  getAnalytics() async {
    var res = await adminServices.showAnalystics(context: context);
    earnings = res['totalEarnings'];
    sales = res['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (earnings == null || sales == null)
        ? const LoaderIndicator()
        : Column(
            children: [
              Text(
                "$Rs$earnings",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: sales!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earnings,
                  ),
                ]),
              )
            ],
          );
  }
}
