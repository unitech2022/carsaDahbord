part of 'suggestion_cubit.dart';

@immutable
abstract class SuggestionState {}

class SuggestionInitial extends SuggestionState {}
class GetSuggestionDataLoad extends SuggestionState {}
class GetSuggestionDataSuccess extends SuggestionState {}
class GetSuggestionDataError extends SuggestionState {}


// add  post
class DeleteSuggestionDataLoad extends SuggestionState {}
class DeleteSuggestionDataSuccess extends SuggestionState {}
class DeleteSuggestionDataError extends SuggestionState {}


// add  post
class GetMessagesLoad extends SuggestionState {}
class GetMessagesSuccess extends SuggestionState {}
class GetMessagesError extends SuggestionState {}

// add  message
class AddMessagesLoad extends SuggestionState {}
class AddMessagesSuccess extends SuggestionState {}
class AddMessagesError extends SuggestionState {}

class ReplayAutoState extends SuggestionState {}
