import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lightning_/data/models/song/song.dart';
import 'package:lightning_/domain/entities/song/song.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlaylist();
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
      return Right(songs);
    } catch (e) {
      print("inside catch :");
      print(e);
      return const Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs = [];
      print("Fetching data from Firestore");

      var querySnapshot = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(7)
          .get();

      print("Found ${querySnapshot.docs.length} documents");

      for (var doc in querySnapshot.docs) {
        print("Processing document ${doc.id}");
        print("Document data: ${doc.data()}"); // Add this to see raw data

        try {
          var songModel = SongModel.fromJson(doc.data());
          songs.add(songModel.toEntity());
        } catch (e) {
          print("Error processing document ${doc.id}: $e");
          print("Problematic data: ${doc.data()}");
        }
      }

      return Right(songs);
    } catch (e) {
      print("Error in getPlaylist: $e");
      return Left('Failed to load playlist: $e');
    }
  }
}
