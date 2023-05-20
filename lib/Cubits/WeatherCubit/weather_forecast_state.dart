part of 'weather_forcast_cubit.dart';

@immutable
abstract class WeatherForecastState {}

class WeatherForecastInitial extends WeatherForecastState {}

class WeatherForecastLoading extends WeatherForecastState {}

class WeatherForecastLoaded extends WeatherForecastState {}

class WeatherForecastException extends WeatherForecastState {}

class WeatherForecastSocketException extends WeatherForecastState {}
