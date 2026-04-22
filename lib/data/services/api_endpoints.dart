/// Centralized API Endpoints for the App.
/// This corresponds to your config/routing layer.
class ApiEndpoints {
  // Base URL - Change this based on your environment (Dev/Prod)
  static const String baseUrl = 'https://dev-api.viranchi.ai/';
  static const String vedicBaseUrl = 'https://dev-vedic.viranchi.ai';
  static const String webSocketUrl = 'ws://dev-vedic.viranchi.ai/ws/chat/';
  static const String razorPayKey = 'rzp_test_eRMSfNsBQxr4Br';

  // static const String  baseUrl = 'https://papi.viranchi.ai'
  // static const String vedicBaseUrl ='https://vedic.viranchi.ai'
  // static const String webSocketUrl ='ws://vedic.viranchi.ai/ws/chat/'
  // static const String razorPayKey = 'rzp_live_cvWpZfK43dQimM'

  // Authentication
  static const String loginSendOtp = 'v1/api/send-otp/';
  static const String verifyOtp = 'v1/api/verify-otp/';
  static const String deleteAccount = 'v1/api/user-delete/';

  // Home
  static const String moonSignData = 'v1/api/moon-sign/';
  static const String panchangData = 'v1/api/panchang-data/';
  static const String userDetails = 'v1/api/user-details-by-id/';
  static const String getCity = 'v1/api/city_search';
  static const String getInsight = 'v1/api/daily-nakshatra/';
  static const String planetDetail = 'v1/api/planet-details/';
  static const String notificationList = 'v1/api/get-notification/';
  static const String updateNotificationList = 'v1/api/update-notification/';

  // Profile
  static const String updateProfile = 'v1/api/user-update/';

  // Dasha
  static const String dasha = 'v1/prokerala/dasha-periods/';
  static const String mahaDasha = 'v1/api/mahadasha-predection/';
  static const String antarDasha = 'v1/api/antra-dasha-custom-data/';
  static const String pratyantaraDasha = 'v1/api/pyarantar-dasha-custom-data/';

  // Yoga
  static const String yogaList = 'v1/api/yoga-list/';

  // Dosh
  static const String mangalDosh = 'v1/api/mangal-dosh/';
  static const String kaalsarpDosh = 'v1/api/kaalsrap-dosh/';
  static const String pitraDosh = 'v1/api/pitra-dosh/';

  // Matchmaking
  static const String getMatchMakingProfile =
      'v1/api/get-match-making-profile/';
  static const String addMatchMakingProfile =
      'v1/api/add-match-making-profile/';
  static const String updateMatchMakingProfile =
      'v1/api/update-match-making-profile/';
  static const String deleteMatchMakingProfile =
      'v1/api/delete-match-making-profile/';
  static const String compatibility = 'v1/api/ashtakoot/';

  // Kundli
  static const String getKundli = 'v1/api/get-kundali-profile/';
  static const String addKundliProfile = 'v1/api/add-kundali-profile/';
  static const String updateKundliProfile = 'v1/api/update-kundali-profile/';
  static const String getKundaliDivisionalChart = 'v1/api/divisional-charts/';
  static const String getAllStaticData = 'v1/api/chart-predection-static-data/';
  static const String paymentStatus = 'v1/api/payment-status/';
  static const String downloadKundli =
      'v1/api/get-horoscope-queue-upload-to-e2e-storage/';
  static const String getDownloadKundliE2e =
      'v1/api/get-file-from-e2e-storage/';
  static const String getDivisionalPlanetPosition =
      'v1/prokerala/divisional-planet-position/';

  // Horoscope
  static const String weeklyMoonData = 'v1/api/weekly-moon/';
  static const String dailyMoonData = 'v1/api/daily-moon-data/';

  // Sadesati
  static const String sadesati = 'v1/api/sade-sati-table/';

  // Hora Muhurat
  static const String horaMuhurat = 'v1/api/hora-muhurta/';

  // Ask Expert
  static const String astrologerExpertise = 'v1/api/astrologer-expertise/';
  static const String astrologerList = 'v1/api/astrologer-list/';
  static const String astrologerExpertiseList =
      'v1/api/astrologer/expertise-list/';
  static const String astrologerDetails =
      'v1/api/astrologer/astrologer-details/';
  static const String astrologerTestimonials =
      'v1/api/astrologer/get-testimonial/';
  static const String astrologerSlotDetails =
      'v1/api/astrologer/astrologer-slot-list/';
  static const String createOrder = 'v1/api/create-order/';
  static const String userAppointments = 'v1/api/get-user-appointments/';

  // AI Astro
  static const String aiSubscriptionList = 'v1/api/chat-subscriptions/list/';
  static const String aiSubscriptionStatus =
      'v1/api/chat-subscriptions/status/';
  static const String aiTransactionHistory =
      'v1/api/chat-subscriptions/transactions/history/';
  static const String aiChatConversationHistory = 'api/conversation_messages/';
  static const String aiChatProfileList = 'api/master_user/sessions/';
  static const String aiChatFeedback = 'api/feedback/';
}
