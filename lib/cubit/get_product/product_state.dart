import 'package:equatable/equatable.dart';
class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}
final class ProductInitial extends ProductState{}
class LoadingProductState extends ProductState{}
class SuccessProductState extends ProductState {
  final List product;

  SuccessProductState({required this.product});

  @override
  List<Object?> get props => [product];
}
class ErrorProductState extends ProductState {
  final String error;

  ErrorProductState({required this.error});

  @override
  List<Object?> get props => [error];
}