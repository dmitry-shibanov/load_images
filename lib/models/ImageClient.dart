import 'package:http/http.dart';

class ImageClient {
  Client client = new Client();


  Future<Response> getImage(int number) async {
    String url = "https://jsonplaceholder.typicode.com/photos/${number.toString()}";
    Response response = await client.get(url);

    return response;
  }
}