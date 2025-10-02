import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/Data/model/weather_model.dart';
import 'package:weatherapp/Logic/MultiWeather/cubit.dart';
import 'package:weatherapp/Logic/MultiWeather/state.dart';
import 'package:weatherapp/Ui/home_screen.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  TextEditingController cityController = TextEditingController();

  String? slectedCity;

  Future getCityList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('citylist');
  }

  Future saveCityList(List<String> citylist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('citylist', citylist);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultiWeatherCubit()..getCitiesandWeather(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff391A49),
                Color(0xff301D5C),
                Color(0xff262171),
                Color(0xff301D5C),
                Color(0xff391A49),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 45,
              bottom: 100,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Saved Locations',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        shadows: [
                          Shadow(
                            color: Color(0x25000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Image.asset('lib/assets/Search Icon.png'),
                  ],
                ),

                BlocBuilder<MultiWeatherCubit, MultiWeatherState>(
                  builder: (context, state) {
                    if (state is MultiWeatherLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    if (state is MultiWeatherSuccessState) {
                      return Expanded(
                        flex: 90,
                        child: ListView.builder(
                          shrinkWrap: true,

                          itemCount: state.weatherList.length,
                          itemBuilder: (context, index) {
                            WeatherModel model = state.weatherList[index];
                            return GestureDetector(
                              onTap: () async {
                                slectedCity = model.location.name;
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                  'Selectedcity',
                                  slectedCity!,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    top: 16,
                                    right: 16,
                                  ),
                                  height: 153,
                                  width: 345,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Color.fromRGBO(170, 165, 165, 0.42),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.location.name,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              shadows: [
                                                Shadow(
                                                  color: Color(0x25000000),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            model.current.condition.text,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                255,
                                                255,
                                                255,
                                                0.8,
                                              ),
                                              fontWeight: FontWeight.w500,
                                              shadows: [
                                                Shadow(
                                                  color: Color(0x25000000),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Humidity',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                      255,
                                                      255,
                                                      255,
                                                      0.8,
                                                    ),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: SizedBox(width: 9),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${model.current.humidity.toString()}%',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    shadows: [
                                                      Shadow(
                                                        color: Color(
                                                          0x25000000,
                                                        ),
                                                        offset: Offset(0, 4),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Wind',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                      255,
                                                      255,
                                                      255,
                                                      0.8,
                                                    ),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: SizedBox(width: 9),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${model.current.windKph.toString()}km/h',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    shadows: [
                                                      Shadow(
                                                        color: Color(
                                                          0x25000000,
                                                        ),
                                                        offset: Offset(0, 4),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.network(
                                            'https:${model.current.condition.icon}',
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.current.tempC
                                                    .toInt()
                                                    .toString(),
                                                style: TextStyle(
                                                  height: 1,
                                                  fontSize: 48,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color(0x25000000),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '°C',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color(0x25000000),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (state is MultiWeatherEmptyState) {
                      return Center(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text(
                              'No saved locations',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is MultiWeatherErrorState) {
                      return Text(state.error);
                    }
                    return SizedBox();
                  },
                ),

                Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            padding: EdgeInsets.only(
                              left: 24,
                              right: 24,
                              top: 16,
                              bottom: 16,
                            ),
                            height: 153,
                            width: 345,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff391A49),
                                  Color(0xff301D5C),
                                  Color(0xff262171),
                                  Color(0xff301D5C),
                                  Color(0xff391A49),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: cityController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromRGBO(
                                      170,
                                      165,
                                      165,
                                      0.42,
                                    ),
                                    hint: Text(
                                      'Enter city name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color: Color(0x25000000),
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    List<String>? list = await getCityList();
                                    if (list == null) {
                                      list = [];
                                      list.add(cityController.text);
                                    } else {
                                      list.add(cityController.text);
                                    }

                                    await saveCityList(list);

                                    slectedCity = cityController.text;
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                      'Selectedcity',
                                      '{$slectedCity}',
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Color.fromRGBO(
                                        170,
                                        165,
                                        165,
                                        0.42,
                                      ),
                                    ),
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 59,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color.fromRGBO(170, 165, 165, 0.42),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('lib/assets/Add Icon.png'),
                        SizedBox(width: 8),
                        Text(
                          'Add new',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
