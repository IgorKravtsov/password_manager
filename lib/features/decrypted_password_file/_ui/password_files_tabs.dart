import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/features/decrypted_password_file/_vm/cubit/password_files_decrypted_cubit.dart';

class PasswordFilesTabs extends StatelessWidget {
  final int selectedFileIndex;
  final List<PasswordFileModel> decryptedFiles;

  const PasswordFilesTabs({
    super.key,
    required this.selectedFileIndex,
    required this.decryptedFiles,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: selectedFileIndex == -1 ? 0 : selectedFileIndex,
      length: decryptedFiles.length,
      animationDuration: Durations.short2,
      child: TabBar(
        onTap: (value) => context
            .read<PasswordFilesDecryptedCubit>()
            .selectFile(decryptedFiles[value]),
        isScrollable: true,
        dividerColor: Colors.transparent,
        tabs: decryptedFiles
            .map((e) => Tab(
                  text: e.fileName,
                  height: 60,
                ))
            .toList(),
      ),
    );
  }
}
