/// API Configuration
/// 
/// NOT: Base URL platform'a göre değişebilir:
/// - iOS fiziksel cihaz / macOS / Linux / Windows: localhost kullanılabilir
/// - Android emülatör: 10.0.2.2 kullanılmalı (localhost yerine)
/// - Web: localhost kullanılabilir (CORS backend'de açık olmalı)
/// - Android fiziksel cihaz: Bilgisayarın IP adresi kullanılmalı (örn: http://192.168.1.100:8000)

const String baseUrl = 'http://127.0.0.1:8010';
const String androidEmulatorBaseUrl = 'http://10.0.2.2:8010';
const String processEndpoint = '/process';
