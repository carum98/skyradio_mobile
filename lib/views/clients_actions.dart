import 'package:flutter/material.dart';
import 'package:skyradio_mobile/models/clients.dart';

class ClientsActionsView extends StatelessWidget {
  final Clients client;
  final Function onRefresh;

  const ClientsActionsView({
    super.key,
    required this.client,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
