/// Like python's dict.get("key", "default_value").
extension DefaultMap<K, V> on Map<K, V> {
  V get(K key, V defaultValue) {
    return this.containsKey(key) ? this[key] : defaultValue;
  }
}

/// Turn things into lists.
List<T> listify<T>(dynamic listlike) {
  if (listlike == null) return [].cast<T>();
  if (listlike is List) return listlike.cast<T>();
  if (listlike is Iterable) return List.from(listlike).cast<T>();
  return [listlike].cast<T>();
}
