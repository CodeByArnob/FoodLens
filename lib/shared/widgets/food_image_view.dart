import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class FoodImageView extends StatelessWidget {
  final String? imagePath;
  final String? foodName;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;

  const FoodImageView({
    super.key,
    this.imagePath,
    this.foodName,
    this.width = double.infinity,
    this.height = 120,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
  });

  /// Maps dish name to bundled genuine food photography
  static String? getBundledAssetForName(String? name) {
    if (name == null || name.isEmpty) return null;
    final lower = name.toLowerCase();

    // 1. Salmon / Fish / Seafood
    if (lower.contains('salmon') ||
        lower.contains('fish') ||
        lower.contains('seafood') ||
        lower.contains('tuna') ||
        lower.contains('poke') ||
        lower.contains('sushi') ||
        lower.contains('মাছ') ||
        lower.contains('স্যামন') ||
        lower.contains('سلمون') ||
        lower.contains('سمك')) {
      return 'assets/images/salmon_bowl.jpg';
    }

    // 2. Pizza / Flatbread / Italian
    if (lower.contains('pizza') ||
        lower.contains('margherita') ||
        lower.contains('cheese') ||
        lower.contains('pie') ||
        lower.contains('পিজ্জা') ||
        lower.contains('মার্গারিটা') ||
        lower.contains('بيتزا')) {
      return 'assets/images/margherita_pizza.jpg';
    }

    // 3. Avocado Toast / Eggs / Breakfast Sandwich
    if (lower.contains('avocado') ||
        lower.contains('toast') ||
        lower.contains('bread') ||
        lower.contains('sandwich') ||
        lower.contains('egg') ||
        lower.contains('অ্যাভোকাডো') ||
        lower.contains('টোস্ট') ||
        lower.contains('ডিম') ||
        lower.contains('أفوكادو') ||
        lower.contains('بيض') ||
        lower.contains('خبز')) {
      return 'assets/images/avocado_toast.jpg';
    }

    // 4. Greek Salad / Fresh Greens
    if (lower.contains('greek') ||
        lower.contains('salad') ||
        lower.contains('cucumber') ||
        lower.contains('feta') ||
        lower.contains('greens') ||
        lower.contains('সালাদ') ||
        lower.contains('শসা') ||
        lower.contains('সلطة')) {
      return 'assets/images/greek_salad.jpg';
    }

    // 5. Lentil Dal / Soups / Curries / Rice
    if (lower.contains('dal') ||
        lower.contains('lentil') ||
        lower.contains('soup') ||
        lower.contains('curry') ||
        lower.contains('rice') ||
        lower.contains('stew') ||
        lower.contains('ডাল') ||
        lower.contains('ভাত') ||
        lower.contains('তরকারি') ||
        lower.contains('عدس') ||
        lower.contains('شوربة') ||
        lower.contains('أرز')) {
      return 'assets/images/lentil_dal.jpg';
    }

    // 6. Oatmeal / Berries / Parfait / Porridge
    if (lower.contains('oat') ||
        lower.contains('berr') ||
        lower.contains('porridge') ||
        lower.contains('yogurt') ||
        lower.contains('fruit') ||
        lower.contains('granola') ||
        lower.contains('ওটমিল') ||
        lower.contains('দই') ||
        lower.contains('ফল') ||
        lower.contains('شوفان') ||
        lower.contains('توت')) {
      return 'assets/images/oatmeal_berries.jpg';
    }

    // 7. Grilled Chicken / Poultry / Meat / Steak
    if (lower.contains('chicken') ||
        lower.contains('poultry') ||
        lower.contains('meat') ||
        lower.contains('steak') ||
        lower.contains('beef') ||
        lower.contains('grill') ||
        lower.contains('মুরগি') ||
        lower.contains('চিকেন') ||
        lower.contains('মাংস') ||
        lower.contains('دجاج') ||
        lower.contains('لحم')) {
      return 'assets/images/chicken_breast.jpg';
    }

    // 8. Quinoa / Veggie Bowl / Vegetarian / Healthy
    if (lower.contains('quinoa') ||
        lower.contains('veggie') ||
        lower.contains('vegetable') ||
        lower.contains('bowl') ||
        lower.contains('vegan') ||
        lower.contains('শাকসবজি') ||
        lower.contains('সবজি') ||
        lower.contains('کینوا') ||
        lower.contains('خضار')) {
      return 'assets/images/quinoa_veggie.jpg';
    }

    // Default to delicious quinoa/veggie or salmon bowl if non-empty dish name
    return 'assets/images/quinoa_veggie.jpg';
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryDark.withValues(alpha: 0.6),
            AppColors.darkSurfaceCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.2),
          ),
          child: const Icon(
            Icons.restaurant_menu_rounded,
            color: AppColors.primaryLight,
            size: 26,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Check if direct file exists on disk
    if (imagePath != null && imagePath!.isNotEmpty) {
      final file = File(imagePath!);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          ),
        );
      }

      // 2. Check if it's an asset path
      if (imagePath!.startsWith('assets/')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            imagePath!,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          ),
        );
      }

      // 3. Check if it's a network URL
      if (imagePath!.startsWith('http://') || imagePath!.startsWith('https://')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            imagePath!,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: width,
                height: height,
                color: AppColors.darkSurfaceHighlight,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          ),
        );
      }
    }

    // 4. Try matching food name to bundled genuine food photography
    final bundledAsset = getBundledAssetForName(foodName);
    if (bundledAsset != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          bundledAsset,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => _buildFallback(),
        ),
      );
    }

    // 5. Default fallback
    return _buildFallback();
  }
}
