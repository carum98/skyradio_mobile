import 'package:skyradio_mobile/models/clients_model.dart';

sealed class ClientsBlocState {}

class ClientsBlocLoading extends ClientsBlocState {}

class ClientsBlocLoaded extends ClientsBlocState {
  final List<Clients> clients;

  ClientsBlocLoaded({
    required this.clients,
  });
}
