import 'package:bloc/bloc.dart';
import 'package:the_counter_app/data/dataproviders/dio_data_provider.dart';

import '../../data/dataproviders/goelocator.dart';
import 'app_cubit_states.dart';

class CounterCubit extends Cubit<AppCubitStates> {
  CounterCubit()
      : super(
          const AppCubitStates(
            counterValue: 0,
            wasIncremented: false,
            wasReset: false,
            location: 'LOCATION',
            temperature: 'WEATHER',
          ),
        ) {
    // TODO: call methods()
  }

  void incrementValue() {
    if (state.counterValue < 10) {
      return emit(state.copyWith(counterValue: state.counterValue + 1));
    }
  }

  void decrementValue() {
    if (state.counterValue > 0) {
      return emit(
        state.copyWith(counterValue: state.counterValue - 1),
      );
    }
  }

  void resetValue() => emit(state.copyWith(counterValue: 0));

  Future getLocation() async => emit(
      state.copyWith(location: await LocationProvider().getCurrentLocation()));

  Future getWeather() async =>
      emit(state.copyWith(temperature: await WeatherApiClient().getHttp()));

  Future checkWeatherCondition(dynamic temperature) async {
    if (temperature <= 9) {
      emit(state.copyWith(isCold: true));
    } else {
      emit(state.copyWith(isCold: false));
    }
  }
}
