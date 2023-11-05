import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_counter_app/application/cubit/app_cubit_states.dart';

import '../../../application/cubit/app_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future getTemperature() async {
    return CounterCubit().state.temperature;
  }

  @override
  Widget build(BuildContext context) {
    // this is how we can access cubit /////////////
    final cubit = context.read<CounterCubit>();

    return Scaffold(
      // TODO: <start!> this is gonna set the area whole way up and down ..
      extendBodyBehindAppBar: true,
      // TODO: <end!>
      backgroundColor: Colors.black,
      appBar: AppBar(
        // here we can access clock and all the top bar gadget values
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // TODO : <start!> here we set the indication / monitor gadget color to light
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        // TODO : <end!>
      ),
      // TODO : <start!> important Padding around SizedBox
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(40.0, 1.2 * kToolbarHeight, 40.0, 20.0),
        // TODO : <end!>
        child: SizedBox(
          // TODO : <start!> This SizedBox is gonna take the whole height of the device ( adaptive UI )
          height: MediaQuery.of(context).size.height,
          // TODO : <end!>

          child: Stack(
            children: <Widget>[
              // TODO : <start!> Here we are creating backdrop/background effect
              Align(
                alignment: const AlignmentDirectional(4, -0.3),
                child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-4, -0.3),
                child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(color: Colors.orange.shade200),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              // TODO : <end!>
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '📍 Your location',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Good Day!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Image.asset('assets/images/2487418.png'),
                    const SizedBox(height: 10.0),
                    Center(
                      child: BlocBuilder<CounterCubit, AppCubitStates>(
                        builder: (context, state) {
                          // TODO : <start!> Here we are loading / fetching the data : Location API + Weather API => temperature
                          cubit.getWeather();
                          // TODO : <end!>
                          //

                          print(cubit.state.temperature);
                          return Text(
                            '${cubit.state.temperature} °C',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 55.0,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
