
class Photo{
  final String photo_reference;

  Photo({required this.photo_reference});

  factory Photo.fromJson(Map<String,dynamic> parsedJson){
    return Photo(
      photo_reference: parsedJson['photo_reference'] as String,
    );
  }
}