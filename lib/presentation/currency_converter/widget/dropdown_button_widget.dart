import 'package:flutter/material.dart';
import 'package:test_app_dionke/domain/models/currency.dart';

class DropdownButtonWidget extends StatelessWidget {
  const DropdownButtonWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final Currency value;
  final List<Currency> items;
  final void Function(Currency?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: DropdownButton(
          underline: Container(),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          value: value,
          items: items
              .map(
                (currency) => DropdownMenuItem(
                  value: currency,
                  child: Center(
                    child: Text(currency.code),
                  ),
                ),
              )
              .toList()
            ..add(
              const DropdownMenuItem(
                value: emptyCurrency,
                child: Text(''),
              ),
            ),
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          onChanged: onChanged,
        ),
      ),
    );
  }
}
