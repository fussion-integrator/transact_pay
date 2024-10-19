import 'package:test/test.dart';
import 'package:example/rsa_helper.dart'; // Adjust the import path as necessary
import 'package:pointycastle/asymmetric/api.dart';

void main() {
  group('RSAPublicKey Parsing Tests', () {
    test('Valid public key format', () {
      String validPublicKey = '''
        -----BEGIN PUBLIC KEY-----
        NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+eVl3d21ERGJFVXY4TkNwb2Jnd2lYaWtyekk5Q2dibkwxTFpVZDhGK0VCTmtoRXVzdWI5bCszY0FETFBoQkFpV0RyWElsZnBDMDVtUHZaTjF0WWgwUW9NQzhIczJ5bU5GeG9pbXhjWEN5ZS9uWUpTQTgydjlkbG9RMG92YWVKcG13YUFDTkd5T3JUb3lpRkMzVkgxZ0NqOXZ0Zm9PSFFTbU5ETHZGM3ZPZlZuMjFNRnJyUEtVbEdBYXFGOEJWa1RRYnJVbStMekRLaUMvcDdwb21lQjhKSllWMUs1bUZpd09zeHZ3ak5CVkJwM2FoS2MwdG5jZE1iRmNwSHZHb3hnTlA1NDlKSkVqb2hxVjkzbThTbHdLeVVKbkxaRmEveWdEYWtMbElGMUhzZm9ydWdGQ2wwY3JBb2RMaSs5VWFnR2t4N0IxMGpPWXVkNUNabnh4aEJpTU1sZzFId0RDR2thU25NalJHWnpKZzdxTHBBTDkwaUhtZ2p6dXVLeTRZZjAwZHpnTjZsUGVFdTZHT295bVNwV0szQ3hzS1dvN0ZaeVNQdUlMNDJRVzFTcjNtUk43ZGtrblFCdUNjb0VJSWFpSXMxV3g2OE90SmVudEhZa2FxekljMGh3eEFCNUwwdHFmVE1MUHhwV2w1U1B0TktJcDBWTjJJbVZSdXJPcE9VRVpTVHZ3SWdvTG5ydjl6SnpRUFNNbXVmbmV6dVlYSVZ0QW15d3hHcndjSEVoRWd4S0ZHZFNzWmJkVzl3ai9JbGxmUnAzQmdIVUhBZGIvSmhVZjZnb1Q0UFNDSnQ1RzJmS0JZdmlNblFNNXR4a1hNTkVmQjg1b05CTjlrUU11Vzh4MVQxNEtVbk9iaGh2ei9aVUoxMm9qY2UrZWcxOVYxTVRzUStJWG5Gd3dXMjA9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==
        -----END PUBLIC KEY-----
      ''';

      RSAPublicKey publicKey = parseRSAPublicKey(validPublicKey);
      expect(publicKey, isNotNull);
      expect(publicKey.modulus, isNotNull);
      expect(publicKey.exponent, isNotNull);
    });

    test('Invalid public key format', () {
      String invalidPublicKey = '''
        -----BEGIN PUBLIC KEY-----
        InvalidKeyData
        -----END PUBLIC KEY-----
      ''';

      expect(() => parseRSAPublicKey(invalidPublicKey),
          throwsA(isA<FormatException>()));
    });

    test('Public key with extra spaces', () {
      String publicKeyWithExtraSpaces = '''
        -----BEGIN PUBLIC KEY-----
        
        NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+eVl3d21ERGJFVXY4TkNwb2Jnd2lYaWtyekk5Q2dibkwxTFpVZDhGK0VCTmtoRXVzdWI5bCszY0FETFBoQkFpV0RyWElsZnBDMDVtUHZaTjF0WWgwUW9NQzhIczJ5bU5GeG9pbXhjWEN5ZS9uWUpTQTgydjlkbG9RMG92YWVKcG13YUFDTkd5T3JUb3lpRkMzVkgxZ0NqOXZ0Zm9PSFFTbU5ETHZGM3ZPZlZuMjFNRnJyUEtVbEdBYXFGOEJWa1RRYnJVbStMekRLaUMvcDdwb21lQjhKSllWMUs1bUZpd09zeHZ3ak5CVkJwM2FoS2MwdG5jZE1iRmNwSHZHb3hnTlA1NDlKSkVqb2hxVjkzbThTbHdLeVVKbkxaRmEveWdEYWtMbElGMUhzZm9ydWdGQ2wwY3JBb2RMaSs5VWFnR2t4N0IxMGpPWXVkNUNabnh4aEJpTU1sZzFId0RDR2thU25NalJHWnpKZzdxTHBBTDkwaUhtZ2p6dXVLeTRZZjAwZHpnTjZsUGVFdTZHT295bVNwV0szQ3hzS1dvN0ZaeVNQdUlMNDJRVzFTcjNtUk43ZGtrblFCdUNjb0VJSWFpSXMxV3g2OE90SmVudEhZa2FxekljMGh3eEFCNUwwdHFmVE1MUHhwV2w1U1B0TktJcDBWTjJJbVZSdXJPcE9VRVpTVHZ3SWdvTG5ydjl6SnpRUFNNbXVmbmV6dVlYSVZ0QW15d3hHcndjSEVoRWd4S0ZHZFNzWmJkVzl3ai9JbGxmUnAzQmdIVUhBZGIvSmhVZjZnb1Q0UFNDSnQ1RzJmS0JZdmlNblFNNXR4a1hNTkVmQjg1b05CTjlrUU11Vzh4MVQxNEtVbk9iaGh2ei9aVUoxMm9qY2UrZWcxOVYxTVRzUStJWG5Gd3dXMjA9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==
        
        -----END PUBLIC KEY-----
      ''';

      RSAPublicKey publicKey = parseRSAPublicKey(publicKeyWithExtraSpaces);
      expect(publicKey, isNotNull);
      expect(publicKey.modulus, isNotNull);
      expect(publicKey.exponent, isNotNull);
    });

    test('Public key without BEGIN/END markers', () {
      String publicKeyWithoutMarkers = '''
        NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+eVl3d21ERGJFVXY4TkNwb2Jnd2lYaWtyekk5Q2dibkwxTFpVZDhGK0VCTmtoRXVzdWI5bCszY0FETFBoQkFpV0RyWElsZnBDMDVtUHZaTjF0WWgwUW9NQzhIczJ5bU5GeG9pbXhjWEN5ZS9uWUpTQTgydjlkbG9RMG92YWVKcG13YUFDTkd5T3JUb3lpRkMzVkgxZ0NqOXZ0Zm9PSFFTbU5ETHZGM3ZPZlZuMjFNRnJyUEtVbEdBYXFGOEJWa1RRYnJVbStMekRLaUMvcDdwb21lQjhKSllWMUs1bUZpd09zeHZ3ak5CVkJwM2FoS2MwdG5jZE1iRmNwSHZHb3hnTlA1NDlKSkVqb2hxVjkzbThTbHdLeVVKbkxaRmEveWdEYWtMbElGMUhzZm9ydWdGQ2wwY3JBb2RMaSs5VWFnR2t4N0IxMGpPWXVkNUNabnh4aEJpTU1sZzFId0RDR2thU25NalJHWnpKZzdxTHBBTDkwaUhtZ2p6dXVLeTRZZjAwZHpnTjZsUGVFdTZHT295bVNwV0szQ3hzS1dvN0ZaeVNQdUlMNDJRVzFTcjNtUk43ZGtrblFCdUNjb0VJSWFpSXMxV3g2OE90SmVudEhZa2FxekljMGh3eEFCNUwwdHFmVE1MUHhwV2w1U1B0TktJcDBWTjJJbVZSdXJPcE9VRVpTVHZ3SWdvTG5ydjl6SnpRUFNNbXVmbmV6dVlYSVZ0QW15d3hHcndjSEVoRWd4S0ZHZFNzWmJkVzl3ai9JbGxmUnAzQmdIVUhBZGIvSmhVZjZnb1Q0UFNDSnQ1RzJmS0JZdmlNblFNNXR4a1hNTkVmQjg1b05CTjlrUU11Vzh4MVQxNEtVbk9iaGh2ei9aVUoxMm9qY2UrZWcxOVYxTVRzUStJWG5Gd3dXMjA9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==
      ''';

      expect(() => parseRSAPublicKey(publicKeyWithoutMarkers),
          throwsA(isA<FormatException>()));
    });

    test('Malformed public key', () {
      String malformedPublicKey = '''
        -----BEGIN PUBLIC KEY-----
        -----END PUBLIC KEY-----
      ''';

      expect(() => parseRSAPublicKey(malformedPublicKey),
          throwsA(isA<FormatException>()));
    });
  });
}
