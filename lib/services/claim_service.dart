import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaimService {
  final String baseUrl = 'http://your-nodejs-backend-url'; // Replace with your backend URL

  Future<void> submitClaim({
    required String fullname,
    required String mobileNumber,
    required String lostDate,
    required String lostLocation,
    required String attachedDetails,
    required String proofOfOwnership,
  }) async {
    final url = Uri.parse('$baseUrl/claims'); // Adjust endpoint as needed

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullname': fullname,
        'mobileNumber': mobileNumber,
        'lostDate': lostDate,
        'lostLocation': lostLocation,
        'attachedDetails': attachedDetails,
        'proofOfOwnership': proofOfOwnership,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit claim: ${response.body}');
    }
  }

  declineClaim(String claimId) {}

  approveClaim(String claimId) {}

  getClaimById(String claimId) {}
}
class ClaimService {
  Future<void> requestMoreInfo(String claimId, List<String> questions) async {
    // Implement your API call here
    throw UnimplementedError();
  }

  getClaimById(String claimId) {}

  approveClaim(String claimId) {}

  declineClaim(String claimId) {}

  submitClaim({required String fullname, required String mobileNumber, required String lostDate, required String lostLocation, required String attachedDetails, required String proofOfOwnership}) {}
}
