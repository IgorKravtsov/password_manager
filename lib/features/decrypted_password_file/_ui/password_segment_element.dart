import 'package:flutter/material.dart';

import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/generated/l10n.dart';

class PasswordFileSegmentElement extends StatefulWidget {
  final PasswordFileSegmentModel segment;
  final int? index;

  final void Function({
    required BuildContext context,
    required PasswordFileSegmentModel segment,
    int? index,
  })? onSave;

  final void Function({
    required BuildContext context,
    required int index,
  })? onDelete;

  const PasswordFileSegmentElement({
    required this.segment,
    this.index,
    this.onSave,
    super.key,
    this.onDelete,
  });

  @override
  State<PasswordFileSegmentElement> createState() =>
      _PasswordFileSegmentElementState();
}

class _PasswordFileSegmentElementState
    extends State<PasswordFileSegmentElement> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSave?.call(
      context: context,
      segment: widget.segment.copyWith(
        title: _titleController.text,
        content: _contentController.text,
      ),
      index: widget.index,
    );
  }

  @override
  void initState() {
    _titleController.text = widget.segment.title;
    _contentController.text = widget.segment.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: S.of(context).title,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).pleaseEnterATitle;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: S.of(context).content,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).pleaseEnterAContent;
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SegmentButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _titleController.text = widget.segment.title;
                      _contentController.text = widget.segment.content;
                    });
                  },
                  disabled: widget.segment.title == '' &&
                      widget.segment.content == '',
                  child: Text(S.of(context).revert),
                ),
                SegmentButton(
                  onPressed: _handleSave,
                  child: Text(S.of(context).save),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SegmentButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).cancel),
                ),
                SegmentButton(
                  disabled: widget.index == null,
                  onPressed: () {
                    widget.onDelete
                        ?.call(context: context, index: widget.index!);
                  },
                  child: Icon(Icons.delete,
                      color: widget.index == null
                          ? Colors.transparent
                          : Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SegmentButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool disabled;

  const SegmentButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width > 700 ? 300 : 150,
        minHeight: 50,
      ),
      child: TextButton(
        onPressed: !disabled ? onPressed : null,
        style: style,
        child: child,
      ),
    );
  }
}
