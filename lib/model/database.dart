import 'package:taskshare/export/export_model.dart';

typedef MakeQuery = Query Function(CollectionReference collectionRef);

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

class AppDatabase<T extends Entity> implements Database<T> {
  final CollectionReference collectionRef;
  final SnapshotEncoder<T> encoder;
  final SnapshotDecoder<T> decoder;

  AppDatabase({
    @required this.collectionRef,
    @required this.encoder,
    @required this.decoder,
  });

  Stream<List<T>> entities(MakeQuery makeQuery) {
    return makeQuery(collectionRef).snapshots().map((snap) {
      return snap.documents.map((snap) {
        return decoder.decode(snap.documentID, snap.data);
      }).toList();
    });
  }

  Stream<T> entity(String id) {
    final ref = collectionRef.document(id);
    return ref.snapshots().map((snap) => decoder.decode(snap.documentID, snap.data));
  }

  Future<T> get(String id) async {
    final ref = collectionRef.document(id);
    return decoder.decode(ref.documentID, (await ref.get()).data);
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
  T decode(String documentID, Map<String, dynamic> data);
}

abstract class SnapshotEncoder<T extends Entity> {
  Map<String, dynamic> encode(T entity);
}
