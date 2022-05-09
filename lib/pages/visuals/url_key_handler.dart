List<String> url_key_finder(List<String> yt_url) {
  // spits out url key of youtube url string
  // https://www.youtube.com/watch?v=5qap5aO4i9A
  // https://www.youtube.com/watch?v=esDlUtMQmeU
  // this is the video id            x->
  // everything aftter the '='
  int key_start = 32;
  int size = yt_url.length;
  List<String> res = [];
  for (int i = 0; i < size; i++) {
    res.add(yt_url[i].substring(key_start, key_start + 11));
  }
  return res;
}
