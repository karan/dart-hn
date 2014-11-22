import 'dart:html';
import 'dart:convert';
import 'dart:math';

const String TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json';
const String STORY_URL = 'https://hacker-news.firebaseio.com/v0/item/ID.json';
const int MAX_STORIES = 30;

void main() {
  getTopIds();
}

void getTopIds() {
  HttpRequest.getString(TOP_STORIES_URL).then(getStories);
}

void getStories(String data) {
  List decoded = JSON.decode(data);
  List finalObjs = new List();

  int processed_counter = 0;
  int max_items = min(decoded.length, MAX_STORIES);

  for (var i = 0; i < max_items; i++) {
    HttpRequest.getString(STORY_URL.replaceFirst('ID', decoded[i].toString())).then((str) {
      Map obj = JSON.decode(str);
      querySelector('#hn').children.add(new LIElement()
                                            ..append(new AnchorElement()
                                                         ..href = obj['url']
                                                         ..text = obj['title']
                                                         ..target = '_blank'));
    });
  }
}
