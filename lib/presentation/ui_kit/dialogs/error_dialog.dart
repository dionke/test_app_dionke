import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void showErrorDialog({
  required BuildContext context,
  String title = '',
  required String errorText,
  required String errorBody,
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => ErrorDialog(
      errorText: errorText,
      title: title.isEmpty ? 'Error' : title,
      errorBody: errorBody,
    ),
  );
}

class ErrorDialog extends StatefulWidget {
  final String errorText;
  final String errorBody;
  final String title;

  const ErrorDialog({
    super.key,
    required this.errorText,
    required this.errorBody,
    required this.title,
  });

  @override
  ErrorDialogState createState() => ErrorDialogState();
}

class ErrorDialogState extends State<ErrorDialog> {
  var _isExpended = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Text(
              widget.errorText,
              textAlign: TextAlign.center,
            ),
          ),
          if (widget.errorBody.isNotEmpty)
            ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.all(0),
              elevation: 0,
              expansionCallback: (index, bool isExpanded) {
                setState(() {
                  _isExpended = !_isExpended;
                });
              },
              children: [
                ExpansionPanel(
                  isExpanded: _isExpended,
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext _, bool isExpanded) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 16),
                        Text(
                          'Error text:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.errorBody,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  height: 64,
                  color: Colors.red,
                  disabledColor: Colors.grey,
                  elevation: 0,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => context.router.pop(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Close window',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
