import 'package:flutter/material.dart';

class AllMoviesPage extends StatelessWidget {
  // Menerima parameter movies
  final List<dynamic> movies;

  AllMoviesPage({required this.movies}); // Konstruktor untuk menerima movies

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Movies'),
      ),
      body: movies.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Menambahkan pengecekan jika movies kosong
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['title']),
                  subtitle: Text(movie['release_date']),
                  onTap: () {
                    // Navigasi ke halaman detail film jika diklik
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: movie,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;
  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
              width: 150,
              height: 225,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              movie['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Release Date: ${movie['release_date']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              movie['overview'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
