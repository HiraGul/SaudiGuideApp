import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repositories/weather_repository.dart';

part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit() : super(WeatherForecastInitial());

  getWeatherData({required String city}) async {
    try {
      emit(WeatherForecastLoading());
      final int status = await WeatherRepository.getForecastData(city: city);
      if (status == 200) {
        emit(WeatherForecastLoaded());
      } else if (status == 501) {
        emit(WeatherForecastSocketException());
      } else {
        emit(WeatherForecastException());
      }
    } catch (e) {
      emit(WeatherForecastException());
    }
  }
}
