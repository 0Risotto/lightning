import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lightning_/data/models/song/song.dart';
import 'package:lightning_/domain/entities/song/song.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());

        songs.add(songModel.toEntity());
      }
      print("before right rn");
      return Right(songs);
    } catch (e) {
      print("inside catch :");
      print(e);
      return const Left('An error occurred, Please try again.');
    }
  }
}
