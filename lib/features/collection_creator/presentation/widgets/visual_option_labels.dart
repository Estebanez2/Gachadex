import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';

String coverColorLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'cover_teal' => l10n.coverColorTeal,
    'cover_coral' => l10n.coverColorCoral,
    'cover_gold' => l10n.coverColorGold,
    'cover_lilac' => l10n.coverColorLilac,
    'cover_sky' => l10n.coverColorSky,
    'cover_mint' => l10n.coverColorMint,
    'cover_rose' => l10n.coverColorRose,
    'cover_graphite' => l10n.coverColorGraphite,
    _ => l10n.invalidVisualOption,
  };
}

String coverIconLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'cover_icon_cards' => l10n.coverIconCards,
    'cover_icon_laugh' => l10n.coverIconLaugh,
    'cover_icon_camera' => l10n.coverIconCamera,
    'cover_icon_group' => l10n.coverIconGroup,
    'cover_icon_trophy' => l10n.coverIconTrophy,
    _ => l10n.coverIconSpark,
  };
}

String coverPatternLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'cover_pattern_diagonal' => l10n.coverPatternDiagonal,
    'cover_pattern_dots' => l10n.coverPatternDots,
    'cover_pattern_split' => l10n.coverPatternSplit,
    _ => l10n.coverPatternSolid,
  };
}

IconData coverIconForId(String id) {
  return switch (id) {
    'cover_icon_cards' => Icons.style_outlined,
    'cover_icon_laugh' => Icons.sentiment_very_satisfied_outlined,
    'cover_icon_camera' => Icons.photo_camera_outlined,
    'cover_icon_group' => Icons.groups_outlined,
    'cover_icon_trophy' => Icons.emoji_events_outlined,
    _ => Icons.auto_awesome_outlined,
  };
}

String rarityColorLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'rarity_color_green' => l10n.rarityColorGreen,
    'rarity_color_blue' => l10n.rarityColorBlue,
    'rarity_color_purple' => l10n.rarityColorPurple,
    'rarity_color_red' => l10n.rarityColorRed,
    'rarity_color_orange' => l10n.rarityColorOrange,
    'rarity_color_pink' => l10n.rarityColorPink,
    'rarity_color_gold' => l10n.rarityColorGold,
    'rarity_color_turquoise' => l10n.rarityColorTurquoise,
    'rarity_color_graphite' => l10n.rarityColorGraphite,
    _ => l10n.rarityColorGray,
  };
}

String rarityIconLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'rarity_icon_crown' => l10n.rarityIconCrown,
    'rarity_icon_diamond' => l10n.rarityIconDiamond,
    'rarity_icon_fire' => l10n.rarityIconFire,
    'rarity_icon_bolt' => l10n.rarityIconBolt,
    'rarity_icon_rocket' => l10n.rarityIconRocket,
    'rarity_icon_glasses' => l10n.rarityIconGlasses,
    'rarity_icon_trophy' => l10n.rarityIconTrophy,
    'rarity_icon_ghost' => l10n.rarityIconGhost,
    'rarity_icon_footprint' => l10n.rarityIconFootprint,
    'rarity_icon_smile' => l10n.rarityIconSmile,
    'rarity_icon_burst' => l10n.rarityIconBurst,
    'rarity_icon_heart' => l10n.rarityIconHeart,
    'rarity_icon_moon' => l10n.rarityIconMoon,
    'rarity_icon_sun' => l10n.rarityIconSun,
    _ => l10n.rarityIconStar,
  };
}

String rarityFrameLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'rarity_frame_rounded' => l10n.rarityFrameRounded,
    'rarity_frame_double' => l10n.rarityFrameDouble,
    'rarity_frame_metallic' => l10n.rarityFrameMetallic,
    'rarity_frame_neon' => l10n.rarityFrameNeon,
    'rarity_frame_comic' => l10n.rarityFrameComic,
    'rarity_frame_elegant' => l10n.rarityFrameElegant,
    'rarity_frame_pixel' => l10n.rarityFramePixel,
    _ => l10n.rarityFrameSimple,
  };
}

String rarityEffectLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'rarity_effect_soft_glow' => l10n.rarityEffectSoftGlow,
    'rarity_effect_spark' => l10n.rarityEffectSpark,
    'rarity_effect_gradient' => l10n.rarityEffectGradient,
    'rarity_effect_holo' => l10n.rarityEffectHolo,
    'rarity_effect_pulse' => l10n.rarityEffectPulse,
    _ => l10n.rarityEffectNone,
  };
}
