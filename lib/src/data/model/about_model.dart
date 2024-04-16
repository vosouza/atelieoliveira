

class AboutModel {
  final String title;
  final String address;
  final String cep;
  final String number;
  final String termsUrl;

  const AboutModel({
    required this.title,
    required this.address,
    required this.cep,
    required this.number,
    required this.termsUrl,
  });

  factory AboutModel.fromJson(Map<String, dynamic> data) {
    return AboutModel(
      title: data['titulo'],
      address: data['endereco'],
      cep: data['cep'],
      number: data['tel'],
      termsUrl: data['termos'],
    );
  }
}
