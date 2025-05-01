import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/models/claim.dart';
import '../services/claim_service.dart';
class ClaimInfoProvider extends ChangeNotifier {
  Claim? _claim;
  bool _isLoading = false;
  String? _errorMessage;

  Claim? get claim => _claim;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch claim info (if needed)
  Future<void> fetchClaimInfo(String claimId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _claim = await ClaimService().getClaimById(claimId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  // Approve claim
  Future<void> approveClaim(String claimId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ClaimService().approveClaim(claimId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  // Decline claim
  Future<void> declineClaim(String claimId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ClaimService().declineClaim(claimId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
class RequestInfoProvider extends ChangeNotifier {
  final List<String> _questions = [];
  bool _isSubmitting = false;
  String? _errorMessage;

  List<String> get questions => List.unmodifiable(_questions);
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  void addQuestion(String question) {
    if (question.trim().isNotEmpty) {
      _questions.add(question.trim());
      notifyListeners();
    }
  }

  void removeQuestion(int index) {
    _questions.removeAt(index);
    notifyListeners();
  }

  Future<void> submitQuestions(String claimId) async {
    _isSubmitting = true;
    notifyListeners();
    try {
      await ClaimService().requestMoreInfo(claimId, _questions);
      _errorMessage = null;
      _questions.clear();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isSubmitting = false;
    notifyListeners();
  }
}

class ClaimProvider extends ChangeNotifier {
  String _fullname = '';
  String _mobileNumber = '';
  String _lostDate = '';
  String _lostLocation = '';
  String _attachedDetails = '';
  String _proofOfOwnership = '';
  bool _confirmInfo = false;

  // Getters
  String get fullname => _fullname;
  String get mobileNumber => _mobileNumber;
  String get lostDate => _lostDate;
  String get lostLocation => _lostLocation;
  String get attachedDetails => _attachedDetails;
  String get proofOfOwnership => _proofOfOwnership;
  bool get confirmInfo => _confirmInfo;

  // Setters
  void setFullname(String value) {
    _fullname = value;
    notifyListeners();
  }

  void setMobileNumber(String value) {
    _mobileNumber = value;
    notifyListeners();
  }

  void setLostDate(String value) {
    _lostDate = value;
    notifyListeners();
  }

  void setLostLocation(String value) {
    _lostLocation = value;
    notifyListeners();
  }

  void setAttachedDetails(String value) {
    _attachedDetails = value;
    notifyListeners();
  }

  void setProofOfOwnership(String value) {
    _proofOfOwnership = value;
    notifyListeners();
  }

  void setConfirmInfo(bool value) {
    _confirmInfo = value;
    notifyListeners();
  }

  // Submission using the service
  Future<void> submitClaim() async {
    try {
      await ClaimService().submitClaim(
        fullname: _fullname,
        mobileNumber: _mobileNumber,
        lostDate: _lostDate,
        lostLocation: _lostLocation,
        attachedDetails: _attachedDetails,
        proofOfOwnership: _proofOfOwnership,
      );
      clear();
    } catch (e) {
      print('Error submitting claim: $e');
      rethrow;
    }
  }

  void clear() {
    _fullname = '';
    _mobileNumber = '';
    _lostDate = '';
    _lostLocation = '';
    _attachedDetails = '';
    _proofOfOwnership = '';
    _confirmInfo = false;
    notifyListeners();
  }
}
