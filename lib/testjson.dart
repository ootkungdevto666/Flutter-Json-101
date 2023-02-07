import 'dart:convert';

void testjson() {
  var JsonEx = '{"key":"value"}'; //this is json with Encoded
  Map<String, dynamic> map_data = jsonDecode(JsonEx);
  print(map_data["key"]);
}

List<QuizModel> quizModelFromJson(String str) {
  return List<QuizModel>.from(
      json.decode(str).map((x) => QuizModel.fromJson(x)));
}

class QuizModel {
  QuizModel(
      {required this.title, required this.choice, required this.answerID});
  String title;
  List<Choice> choice;
  int answerID;

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
        title: json["title"],
        choice:
            List<Choice>.from(json["choice"].map((x) => Choice.fromJson(x))),
        answerID: json["answer"]);
  }
}

class Choice {
  Choice({required this.id, required this.title});
  int id;
  String title;
  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(id: json["ID"], title: json["title"]);
  }
}
