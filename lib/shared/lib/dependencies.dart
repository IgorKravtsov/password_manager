import 'package:flutter/material.dart';
import 'package:password_manager/entities/password_file/password_file.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';

//TODO: finish with this implementation

abstract interface class IDependencies {
  /// The state from the closest instance of this class.
  factory IDependencies.of(BuildContext context) =>
      InheritedDependencies.of(context);

  abstract final IContentEncrypter contentEncrypter;
  abstract final IPasswordFileEncrypter passwordFileEncrypter;
  abstract final IDecryptedPasswordFileSaver decryptedPasswordFileSaver;
}

/// {@template inherited_dependencies}
/// InheritedDependencies widget.
/// {@endtemplate}
class InheritedDependencies extends InheritedWidget {
  /// {@macro inherited_dependencies}
  const InheritedDependencies({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final IDependencies dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `InheritedDependencies.maybeOf(context)`.
  static IDependencies? maybeOf(BuildContext context) => (context
          .getElementForInheritedWidgetOfExactType<InheritedDependencies>()
          ?.widget as InheritedDependencies?)
      ?.dependencies;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a InheritedDependencies of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `InheritedDependencies.of(context)`
  static IDependencies of(BuildContext context) =>
      maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedDependencies oldWidget) => false;
}
