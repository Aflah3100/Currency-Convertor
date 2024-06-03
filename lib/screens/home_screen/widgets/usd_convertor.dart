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
  static List<String>? _cachedCountryLists;
  static Map<String, double>? _cachedRatesMap;

  late Future<List<String>> futureCountryLists;
  late Future<Map<String, double>> currencyRatesMap;

  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedCountry;
  String? displayCountry;
  ValueNotifier<double?> convertedAmount = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    if (_cachedCountryLists == null || _cachedRatesMap == null) {
      futureCountryLists = CurrencyAppServer.instance.fetchCountries();
      currencyRatesMap = CurrencyAppServer.instance.fetchCurrentRates();

      futureCountryLists.then((data) {
        _cachedCountryLists = data;
      });

      currencyRatesMap.then((data) {
        _cachedRatesMap = data;
      });
    } else {
      futureCountryLists = Future.value(_cachedCountryLists);
      currencyRatesMap = Future.value(_cachedRatesMap);
    }
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
          child: ValueListenableBuilder(
              valueListenable: convertedAmount,
              builder: (ctx, newAmount, _) {
                return Center(
                  child: (convertedAmount.value == null)
                      ? const Text(
                          'Press Convert Button To Convert',
                          style: TextStyle(fontSize: 20.0),
                        )
                      : Text(
                          'Amount: ${(convertedAmount.value)!.toStringAsFixed(2)} $displayCountry',
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  convertedAmount.value = rates[selectedCountry]! * amount;
                  displayCountry = selectedCountry;
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
