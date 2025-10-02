import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/Data/model/weather_model.dart';
import 'package:weatherapp/Logic/MultiWeather/state.dart';

class MultiWeatherCubit extends Cubit<MultiWeatherState> {
  MultiWeatherCubit() : super(MultiWeatherInitialState());

  Future getMultiweather(List<String> cities) async {
    final Dio dio = Dio();
    emit(MultiWeatherLoadingState());
    final List<WeatherModel> results = [];

    try {
      for (var city in cities) {
        final Response response = await dio.get(
          'https://api.weatherapi.com/v1/forecast.json?key=149eeec92f3c420b98a114422241011&q=${city}&days=5&aqi=no&alerts=no',
        );

        if (response.statusCode == 200) {
          final model = WeatherModel.fromJson(response.data);
          results.add(model);
        }
      }
      if (results.isEmpty) {
        emit(MultiWeatherEmptyState());
      } else {
        emit(MultiWeatherSuccessState(results));
      }
    } catch (e) {
      emit(MultiWeatherErrorState(e.toString()));
    }
  }

  Future getCitiesandWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final citylist = prefs.getStringList('citylist') ?? [];
    print(citylist);
    getMultiweather(citylist);
  }
}
