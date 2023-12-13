import 'package:skyradio_mobile/models/radios_model.dart';

sealed class RadiosBlocState {}

class RadiosBlocLoading extends RadiosBlocState {}

class RadiosBlocLoaded extends RadiosBlocState {
  final List<Radios> radios;

  RadiosBlocLoaded({
    required this.radios,
  });
}
