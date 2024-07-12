List<T> getLatestElements<T>(List<T> list, int count) {
  if (list.length <= count) {
    return list;
  } else {
    return list.sublist(list.length - count);
  }
}
