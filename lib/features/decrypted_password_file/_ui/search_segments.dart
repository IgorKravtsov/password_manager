import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/generated/l10n.dart';

import '../_vm/cubit/password_files_decrypted_cubit.dart';

class SearchSegments extends StatefulWidget {
  final int debounceDuration;

  const SearchSegments({
    super.key,
    this.debounceDuration = 300,
  });

  @override
  State<SearchSegments> createState() => _SearchSegmentsState();
}

class _SearchSegmentsState extends State<SearchSegments> {
  Timer? _searchTimer;
  String _searchText = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.text =
        context.read<PasswordFilesDecryptedCubit>().state.searchText;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String text) {
    _searchText = text;

    _searchTimer?.cancel();
    _searchTimer = Timer(Duration(milliseconds: widget.debounceDuration), () {
      context.read<PasswordFilesDecryptedCubit>().saveSearch(_searchText);
    });
  }

  void _clearSearch() {
    context.read<PasswordFilesDecryptedCubit>().saveSearch('');
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
            labelText: S.of(context).search,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: _clearSearch, icon: const Icon(Icons.clear)),
            border: const OutlineInputBorder()),
        onChanged: _onSearchChanged,
      ),
    );
  }
}
