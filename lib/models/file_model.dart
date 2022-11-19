class File {
  String thumbnailURL;
  String fileURL;
  String author;
  String title;
  String duration;

  File(
      {required this.thumbnailURL,
      required this.fileURL,
      required this.author,
      required this.title,
      required this.duration});
}

final List<File> files = [
  File(
      thumbnailURL: 'bpqtuqpdeh.jpg',
      fileURL:
          'we-rollin-gangsta-mashup-2022-sidhu-moosewala-ap-dhillon-shubh-karan-aujla-mahesh-suthar.mp3',
      author:
          'Sidhu Moosewala | Ap Dhillon | Shubh | Karan Aujla | Mahesh Suthar',
      title: 'We Rollin | Gangsta Mashup 2022',
      duration: '5:11'),
  File(
      thumbnailURL: 'eoopbegakc.jpg',
      fileURL:
          'the-gangsters-mashup-sidhu-moose-wala-x-shubh-dj-sumit-rajwanshi-sr-music-official.mp3',
      author:
          'Sidhu Moose Wala X Shubh | DJ Sumit Rajwanshi | SR Music Official',
      title: 'The Gangsters Mashup',
      duration: '5:55'),
  File(
      thumbnailURL: 'csgipdevqk.jpg',
      fileURL:
          'we-rollin-slowed-reverb-shubh-latest-trending-punjabi-song-lofi-partner.mp3',
      author: 'SHUBH | Latest Trending | Punjabi Song | LOFI Partner',
      title: 'We Rollin [Slowed + Reverb]',
      duration: '3:41'),
];
