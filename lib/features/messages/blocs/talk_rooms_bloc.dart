

// class TalkRoomsBloc
//     extends StateNotifier<Stream<List<TalkRoomsResponseModel>>> {
//   TalkRoomsBloc(TalkRoomsProvider provider)
//       : super(provider.chatRoomListStream.asBroadcastStream());
// }

// final talkRoomsStateProvider =
//     StateNotifierProvider<TalkRoomsBloc, Stream<List<TalkRoomsResponseModel>>>(
//   (ref) {
//     return TalkRoomsBloc(ref.watch(talkRoomsProvider));
//   },
// );