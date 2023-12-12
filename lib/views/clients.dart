import 'package:flutter/material.dart';
import 'package:skyradio_mobile/bloc/clients/clients_bloc.dart';
import 'package:skyradio_mobile/core/dependency_inyection.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({super.key});

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  late final ClientsBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _bloc = ClientsBloc(
      repository: DI.of(context).clientsRepository,
    );

    _bloc.onEvent(ClientsBlocGetAll());
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: StreamBuilder(
        stream: _bloc.stream,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data;

            if (data is ClientsBlocLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (data is ClientsBlocLoaded) {
              return ListView.builder(
                itemCount: data.clients.length,
                itemBuilder: (_, index) {
                  final client = data.clients[index];

                  return ListTile(
                    title: Text(client.name),
                    subtitle: Text(client.modality.name),
                  );
                },
              );
            }
          }

          return const SizedBox();
        },
      ),
    );
  }
}
