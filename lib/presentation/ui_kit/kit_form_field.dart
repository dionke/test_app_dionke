import 'package:flutter/material.dart';

class KitFormField extends StatefulWidget {
  final String title;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const KitFormField({
    super.key,
    this.title = '',
    this.initialValue,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  State<KitFormField> createState() => KitFormFieldState();
}

class KitFormFieldState extends State<KitFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          const SizedBox(height: 12),
          TextFormField(
            onTap: widget.onTap,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.number,
            initialValue: widget.initialValue,
            controller: widget.controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              filled: true,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
