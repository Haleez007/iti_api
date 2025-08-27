import 'package:equatable/equatable.dart';
class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadingPostState extends PostState {}

class SuccessPostState extends PostState {
  final List posts;
  SuccessPostState({required this.posts});
  @override
  List<Object?> get props => [posts];
}
class ErrorPostState extends PostState {
  final String message;
  ErrorPostState({required this.message});
  @override
  List<Object?> get props => [message];
}