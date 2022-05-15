String urlKey(String ytUrl) {
  // spits out url key of youtube url string
  // https://www.youtube.com/watch?v=5qap5aO4i9A
  // https://www.youtube.com/watch?v=esDlUtMQmeU
  // this is the video id            x->
  // everything aftter the '='
  int i = 32;
  return ytUrl.substring(i, i + 11);
}
