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
  static const idKey = 'id';
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

  @override
  Stream<List<T>> entities(MakeQuery makeQuery) =>
      makeQuery(collectionRef).snapshots().map((snap) => snap.documents
          .map((snap) =>
              decoder.decode(snap.data..[Entity.idKey] = snap.documentID))
          .toList());

  @override
  Stream<T> entity(String id) {
    final ref = collectionRef.document(id);
    return ref.snapshots().map(
        (snap) => decoder.decode(snap.data..[Entity.idKey] = snap.documentID));
  }

  @override
  Future<T> get(String id) async {
    final ref = collectionRef.document(id);
    return decoder
        .decode((await ref.get()).data..[Entity.idKey] = ref.documentID);
  }

  @override
  Future<void> set(T entity) async {
    final ref = collectionRef.document(entity.id);
    return ref.setData(encoder.encode(entity)..remove(Entity.idKey),
        merge: true);
  }

  @override
  Future<void> delete(T entity) async {
    final ref = collectionRef.document(entity.id);
    await ref.delete();
  }
}

abstract class SnapshotDecoder<T extends Entity> {
  T decode(Map<String, dynamic> data);
}

abstract class SnapshotEncoder<T extends Entity> {
  Map<String, dynamic> encode(T entity);
}
