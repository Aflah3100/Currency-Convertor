import 'package:currency_convert/services/currency_app_api.dart';
import 'package:flutter/material.dart';

//USD-To Other Convertor
class USDConvertor extends StatefulWidget {
  const USDConvertor({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<USDConvertor> createState() => _USDConvertorState();
}

class _USDConvertorState extends State<USDConvertor> {
  late Future<List<String>> futureCountryLists;
  late Future<Map<String, dynamic>> currencyRatesMap;
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCountry;
  String? displayCountry;
  ValueNotifier<double?> convertedAmount= ValueNotifier(null);

  @override
  void initState() {
    futureCountryLists = CurrencyAppServer.instance.fetchCountries();
    currencyRatesMap = CurrencyAppServer.instance.fetchCurrentRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: widget.height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Drop Down List
                FutureBuilder<List<String>>(
                    future: futureCountryLists,
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Center(child: Text('Server Error')),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child:
                                Center(child: Text('No Countries Available')));
                      } else {
                        final countryLists = snapshot.data!;
                        selectedCountry ??= countryLists.first;
                        return DropdownButton<String>(
                          value: selectedCountry,
                          items: countryLists.map<DropdownMenuItem<String>>(
                            (String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country),
                              );
                            },
                          ).toList(),
                          onChanged: (newCountry) {
                            setState(() {
                              selectedCountry = newCountry;
                            });
                          },
                        );
                      }
                    }),
                // USD-Amount-Form-Field-Container
                SizedBox(
                  width: widget.width * 0.35,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (amount) => (amount == null || amount.isEmpty)
                          ? 'Enter USD'
                          : null,
                      controller: _textController,
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
                        icon: const Icon(Icons.attach_money),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: widget.height * .02,
        ),
        // Converted-Currency-Text-Container
        Container(
          width: double.infinity,
          height: widget.height * 0.10,
          decoration: BoxDecoration(
            color: const Color.fromARGB(26, 182, 182, 182),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ValueListenableBuilder(valueListenable: convertedAmount, builder: (ctx,newAmount,_){
            return Center(
            child: (convertedAmount.value == null)
                ? const Text(
                    'Press Convert Button To Convert',
                    style: TextStyle(fontSize: 20.0),
                  )
                : Text(
                    'Amount: ${convertedAmount.value} $displayCountry',
                    style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                  ),
          );
          }),
        ),
        SizedBox(
          height: widget.height * 0.034,
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
                if (_formKey.currentState!.validate()) {

                  double amount = double.parse(_textController.text);
                  final rates = await currencyRatesMap;
                  convertedAmount.value = rates[selectedCountry] * amount;
                  displayCountry=selectedCountry;
                  
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
                FutureBuilder(
                    future: CurrencyAppServer.instance.fetchCountries(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Center(child: Text('Server Error')),
                        );
                      } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                            child:
                                Center(child: Text('No Countries Avaliable')));
                      } else {
                        final _countryLists = snapshot.data;
                        ValueNotifier<String?> selectedCountryNotifier =
                            ValueNotifier(_countryLists!.first);
                        return ValueListenableBuilder(
                            valueListenable: selectedCountryNotifier,
                            builder: (ctx, val, _) {
                              return DropdownButton<String>(
                                  value: selectedCountryNotifier.value,
                                  items: _countryLists
                                      .map<DropdownMenuItem<String>>(
                                          (String country) {
                                    return DropdownMenuItem<String>(
                                      value: country,
                                      child: Text(country),
                                    );
                                  }).toList(),
                                  onChanged: (newCountry) {
                                    selectedCountryNotifier.value = newCountry;
                                  });
                            });
                      }
                    }),
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
                FutureBuilder(
                    future: CurrencyAppServer.instance.fetchCountries(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Center(child: Text('Server Error')),
                        );
                      } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                            child:
                                Center(child: Text('No Countries Avaliable')));
                      } else {
                        final _countryLists = snapshot.data;
                        ValueNotifier<String?> selectedCountryNotifier =
                            ValueNotifier(_countryLists!.first);
                        return ValueListenableBuilder(
                            valueListenable: selectedCountryNotifier,
                            builder: (ctx, val, _) {
                              return DropdownButton<String>(
                                  value: selectedCountryNotifier.value,
                                  items: _countryLists
                                      .map<DropdownMenuItem<String>>(
                                          (String country) {
                                    return DropdownMenuItem<String>(
                                      value: country,
                                      child: Text(country),
                                    );
                                  }).toList(),
                                  onChanged: (newCountry) {
                                    selectedCountryNotifier.value = newCountry;
                                  });
                            });
                      }
                    }),
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
