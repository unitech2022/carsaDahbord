part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class GetPostDataLoad extends PostState {}

class GetPostDataSuccess extends PostState {
  final List<Post> posts;
  GetPostDataSuccess(this.posts);
}

class GetPostDataError extends PostState {}

// add  post
class AddPostDataLoad extends PostState {}

class AddPostDataSuccess extends PostState {}

class AddPostDataError extends PostState {}

// Update  post
class UpdatePostDataLoad extends PostState {}

class UpdatePostDataSuccess extends PostState {}

class UpdatePostDataError extends PostState {}

// delete  post
class DeletePostDataLoad extends PostState {}

class DeletePostDataSuccess extends PostState {}

class DeletePostDataError extends PostState {}

class GetCommentDataLoad extends PostState {}

class GetCommentDataSuccess extends PostState {}

class GetCommentDataError extends PostState {}

// add  post
class AddCommentDataLoad extends PostState {}

class AddCommentDataSuccess extends PostState {}

class AddCommentDataError extends PostState {}


// getOfferDetails
class GetOfferDetailsLoad extends PostState {}

class GetOfferDetailsSuccess extends PostState {}

class GetOfferDetailsError extends PostState {}


// accept Offer
class AcceptOfferLoad extends PostState {}

class AcceptOfferSuccess extends PostState {}

class AcceptOfferError extends PostState {}