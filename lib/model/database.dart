import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class Database<T> {
  Stream<List<T>> entities(MakeQuery makeQuery);
  Stream<T> entity(String id);
  Future<T> get(String id);
  Future<void> set(T entity);
  Future<void> delete(T entity);
}

abstract class Entity {
  final String id;
  Entity({@required this.id});
}

typedef MakeQuery = Query Function(CollectionReference collectionRef);

class AppDatabase<T extends Entity> implements Database<T> {
  static final _firestore = Firestore.instance;
  final CollectionReference collectionRef;
  final SnapshotEncoder encoder;
  final SnapshotDecoder decoder;

  AppDatabase(
      {@required String collectionName,
        @required this.encoder,
        @required this.decoder})
      : collectionRef = _firestore.collection(collectionName);

  Stream<List<T>> entities(MakeQuery makeQuery) {
    return makeQuery(collectionRef)
        .snapshots()
        .map((snap) => snap.documents.map((snap) => decoder.decode(snap)));
  }

  Stream<T> entity(String id) {
    final ref = collectionRef.document(id);
    return ref.snapshots().map((snap) => decoder.decode(snap));
  }

  Future<T> get(String id) async {
    final ref = collectionRef.document(id);
    return decoder.decode(await ref.get());
  }

  Future<void> set(T entity) async {
    final ref = collectionRef.document(entity.id);
    return ref.setData(encoder.encode(entity), merge: true);
  }

  Future<void> delete(T entity) async {
    final ref = collectionRef.document(entity.id);
    await ref.delete();
  }
}

abstract class SnapshotDecoder<T extends Entity> {
  T decode(DocumentSnapshot snap);
}

abstract class SnapshotEncoder<T extends Entity> {
  Map<String, dynamic> encode(T entity);
}
