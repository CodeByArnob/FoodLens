import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dietary_constants.dart';
import '../../../core/services/currency_service.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/directional_chevron.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';
import '../../history_favorites/providers/history_favorites_provider.dart';
import '../../auth/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showLanguageSelector(BuildContext context, WidgetRef ref, SettingsState settings) {
    HapticHelper.lightImpact();
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMutedDark.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.selectLanguage,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        final locale = View.of(context).platformDispatcher.locale;
                        ref.read(settingsProvider.notifier).autoDetectLocale(locale);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${l10n.suggestedLocale}: ${locale.languageCode}')),
                        );
                      },
                      icon: const Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryLight),
                      label: Text(l10n.suggestedLocale, style: const TextStyle(fontSize: 12, color: AppColors.primaryLight)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: DietaryConstants.supportedLanguages.length,
                    separatorBuilder: (context, index) => const Divider(color: AppColors.darkBorder, height: 1),
                    itemBuilder: (context, index) {
                      final item = DietaryConstants.supportedLanguages[index];
                      final isSelected = settings.language == item['code'];

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        leading: Text(item['flag'] ?? '🌐', style: const TextStyle(fontSize: 24)),
                        title: Text(
                          item['nativeName'] ?? item['name']!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? AppColors.primaryLight : Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          item['name']!,
                          style: const TextStyle(fontSize: 12, color: AppColors.textMutedDark),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22)
                            : null,
                        onTap: () {
                          HapticHelper.selectionClick();
                          ref.read(settingsProvider.notifier).setLanguage(item['code']!);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCurrencySelector(BuildContext context, WidgetRef ref, SettingsState settings) {
    HapticHelper.lightImpact();
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            final currencies = DietaryConstants.supportedCurrencies.where((c) {
              if (searchQuery.isEmpty) return true;
              final q = searchQuery.toLowerCase();
              return c['code']!.toLowerCase().contains(q) ||
                  c['name']!.toLowerCase().contains(q) ||
                  (c['country'] ?? '').toLowerCase().contains(q);
            }).toList();

            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.75,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              builder: (sheetContext, scrollController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.textMutedDark.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.selectCurrency,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Rates synced: ${CurrencyService.providerName}',
                            style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Search Bar
                      TextField(
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search currency or country...',
                          hintStyle: const TextStyle(color: AppColors.textMutedDark, fontSize: 13),
                          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMutedDark, size: 20),
                          filled: true,
                          fillColor: AppColors.darkSurfaceHighlight,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (val) {
                          setModalState(() {
                            searchQuery = val.trim();
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: currencies.length,
                          separatorBuilder: (context, index) => const Divider(color: AppColors.darkBorder, height: 1),
                          itemBuilder: (context, index) {
                            final item = currencies[index];
                            final code = item['code']!;
                            final isSelected = settings.currencyCode == code;
                            final rate = CurrencyService.fallbackRates[code] ?? 1.0;

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              leading: Text(item['flag'] ?? '🌐', style: const TextStyle(fontSize: 24)),
                              title: Row(
                                children: [
                                  Text(
                                    code,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected ? AppColors.primaryLight : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.darkSurfaceHighlight,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item['symbol']!,
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                '${item['name']} • 1 USD = ${rate.toStringAsFixed(code == 'JPY' ? 0 : 2)} $code',
                                style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22)
                                  : null,
                              onTap: () {
                                HapticHelper.selectionClick();
                                ref.read(settingsProvider.notifier).setCurrency(code);
                                Navigator.pop(ctx);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showCountrySelector(BuildContext context, WidgetRef ref, SettingsState settings) {
    HapticHelper.lightImpact();
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMutedDark.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.countryRegion,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: DietaryConstants.supportedCountries.length,
                    separatorBuilder: (context, index) => const Divider(color: AppColors.darkBorder, height: 1),
                    itemBuilder: (context, index) {
                      final item = DietaryConstants.supportedCountries[index];
                      final isSelected = settings.country == item['name'];

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        leading: Text(item['flag'] ?? '🌐', style: const TextStyle(fontSize: 24)),
                        title: Text(
                          item['name']!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? AppColors.primaryLight : Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Currency: ${item['currency']} • Default: ${item['language']}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMutedDark),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22)
                            : null,
                        onTap: () {
                          HapticHelper.selectionClick();
                          ref.read(settingsProvider.notifier).setCountry(item['name']!, autoAdjustCurrency: true);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Localization & International Preferences
            Text(
              l10n.localizationSection,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textMutedDark, letterSpacing: 0.5),
            ),
            const SizedBox(height: 8),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                children: [
                  // Language Tile
                  _SettingItemTile(
                    icon: Icons.language_rounded,
                    title: l10n.language,
                    valueWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(settings.languageNativeName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryLight)),
                        const SizedBox(width: 6),
                        const DirectionalChevron(),
                      ],
                    ),
                    onTap: () => _showLanguageSelector(context, ref, settings),
                  ),
                  const Divider(color: AppColors.darkBorder, height: 1),

                  // Currency Tile
                  _SettingItemTile(
                    icon: Icons.monetization_on_outlined,
                    title: l10n.currency,
                    valueWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${settings.currencyFlag} ${settings.currencyCode} (${settings.currencySymbol})',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryLight)),
                        const SizedBox(width: 6),
                        const DirectionalChevron(),
                      ],
                    ),
                    onTap: () => _showCurrencySelector(context, ref, settings),
                  ),
                  const Divider(color: AppColors.darkBorder, height: 1),

                  // Country / Region Tile
                  _SettingItemTile(
                    icon: Icons.public_rounded,
                    title: l10n.countryRegion,
                    valueWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(settings.country, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        const SizedBox(width: 6),
                        const DirectionalChevron(),
                      ],
                    ),
                    onTap: () => _showCountrySelector(context, ref, settings),
                  ),
                  const Divider(color: AppColors.darkBorder, height: 1),

                  // Measurement System Tile (Responsive, Stacked, Full-Width)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.straighten_rounded, color: AppColors.textSecondaryDark, size: 20),
                            const SizedBox(width: 12),
                            Text(l10n.measurementSystem, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _UnitSelectionPill(
                                title: l10n.metric,
                                subtitle: 'g, ml, kg',
                                isSelected: settings.unitSystem == 'metric',
                                onTap: () {
                                  HapticHelper.selectionClick();
                                  settingsNotifier.setUnitSystem('metric');
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _UnitSelectionPill(
                                title: l10n.imperial,
                                subtitle: 'oz, lb, fl oz',
                                isSelected: settings.unitSystem == 'imperial',
                                onTap: () {
                                  HapticHelper.selectionClick();
                                  settingsNotifier.setUnitSystem('imperial');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 2: Dietary Preferences & Target
            Text(
              l10n.dietarySection,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textMutedDark, letterSpacing: 0.5),
            ),
            const SizedBox(height: 8),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.dailyCalorieGoal, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                      Text('${settings.dailyCalorieTarget} kcal', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryLight)),
                    ],
                  ),
                  Slider(
                    value: settings.dailyCalorieTarget.toDouble(),
                    min: 1200,
                    max: 4000,
                    divisions: 28,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.darkSurfaceHighlight,
                    onChanged: (val) {
                      settingsNotifier.setDailyCalorieTarget(val.toInt());
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(l10n.dietaryFilters, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: DietaryConstants.dietaryPreferences.map((pref) {
                      final isSelected = settings.dietaryFilters.contains(pref);
                      return FilterChip(
                        label: Text(pref),
                        selected: isSelected,
                        onSelected: (_) {
                          HapticHelper.selectionClick();
                          settingsNotifier.toggleDietaryFilter(pref);
                        },
                        selectedColor: AppColors.primary.withValues(alpha: 0.25),
                        checkmarkColor: AppColors.primary,
                        labelStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.primaryLight : AppColors.textSecondaryDark,
                        ),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : AppColors.darkBorder,
                        ),
                        backgroundColor: AppColors.darkSurfaceCard,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 3: About & Creator Branding (CodeByArnob)
            Text(
              l10n.aboutFoodLens,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textMutedDark, letterSpacing: 0.5),
            ),
            const SizedBox(height: 8),
            GlassCard(
              padding: const EdgeInsets.all(16),
              onTap: () {
                HapticHelper.lightImpact();
                context.push('/about');
              },
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'FoodLens v1.0.0',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Created & Developed by CodeByArnob',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ),
                  const DirectionalChevron(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 4: Data Management
            Text(
              l10n.dataManagement,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textMutedDark, letterSpacing: 0.5),
            ),
            const SizedBox(height: 8),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.darkSurface,
                    title: Text(l10n.clearCache, style: const TextStyle(color: Colors.white)),
                    content: const Text(
                      'This will erase all cached scan history and reset temporary files.',
                      style: TextStyle(color: AppColors.textSecondaryDark),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
                      TextButton(
                        onPressed: () {
                          ref.read(historyFavoritesProvider.notifier).clearAllHistory();
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.cacheCleared)),
                          );
                        },
                        child: Text(l10n.clear, style: const TextStyle(color: AppColors.error)),
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.delete_sweep_outlined, color: AppColors.error, size: 20),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(l10n.clearCache, style: const TextStyle(fontSize: 14, color: AppColors.error, fontWeight: FontWeight.w600)),
                  ),
                  const DirectionalChevron(size: 18),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Account & Puter Session Management
            Text(
              'ACCOUNT & SESSION',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: AppColors.textMutedDark.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 10),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authProvider);
                  return Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            authState.isAuthenticated ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                            color: authState.isAuthenticated ? AppColors.primary : AppColors.textMutedDark,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authState.isAuthenticated
                                      ? (authState.user?.username ?? 'Connected User')
                                      : 'Puter Guest / Offline',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                                Text(
                                  authState.isAuthenticated
                                      ? 'User-Pays compute active'
                                      : 'Not connected to Puter cloud',
                                  style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: AppColors.darkBorder, height: 1),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          HapticHelper.mediumImpact();
                          if (authState.isAuthenticated) {
                            final bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: AppColors.darkSurface,
                                title: const Text('Sign Out of Puter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                content: const Text(
                                  'Are you sure you want to disconnect your Puter account and clear the saved session?',
                                  style: TextStyle(color: AppColors.textSecondaryDark),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text('Cancel', style: TextStyle(color: AppColors.textMutedDark)),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await ref.read(authProvider.notifier).signOut();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Successfully signed out.')),
                                );
                                context.go('/auth');
                              }
                            }
                          } else {
                            context.push('/auth');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                authState.isAuthenticated ? Icons.logout_rounded : Icons.login_rounded,
                                size: 16,
                                color: authState.isAuthenticated ? AppColors.error : AppColors.primaryLight,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                authState.isAuthenticated ? 'Sign Out of Puter' : 'Connect Puter Account',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: authState.isAuthenticated ? AppColors.error : AppColors.primaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _UnitSelectionPill extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitSelectionPill({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.22)
              : AppColors.darkSurfaceHighlight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.primaryLight : Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textMutedDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget valueWidget;
  final VoidCallback onTap;

  const _SettingItemTile({
    required this.icon,
    required this.title,
    required this.valueWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondaryDark, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
