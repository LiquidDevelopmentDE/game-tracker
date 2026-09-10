import 'package:flutter_test/flutter_test.dart';
import 'package:tallee/l10n/generated/app_localizations.dart';
import 'package:tallee/presentation/views/news/news.dart';

void main() {
  group('News tests', () {
    test('Fallback news (english) are set', () {
      const fallbackLoc = 'en';
      final news = localizedNews[fallbackLoc];
      expect(
        news,
        isNotNull,
        reason: 'Fallback news for locale $fallbackLoc is null',
      );
      expect(
        news,
        isNotEmpty,
        reason: 'Fallback news for locale $fallbackLoc is empty',
      );

      for (final entry in news!) {
        expect(
          entry.heading,
          isNotEmpty,
          reason: 'Fallback news heading for locale $fallbackLoc is empty',
        );
        expect(
          entry.text,
          isNotEmpty,
          reason: 'Fallback news text for locale $fallbackLoc is empty',
        );
      }
    });

    test('For every locale there is a news', () {
      final loc = AppLocalizations.supportedLocales
          .map((e) => e.languageCode)
          .toList();
      for (final locale in loc) {
        final news = localizedNews[locale];
        expect(news, isNotNull, reason: 'News for locale $locale is null');
        expect(news, isNotEmpty, reason: 'News for locale $locale is empty');
      }
    });
  });
}
