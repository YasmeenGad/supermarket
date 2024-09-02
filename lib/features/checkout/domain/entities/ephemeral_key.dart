import 'package:equatable/equatable.dart';

class EphemeralKey extends Equatable {
  final String id;
  final String object;
  final List<AssociatedObject> associatedObjects;
  final int created;
  final int expires;
  final bool livemode;
  final String secret;

  EphemeralKey({
    required this.id,
    required this.object,
    required this.associatedObjects,
    required this.created,
    required this.expires,
    required this.livemode,
    required this.secret,
  });

  @override
  List<Object?> get props => [
        id,
        object,
        associatedObjects,
        created,
        expires,
        livemode,
        secret, 
      ];
}

class AssociatedObject extends Equatable {
  final String id;
  final String type;

  AssociatedObject({
    required this.id,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        type,
      ];
}
