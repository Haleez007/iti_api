import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_api/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(LoadingPostState());
  Future<void> updatePost() async {
    emit(LoadingPostState());
    try {
      final response = await get(
        Uri.parse( "https://dummyjson.com/products"),
        headers: {
          'Accept': 'application/json',
        },
      );
      final body = jsonDecode(response.body);
      List responseBody = body['products'];
      emit(SuccessPostState(posts: responseBody));
    } catch (e) {
      emit(ErrorPostState(message: 'Error $e'));
    }
  }
}
