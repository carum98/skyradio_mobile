import 'package:skyradio_mobile/core/bloc.dart';
import 'package:skyradio_mobile/repository/radios_repository.dart';

import 'radios_bloc_event.dart';
import 'radios_bloc_state.dart';

export 'radios_bloc_event.dart';
export 'radios_bloc_state.dart';

class RadiosBloc extends SkBloc<RadiosBlocState, RadiosBlocEvent> {
  final RadiosRepository _repository;

  RadiosBloc({
    required RadiosRepository repository,
  })  : _repository = repository,
        super(RadiosBlocLoading());

  @override
  onEvent(RadiosBlocEvent event) async {
    if (event is RadiosBlocGetAll) {
      await _getAll();
    }
  }

  Future<void> _getAll() async {
    emit(RadiosBlocLoading());

    try {
      final data = await _repository.getRadios();

      emit(RadiosBlocLoaded(
        radios: data,
      ));
    } catch (e) {
      emitError(e);
    }
  }
}
