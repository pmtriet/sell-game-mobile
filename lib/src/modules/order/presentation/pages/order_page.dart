
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../widgets/order_body.dart';

@RoutePage()
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderBody(),
    );
  }
}

