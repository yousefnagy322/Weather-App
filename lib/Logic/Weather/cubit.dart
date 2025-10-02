import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/Data/model/weather_model.dart';
import 'package:weatherapp/Logic/Weather/state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  Future getSelectedcity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Selectedcity');
  }

  Future getweather() async {
    final Dio dio = Dio();
    emit(WeatherLoadingState());

    final city = await getSelectedcity();
    print(city);
    try {
      final Response response = await dio.get(
        'https://api.weatherapi.com/v1/forecast.json?key=149eeec92f3c420b98a114422241011&q=${city}&days=5&aqi=no&alerts=no',
      );
      print(response.data);
      final model = WeatherModel.fromJson(response.data);

      print(model);
      if (response.statusCode == 200) {
        emit(WeatherSuccessState(weatherModel: model));
      }
    } catch (e) {
      emit(WeatherErrorState(e.toString()));
    }
  }
}
