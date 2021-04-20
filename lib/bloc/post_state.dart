part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostFailure extends PostState {}

class PostSuccess extends PostState {
  final List<PostModel> posts;

  PostSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}
