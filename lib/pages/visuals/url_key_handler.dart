List<String> urlKeyFinder(List<String> ytUrl) {
  // spits out url key of youtube url string
  // https://www.youtube.com/watch?v=5qap5aO4i9A
  // https://www.youtube.com/watch?v=esDlUtMQmeU
  // this is the video id            x->
  // everything aftter the '='
  int keyStart = 32;
  int size = ytUrl.length;
  List<String> res = [];
  for (int i = 0; i < size; i++) {
    res.add(ytUrl[i].substring(keyStart, keyStart + 11));
  }
  return res;
}
