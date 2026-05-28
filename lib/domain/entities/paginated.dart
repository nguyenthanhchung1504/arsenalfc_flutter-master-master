/// Cursor-based pagination — `cursor` đại diện cho `DocumentSnapshot` ở Firestore
/// (opaque đối với UI).
class Paginated<T> {
  const Paginated({
    required this.items,
    this.nextCursor,
  });

  final List<T> items;
  final Object? nextCursor;

  bool get hasMore => nextCursor != null;

  static Paginated<T> empty<T>() => Paginated<T>(items: const []);
}
