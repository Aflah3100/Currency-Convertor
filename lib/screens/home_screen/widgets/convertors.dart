import 'package:flutter/material.dart';

//USD-Convertor-Widget
class USDConvertor extends StatelessWidget {
  const USDConvertor({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Drop Down List
                const Text(
                  'EUR',
                  style: TextStyle(fontSize: 20.0),
                ),
                //USD-Amount-Form-Field-Container
                SizedBox(
                  width: width * 0.35,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'USD',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2.0,
                          ),
                        ),
                        hintStyle: const TextStyle(fontSize: 16.0),
                        filled: true,
                        fillColor: Colors.white12,
                        icon: const Icon(Icons.attach_money)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * .02,
        ),

        //Converted-Currency-Text-Container
        Container(
          width: double.infinity,
          height: height * 0.10,
          decoration: BoxDecoration(
            color: const Color.fromARGB(26, 182, 182, 182),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Center(
            child: Text(
              'Converted Currency Display',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.034,
        ),
      ],
    );
  }
}

//All-Countries-Currency-Convertor-Widget
class AllCountriesConvertor extends StatelessWidget {
  const AllCountriesConvertor({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Country-1 Container
        Container(
          width: double.infinity,
          height: height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Drop Down List
                const Text(
                  'Country-1',
                  style: TextStyle(fontSize: 20.0),
                ),
                //Country-1-Form-Field
                SizedBox(
                  width: width * 0.35,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'USD',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2.0,
                          ),
                        ),
                        hintStyle: const TextStyle(fontSize: 16.0),
                        filled: true,
                        fillColor: Colors.white12,
                        icon: const Icon(Icons.attach_money)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * .02,
        ),

        //Country-2-Container
        Container(
          width: double.infinity,
          height: height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Drop Down List
                const Text(
                  'Country-2',
                  style: TextStyle(fontSize: 20.0),
                ),
                //Country-2-Form-Field
                SizedBox(
                    width: width * 0.35,
                    child: const Text(
                      'Converted Amount',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),

        SizedBox(
          height: height * 0.05,
        ),
      ],
    );
  }
}
