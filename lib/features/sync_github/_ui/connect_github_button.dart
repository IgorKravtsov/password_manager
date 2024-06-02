import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../bloc/connect_github_bloc.dart';

class ConnectGithubButton extends StatelessWidget {
  const ConnectGithubButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context
          .read<ConnectGithubBloc>()
          .add(const ConnectGithubGenerateDeviceCode()),
      child: BlocConsumer<ConnectGithubBloc, ConnectGithubState>(
        listener: (context, state) {
          if (state is ConnectGithubDeviceCodeGenerated) {
            _buildBottomSheet(context);
          }
        },
        builder: (context, state) {
          if (state is ConnectGithubLoading) {
            return const CircularProgressIndicator();
          }

          return const Text('Connect github');
        },
      ),
    );
  }

  Future<void> _buildBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 2,
        minWidth: double.infinity,
      ),
      builder: (BuildContext innerContext) {
        return BlocProvider.value(
          value: context.watch<ConnectGithubBloc>(),
          child: const Wrap(children: [
            GeneratedCodeView(),
          ]),
        );
      },
    );
  }
}

class GeneratedCodeView extends StatefulWidget {
  const GeneratedCodeView({super.key});

  @override
  State<GeneratedCodeView> createState() => _GeneratedCodeViewState();
}

class _GeneratedCodeViewState extends State<GeneratedCodeView> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectGithubBloc, ConnectGithubState>(
      builder: (context, state) {
        if (state is ConnectGithubDeviceCodeGenerated) {
          return Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(state.generateCodeResponse.userCode),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                              text: state.generateCodeResponse.userCode),
                        );
                        setState(() => _isCopied = true);
                        Timer? timer;
                        timer = Timer(
                          const Duration(seconds: 2),
                          () => setState(() {
                            _isCopied = false;
                            timer?.cancel();
                          }),
                        );
                      },
                      icon: const Icon(Icons.copy)),
                  _isCopied ? Text('Copied') : Container(),
                ],
              ),
              InkWell(
                onTap: () =>
                    launchUrlString(state.generateCodeResponse.verificationUri),
                child: const Text('Open browser'),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
