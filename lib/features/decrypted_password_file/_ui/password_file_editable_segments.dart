import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/entities/password_file/password_file.dart';

import '../_vm/cubit/password_files_decrypted_cubit.dart';
import 'password_segment_element.dart';

const maxContentLength = 60;
const heightDiffForAddButton = 250;

enum PasswordFileSegmentElementView { list, grid }

class PasswordFileEditableSegments extends StatefulWidget {
  final PasswordFileModel passwordFile;

  const PasswordFileEditableSegments(
    this.passwordFile, {
    super.key,
  });

  @override
  State<PasswordFileEditableSegments> createState() =>
      _PasswordFileEditableSegmentsState();
}

class _PasswordFileEditableSegmentsState
    extends State<PasswordFileEditableSegments> {
  void _handleSave({
    required BuildContext context,
    required PasswordFileSegmentModel segment,
    int? index,
  }) async {
    final isNew = index == null;
    final segments = widget.passwordFile.segments;
    if (isNew) {
      segments.insert(0, segment);
    } else {
      segments[index] = segment;
    }
    final completer = Completer<void>();
    final navigator = Navigator.of(context);
    context.read<PasswordFilesDecryptedCubit>().saveSegments(
          passwordFile: widget.passwordFile,
          segments: segments,
          completer: completer,
        );
    await completer.future;
    navigator.pop();
    //TODO: find the way to rerender the list after saving data
    setState(() {});
  }

  void _handleDelete(int index) async {
    final segments = widget.passwordFile.segments;
    segments.removeAt(index);
    final completer = Completer<void>();
    final navigator = Navigator.of(context);
    context.read<PasswordFilesDecryptedCubit>().saveSegments(
        passwordFile: widget.passwordFile,
        segments: segments,
        completer: completer);
    await completer.future;
    if (navigator.canPop()) navigator.pop();
    setState(() {});
  }

  String _getSegmentContent(PasswordFileSegmentModel segment) {
    return segment.content.length > maxContentLength
        ? '${segment.content.substring(0, maxContentLength).replaceAll('\n\n\n\n', '\n')}...'
        : segment.content;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - heightDiffForAddButton,
        maxHeight: MediaQuery.of(context).size.height - heightDiffForAddButton,
      ),
      child: Stack(children: [
        BlocBuilder<PasswordFilesDecryptedCubit, DecryptedPasswordFilesState>(
          builder: (context, state) {

            if (widget.passwordFile.segments.isEmpty) {
              return _buildEmptyState();
            }

            final searchText = state.searchText.toLowerCase();
            final searchedSegments =
                widget.passwordFile.segments.where((element) {
              final title = element.title.toLowerCase();
              final content = element.content.toLowerCase();
              return title.contains(searchText) || content.contains(searchText);
            }).toList();

            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: searchedSegments.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final segment = searchedSegments[index];
                  return ListTile(
                      title: Text(segment.title),
                      subtitle: Text(_getSegmentContent(segment)),
                      onTap: () => _buildBottomSheet(context, segment, index),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteDialog(
                          context: context,
                          index: index,
                        ),
                      ));
                });
          },
        ),
        Positioned(
          bottom: 30,
          right: 30,
          width: 75,
          height: 75,
          child: FloatingActionButton(
            tooltip: 'Add',
            onPressed: () {
              _buildBottomSheet(
                  context,
                  const PasswordFileSegmentModel(
                    content: '',
                    title: '',
                  ),
                  null);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ]),
    );
  }

  Center _buildEmptyState() => Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('No segments found'),
          const SizedBox(height: 20),
          FilledButton(
              onPressed: () {
                _buildBottomSheet(
                    context,
                    const PasswordFileSegmentModel(
                      content: '',
                      title: '',
                    ),
                    null);
              },
              child: const Text(
                'Add it!',
              )),
        ],
      ));

  Future<void> _buildBottomSheet(
      BuildContext context, PasswordFileSegmentModel segment, int? index) {
    return showModalBottomSheet<void>(
      context: context,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        minWidth: double.infinity,
      ),
      builder: (BuildContext innerContext) {
        return BlocProvider.value(
          value: context.watch<PasswordFilesDecryptedCubit>(),
          child: Column(
            children: [
              const SizedBox(height: 40),
              PasswordFileSegmentElement(
                segment: segment,
                index: index,
                onSave: _handleSave,
                onDelete: _showDeleteDialog,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog({required BuildContext context, required int index}) {
    showDialog(
      context: context,
      builder: (innerContext) {
        return BlocProvider.value(
          value: context.watch<PasswordFilesDecryptedCubit>(),
          child: AlertDialog(
            title: const Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _handleDelete(index);
                  Navigator.of(context).pop();
                },
                style: const ButtonStyle().copyWith(
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
