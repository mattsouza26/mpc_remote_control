// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectTextDialog extends StatefulWidget {
  final String title;
  final String labelText;
  final String helperText;
  final String? initalValue;
  final String? hintText;
  final String? Function(String?)? inputValidator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const SelectTextDialog({
    Key? key,
    required this.title,
    required this.labelText,
    required this.helperText,
    this.initalValue,
    this.hintText,
    this.inputValidator,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<SelectTextDialog> createState() => _SelectTextDialogState();
}

class _SelectTextDialogState extends State<SelectTextDialog> {
  final GlobalKey<FormFieldState> _formFieldKey = GlobalKey();
  late final TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initalValue);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void save() {
    final validate = _formFieldKey.currentState?.validate() ?? false;
    if (!validate) return;
    Navigator.of(context).pop(_textEditingController.text);
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(viewInsets: const EdgeInsets.only(bottom: 0)),
      child: Dialog(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  key: _formFieldKey,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                  ),
                  inputFormatters: widget.inputFormatters,
                  validator: widget.inputValidator,
                  keyboardType: widget.keyboardType,
                ),
                const SizedBox(height: 10),
                FittedBox(
                  child: Text(
                    widget.helperText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: cancel, child: const Text("CANCEL")),
                    TextButton(onPressed: save, child: const Text("SAVE")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
