
import 'package:flutter/material.dart';

enum NavigationType {
  usd,
  others;
}

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({
    super.key,
    required this.width,
    required this.height,
    required this.touchNotifier,
  });

  final double width;
  final double height;
  final ValueNotifier<NavigationType> touchNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(width * 0.01),
        width: width,
        height: height * 0.06,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: ValueListenableBuilder(
            valueListenable: touchNotifier,
            builder: (ctx, val, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Navigation-Bar-Button-1
                  Container(
                    width: width * 0.45,
                    height: height * 0.04,
                    decoration: BoxDecoration(
                        color: (touchNotifier.value == NavigationType.usd)
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0))),
                    child: Center(
                        child: InkWell(
                      onTap: () => touchNotifier.value = NavigationType.usd,
                      child: Text(
                        'USD To Any',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight:
                                (touchNotifier.value == NavigationType.usd)
                                    ? FontWeight.bold
                                    : FontWeight.w100,
                            color: touchNotifier.value == NavigationType.usd
                                ? Colors.indigo
                                : Colors.grey),
                      ),
                    )),
                  ),
                  //Navigation-Bar-Button-2
                  Container(
                    width: width * 0.45,
                    height: height * 0.04,
                    decoration: BoxDecoration(
                        color: (touchNotifier.value == NavigationType.others)
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0))),
                    child: Center(
                        child: InkWell(
                      onTap: () => touchNotifier.value = NavigationType.others,
                      child: Text(
                        'Other Countries',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight:
                                (touchNotifier.value == NavigationType.others)
                                    ? FontWeight.bold
                                    : FontWeight.w100,
                            color: touchNotifier.value == NavigationType.others
                                ? Colors.indigo
                                : Colors.grey),
                      ),
                    )),
                  )
                ],
              );
            }));
  }
}