import 'package:bizzilly/repositories/Repositories.dart';
import 'package:rxdart/rxdart.dart';

class SuggestionBloc 
{
  Repositories repositories = Repositories();
  final name = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final message = BehaviorSubject<String>();

  Function(String) get getName => name.sink.add;
  Function(String) get getEmail => email.sink.add;
  Function(String) get getMessage => message.sink.add;

  Future<String> postSuggestion()
  {  
    return repositories.postSuggestion(name.value, email.value, message.value);
  }
}
final suggestionBloc = SuggestionBloc();