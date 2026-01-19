import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchStarredRepos(String username) async {
  final url = await Uri.parse(
    'https://api.github.com/users/$username/starred',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((repo) {
      return {
        'name': repo['name'],
        'owner': repo['owner']['login'],
        'stars': repo['stargazers_count'],
        'url': repo['html_url'],
        'description': repo['description'],
      };
    }).toList();
  } else if (response.statusCode == 404) {
    throw Exception('Github user not found');
  } else if (response.statusCode == 403) {
    throw Exception('Rate limit exceeded (60/hour)');
  } else {
    throw Exception('something went wrong');
  }
}
