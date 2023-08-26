class mymovie {
  int? id;
  String? movieTitle;
  String? movieDuration;
  String? releaseDate;
  String? mPoster;
  String? poster;

  mymovie(
      {this.id,
      this.movieTitle,
      this.movieDuration,
      this.releaseDate,
      this.mPoster,
      this.poster});

  mymovie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movieTitle = json['movie_title'].toString();
    movieDuration = json['movie_duration'].toString();
    releaseDate = json['release_date'].toString();
    mPoster = json['m_poster'].toString();
    poster = json['poster'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['movie_title'] = this.movieTitle;
    data['movie_duration'] = this.movieDuration;
    data['release_date'] = this.releaseDate;
    data['m_poster'] = this.mPoster;
    data['poster'] = this.poster;
    return data;
  }
}
