import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:frienderr/core/failure/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frienderr/features/domain/entities/comment.dart';
import 'package:frienderr/features/domain/usecases/comment/get_comments_usecase.dart';
import 'package:frienderr/features/domain/usecases/comment/post_comment_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';
part 'comment_bloc.freezed.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsUseCase _getCommentsUsecase;
  final PostCommentUseCase _postCommentUsecase;

  CommentBloc(this._getCommentsUsecase, this._postCommentUsecase)
      : super(CommentState(comments: [])) {
    on<_GetComments>(_getComment);
    on<_PostComment>(_postComment);
  }

  Future<void> _getComment(
      _GetComments event, Emitter<CommentState> emit) async {
    emit(state.copyWith(currentState: CommentStatus.Loading));
    final Either<Failure, List<CommentEntity>> _either =
        await _getCommentsUsecase(GetCommentsParams(event.postId));
    return _either.fold((Failure error) {
      emit(state.copyWith(
          currentState: CommentStatus.Faliure, error: error.message));
    }, (List<CommentEntity> comments) {
      emit(state.copyWith(
          comments: comments, currentState: CommentStatus.Loaded));
    });
  }

  Future<void> _postComment(
      _PostComment event, Emitter<CommentState> emit) async {
    emit(state.copyWith(currentState: CommentStatus.Loading));
    final Either<Failure, bool> _either = await _postCommentUsecase(
        PostCommentUseCaseParams(event.comment, event.postId));
    return _either.fold((Failure error) {
      emit(state.copyWith(
          currentState: CommentStatus.Faliure, error: error.message));
    }, (bool success) {
      // emit(state.copyWith(
      //     comments: comments, currentState: CommentStatus.Loaded));
    });
  }
}
