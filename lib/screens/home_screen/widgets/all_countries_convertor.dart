// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:currency_convert/services/currency_app_api.dart';
import 'package:flutter/material.dart';

class AllCountriesConvertor extends StatefulWidget {
  const AllCountriesConvertor({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<AllCountriesConvertor> createState() => _AllCountriesConvertorState();
}

class _AllCountriesConvertorState extends State<AllCountriesConvertor> {
  static List<String>? _cachedCountryLists;
  static Map<String, double>? _cachedRatesMap;

  late Future<List<String>> countryLists;
  late Future<Map<String, double>> ratesMap;

  ValueNotifier<String?> selectedCountry1 = ValueNotifier('AED');
  ValueNotifier<String?> selectedCountry2 = ValueNotifier('AFN');
  String? displayCountry = '';
  ValueNotifier<double?> finalAmount = ValueNotifier(null);

  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (_cachedCountryLists == null || _cachedRatesMap == null) {
      countryLists = CurrencyAppServer.instance.fetchCountries();
      ratesMap = CurrencyAppServer.instance.fetchCurrentRates();

      countryLists.then((data) {
        _cachedCountryLists = data;
      });

      ratesMap.then((data) {
        _cachedRatesMap = data;
      });
    } else {
      countryLists = Future.value(_cachedCountryLists);
      ratesMap = Future.value(_cachedRatesMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Country-1 Container
        Container(
          width: double.infinity,
          height: widget.height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.width * 0.05),
            child: ValueListenableBuilder(
              valueListenable: selectedCountry1,
              builder: (ctx, newval, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Drop Down List
                    FutureBuilder(
                      future: countryLists,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Center(child: Text('Server Error')),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child:
                                Center(child: Text('No Countries Available')),
                          );
                        } else {
                          final _countryLists = snapshot.data!;
                          return DropdownButton<String>(
                            value: selectedCountry1.value,
                            items: _countryLists.map<DropdownMenuItem<String>>(
                                (String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country),
                              );
                            }).toList(),
                            onChanged: (newCountry) {
                              selectedCountry1.value = newCountry;
                            },
                          );
                        }
                      },
                    ),
                    //Country-1-Form-Field
                    SizedBox(
                      width: widget.width * 0.35,
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          validator: (amount) =>
                              (amount == null || amount.isEmpty)
                                  ? 'Enter Amount'
                                  : null,
                          decoration: InputDecoration(
                            hintText: selectedCountry1.value,
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
                            icon: const Icon(Icons.attach_money),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: widget.height * .02,
        ),

        //Country-2-Container
        Container(
          width: double.infinity,
          height: widget.height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.width * 0.05),
            child: ValueListenableBuilder(
              valueListenable: selectedCountry2,
              builder: (ctx, newval, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Drop Down List
                    FutureBuilder(
                      future: countryLists,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Center(child: Text('Server Error')),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child:
                                Center(child: Text('No Countries Available')),
                          );
                        } else {
                          final _countryLists = snapshot.data!;
                          return DropdownButton<String>(
                            value: selectedCountry2.value,
                            items: _countryLists.map<DropdownMenuItem<String>>(
                                (String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country),
                              );
                            }).toList(),
                            onChanged: (newCountry) {
                              selectedCountry2.value = newCountry;
                            },
                          );
                        }
                      },
                    ),
                    //Country-2-Form-Field
                    SizedBox(
                      width: widget.width * 0.35,
                      child: ValueListenableBuilder(
                          valueListenable: finalAmount,
                          builder: (ctx, newAmount, _) {
                            return Text(
                              finalAmount.value == null
                                  ? 'Amount'
                                  : '${newAmount!.toStringAsFixed(2)} $displayCountry',
                              style: const TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        SizedBox(
          height: widget.height * 0.05,
        ),

        //Convert-Button
        Padding(
          padding: EdgeInsets.all(widget.width * 0.02),
          child: SizedBox(
            width: double.infinity,
            height: widget.height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 80, 102, 230),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final rates = await ratesMap;
                  final c1 = selectedCountry1.value,
                      c2 = selectedCountry2.value;
                  displayCountry = c2;
                  double val = (double.parse(amountController.text));
                  final rate1 = rates[c1], rate2 = rates[c2];
                  finalAmount.value = (rate2! / rate1!) * val;
                }
              },
              child: const Text(
                'CONVERT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
