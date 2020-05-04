/// Like python's dict.get("key", "default_value")
extension DefaultMap<K, V> on Map<K, V> {
  V get(K key, {V defaultValue}) {
    print("$this");
    if (this.containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}
