import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_movieapp/Pages/AllMoviepage.dart';
import 'package:flutter_application_movieapp/Pages/Detailpage.dart'
    as Detail; // Pastikan untuk mengimpor halaman detail
import 'package:flutter_application_movieapp/Pages/UserAccountpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _popularMovies = [];
  int _currentIndex = 0;

  // Fungsi untuk fetch data dari API
  Future<void> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMjRiNTAyM2IxMDY1NzNhZTljYzhmNjcxMmQ2YWQyNSIsIm5iZiI6MTczMzE4NDk5Ni4wMTUsInN1YiI6IjY3NGU0ZGU0YjIwOWUwMWVhYTg5ODIwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gPLcQ31Lpu39yxR43r_I_Te7FiaT5jqjXCFcOGHxJ0w',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _popularMovies = data['results'];
      });
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Hello Nabilla!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        body: _buildHomePage(),
      ),
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text('All Movies', style: TextStyle(color: Colors.white)),
        ),
        body: AllMoviesPage(movies: _popularMovies),
      ),
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text('User Account', style: TextStyle(color: Colors.white)),
        ),
        body: UserAccountPage(),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'All Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  // Halaman utama (HomePage)
  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: 'Search your favorite movie',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Category Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip('Romance', Icons.favorite, Colors.pink),
                _buildCategoryChip(
                    'Comedy', Icons.sentiment_very_satisfied, Colors.yellow),
                _buildCategoryChip('Action', Icons.sports_mma, Colors.red),
                _buildCategoryChip('Horror', Icons.mood_bad, Colors.purple),
              ],
            ),
          ),
          // Popular Movies Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularMovies.length,
              itemBuilder: (context, index) {
                var movie = _popularMovies[index];
                return _buildMovieCard(movie);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan chip kategori
  Widget _buildCategoryChip(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Chip(
        backgroundColor: Colors.grey[900],
        avatar: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan kartu film
  Widget _buildMovieCard(dynamic movie) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail film
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail.MovieDetailPage(movie: movie),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                  height: 220,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                movie['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                '⭐ ${movie['vote_average']}',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
