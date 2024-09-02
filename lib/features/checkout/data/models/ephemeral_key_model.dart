import 'package:supermarket/features/checkout/domain/entities/ephemeral_key.dart';

class EphemeralKeyModel extends EphemeralKey {
  EphemeralKeyModel({
    required String id,
    required String object,
    required List<AssociatedObjectModel> associatedObjects,
    required int created,
    required int expires,
    required bool livemode,
    required String secret,
  }) : super(
          id: id,
          object: object,
          associatedObjects: associatedObjects,
          created: created,
          expires: expires,
          livemode: livemode,
          secret: secret,
        );

  factory EphemeralKeyModel.fromJson(Map<String, dynamic> json) {
    return EphemeralKeyModel(
      id: json['id'],
      object: json['object'],
      associatedObjects: (json['associated_objects'] as List)
          .map((e) => AssociatedObjectModel.fromJson(e))
          .toList(),
      created: json['created'],
      expires: json['expires'],
      livemode: json['livemode'],
      secret: json['secret'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'associated_objects': associatedObjects.map((e) => (e as AssociatedObjectModel).toJson()).toList(),
      'created': created,
      'expires': expires,
      'livemode': livemode,
      'secret': secret,
    };
  }
}

class AssociatedObjectModel extends AssociatedObject {
  AssociatedObjectModel({
    required String id,
    required String type,
  }) : super(id: id, type: type);

  factory AssociatedObjectModel.fromJson(Map<String, dynamic> json) {
    return AssociatedObjectModel(
      id: json['id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }
}
