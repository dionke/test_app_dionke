import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_dionke/common/utils/debouncer.dart';
import 'package:test_app_dionke/domain/bloc/currency/currency_bloc.dart';
import 'package:test_app_dionke/domain/models/currency.dart';
import 'package:test_app_dionke/presentation/ui_kit/dialogs/error_dialog.dart';
import 'package:test_app_dionke/presentation/ui_kit/kit_form_field.dart';
import 'package:test_app_dionke/presentation/ui_kit/kit_progress_indicator.dart';

import 'widget/dropdown_button_widget.dart';

@RoutePage()
class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final debouncer = Debouncer();

  final firstAmountController = TextEditingController();
  final secondAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency converter',
        ),
      ),
      body: BlocConsumer<CurrencyBloc, CurrencyState>(
        listener: (context, state) {
          if (state is CurrencyShowErrorState) {
            showErrorDialog(
              context: context,
              errorText: state.errorText,
              errorBody: state.errorBody,
            );
          }
        },
        builder: (context, state) {
          if (state is CurrencyLoadingState) {
            return const KitProgressIndicator();
          } else if (state is CurrencyLoadedState) {


              firstAmountController.text = state.firstAmount;
              secondAmountController.text = state.secondAmount;


            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: KitFormField(
                          title: 'You send',
                          controller: firstAmountController,
                          onChanged: (value) {
                              debouncer(() => _currencyConvert(context,
                                  isFirstField: true, amount: value));
                          },
                        ),
                      ),
                      DropdownButtonWidget(
                        value: state.firstSelectedCurrency,
                        items: state.currencies,
                        onChanged: (value) {
                          if (value != null) {
                            _selectCurrencyCode(context,
                                isFirstField: true, selectedCurrency: value);
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: KitFormField(
                          title: 'They get',
                          controller: secondAmountController,
                          onChanged: (value) {
                              debouncer(() => _currencyConvert(context,
                                  isFirstField: false, amount: value));

                          },
                        ),
                      ),
                      DropdownButtonWidget(
                        value: state.secondSelectedCurrency,
                        items: state.currencies,
                        onChanged: (value) {
                          if (value != null) {
                            _selectCurrencyCode(context,
                                isFirstField: false, selectedCurrency: value);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

Future<void> _selectCurrencyCode(
  BuildContext context, {
  required bool isFirstField,
  required Currency selectedCurrency,
}) async {
  BlocProvider.of<CurrencyBloc>(context).add(CurrencySelectCodeEvent(
    isFirstField: isFirstField,
    selectedCurrency: selectedCurrency,
  ));
}

Future<void> _currencyConvert(
  BuildContext context, {
  required bool isFirstField,
  required String amount,
}) async {
  BlocProvider.of<CurrencyBloc>(context)
      .add(CurrencyConvertEvent(isFirstField: isFirstField, amount: amount));
}
