import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';

class TmpEdit extends StatelessWidget {
  final PasswordFileModel passwordFileModel;

  const TmpEdit({required this.passwordFileModel, super.key});

  void _handleEdit(
    BuildContext context,
    int index,
    String title,
    String content,
  ) async {
    final List<PasswordFileSegmentModel> copy =
        List.from(passwordFileModel.segments);

    copy[index] = PasswordFileSegmentModel(
      title: title,
      content: content,
    );

    final text = await PasswordFileEncrypter(contentEncrypter: AESEncrypter())
        .encryptSegments(copy, passwordFileModel.secretKey);

    final file = File(passwordFileModel.pathToFile);
    await file.writeAsString(text);

    log('Encrypted file: $text');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(passwordFileModel.pathToFile),
          const SizedBox(height: 40),
          // for (var (index, segment) in model.segments.indexed)
          //   PasswordFileEditSegment(
          //     segment: segment,
          //     config: config,
          //   ),
          // ...model.segments
          //     .map((segment) => PasswordFileEditSegment(
          //           segment: segment,
          //           config: config,
          //         ))
          //     .toList(),
          ...passwordFileModel.segments
              .asMap()
              .map((index, segment) => MapEntry(
                    index,
                    PasswordFileEditSegment(
                      segment: segment,
                      index: index,
                      onSave: _handleEdit,
                    ),
                  ))
              .values
              .toList()
        ],
      ),
    );
  }
}

class PasswordFileEditSegment extends StatefulWidget {
  final PasswordFileSegmentModel segment;
  final int index;
  final Function(
    BuildContext context,
    int index,
    String title,
    String content,
  ) onSave;

  const PasswordFileEditSegment({
    required this.segment,
    required this.index,
    required this.onSave,
    super.key,
  });

  @override
  State<PasswordFileEditSegment> createState() =>
      _PasswordFileEditSegmentState();
}

class _PasswordFileEditSegmentState extends State<PasswordFileEditSegment> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSave(
      context,
      widget.index,
      _titleController.text,
      _contentController.text,
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
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a content';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _titleController.text = widget.segment.title;
                      _contentController.text = widget.segment.content;
                    });
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _handleSave,
                  child: const Text('Save'),
                ),
              ],
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
