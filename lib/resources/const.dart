import 'package:flutter_bloc_demo/constants/routes.dart';
import 'package:flutter_bloc_demo/constants/strings.dart';

List<Map<String, dynamic>> homeIconList = [
  {
    "statusText": product,
    "image": "assets/images/product.png",
    "route": AppRoute.product
  },
  {
    "statusText": customer,
    "image": "assets/images/customer.png",
    "route": AppRoute.customer
  },
  {
    "statusText": order,
    "image": "assets/images/sale_order.png",
    "route": AppRoute.order
  },
  {
    "statusText": revenue,
    "image": "assets/images/revenue.png",
    "route": AppRoute.revenue
  }
];
