import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';

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
      final newSegmentIdx =
          segments.indexWhere((element) => element.id == segment.id);
      segments[newSegmentIdx] = segment;
    }
    final navigator = Navigator.of(context);
    await context.read<PasswordFilesDecryptedCubit>().saveSegments(
          passwordFile: widget.passwordFile,
          segments: segments,
        );
    if (navigator.canPop()) navigator.pop();
    //TODO: find the way to rerender the list after saving data
    setState(() {});
  }

  void _handleDelete(String? id) async {
    final segments = widget.passwordFile.segments;
    segments.removeWhere((element) => element.id == id);
    final navigator = Navigator.of(context);
    await context.read<PasswordFilesDecryptedCubit>().saveSegments(
        passwordFile: widget.passwordFile,
          segments: segments,
        );
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

            if (widget.passwordFile.isError == true) {
              return ErrorMessage(widget: widget);
            }

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

            return ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: searchedSegments.length,
              buildDefaultDragHandles: searchText.isEmpty,
              onReorder:
                  context.read<PasswordFilesDecryptedCubit>().reorderSegments,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(searchedSegments[index]),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                      return await _showDeleteDialog(
                        context: context,
                      id: searchedSegments[index].id,
                    );
                  },
                  child: ListTile(
                    title: Text(searchedSegments[index].title),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    subtitle: Text(_getSegmentContent(searchedSegments[index])),
                    onTap: () => _buildBottomSheet(
                      context,
                      searchedSegments[index],
                      index,
                    ),
                  ),
                );
              },
              
            );
          },
        ),
        Positioned(
          bottom: 30,
          right: 30,
          width: 60,
          height: 60,
          child: FloatingActionButton(
            tooltip: S.of(context).add,
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
          Text(S.of(context).noSegmentsFound),
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
            child: Text(
              S.of(context).addIt,
            ),
          ),
        ],
      ));

  Future<void> _buildBottomSheet(
      BuildContext context, PasswordFileSegmentModel segment, int? index) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 2,
        minWidth: double.infinity,
      ),
      builder: (BuildContext innerContext) {
        return BlocProvider.value(
          value: context.watch<PasswordFilesDecryptedCubit>(),
          child: Wrap(children: [
            Column(
              children: [
                const SizedBox(height: 40),
                PasswordFileSegmentElement(
                  segment: segment,
                  index: index,
                  onSave: _handleSave,
                  onDelete: _showDeleteDialog,
                ),
                // const SizedBox(height: 10)
              ],
            ),
          ]
          ),
        );
      },
    );
  }

  Future<bool?> _showDeleteDialog({
    required BuildContext context,
    String? id,
  }) {
    return showDialog<bool?>(
      context: context,
      builder: (innerContext) {
        return BlocProvider.value(
          value: context.watch<PasswordFilesDecryptedCubit>(),
          child: AlertDialog(
            title: Text(S.of(context).areYouSureYouWantToDeleteThisItem),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                onPressed: () {
                  _handleDelete(id);
                  Navigator.of(context).pop(true);
                },
                style: const ButtonStyle().copyWith(
                  foregroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
                child: Text(S.of(context).delete),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.widget,
  });

  final PasswordFileEditableSegments widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - heightDiffForAddButton,
        maxHeight: MediaQuery.of(context).size.height - heightDiffForAddButton,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.passwordFile.errorMessage ?? '',
              style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.error,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Error with this file or password. Please check the file or try to decrypt it again.',
              style: const TextStyle().copyWith(
                color: Theme.of(context).colorScheme.error,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.go(Location.files);
              },
              child: Text(S.of(context).lookConfiguration),
            ),
            const SizedBox(height: 10),
            Text(S.of(context).or.toUpperCase()),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.go(Location.settings);
              },
              child: Text(S.of(context).settings),
            ),
          ],
        ),
      ),
    );
  }
}
