import 'package:currency_convert/screens/home_screen/widgets/all_countries_convertor.dart';
import 'package:currency_convert/screens/home_screen/widgets/top_navigation_bar.dart';
import 'package:currency_convert/screens/home_screen/widgets/usd_convertor.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  ValueNotifier<NavigationType> touchNotifier =
      ValueNotifier(NavigationType.usd);

  @override
  Widget build(BuildContext context) {
    //Height & Width
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Convert',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        //Base-Container-Widget
        child: Container(
          padding: EdgeInsets.all(width * 0.02),
          child: Column(
            children: [
              //Top-Navigation-Bar
              TopNavigationBar(
                  width: width, height: height, touchNotifier: touchNotifier),

              //Spacer
              SizedBox(
                height: height * 0.04,
              ),

              //Convertor-Widgets
              ValueListenableBuilder(
                  valueListenable: touchNotifier,
                  builder: (index, value, _) {
                    return (value == NavigationType.usd)
                        ? USDConvertor(height: height, width: width)
                        : AllCountriesConvertor(height: height, width: width);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
