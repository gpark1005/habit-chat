import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.displayName,
    this.emailVerified,
    this.metadata,
    this.phoneNumber,
    this.providerData,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// The current user's display name.
  final String? displayName;

  /// Whether the user's email has been verified.
  final bool? emailVerified;

  /// Additional metadata about the user.
  final dynamic metadata;

  /// The current user's phone number.
  final String? phoneNumber;

  /// Additional provider-specific information about the user.
  final dynamic providerData;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  @override
  List<Object?> get props => [email, id, name, photo];
}
