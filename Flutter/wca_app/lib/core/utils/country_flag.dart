/// Convierte el nombre del país en español al emoji de su bandera (caracter unicode).
/// Si el país no está mapeado, devuelve un globo genérico.
String countryFlag(String pais) {
  const flags = {
    'etiopía': '🇪🇹', 'etiopia': '🇪🇹',
    'colombia': '🇨🇴',
    'brasil': '🇧🇷',
    'guatemala': '🇬🇹',
    'costa rica': '🇨🇷',
    'honduras': '🇭🇳',
    'perú': '🇵🇪', 'peru': '🇵🇪',
    'panamá': '🇵🇦', 'panama': '🇵🇦',
    'jamaica': '🇯🇲',
    'méxico': '🇲🇽', 'mexico': '🇲🇽',
    'nicaragua': '🇳🇮',
    'el salvador': '🇸🇻',
    'kenia': '🇰🇪', 'kenya': '🇰🇪',
    'yemen': '🇾🇪',
    'indonesia': '🇮🇩',
    'vietnam': '🇻🇳',
    'india': '🇮🇳',
    'bolivia': '🇧🇴',
    'ecuador': '🇪🇨',
    'república dominicana': '🇩🇴',
    'cuba': '🇨🇺',
    'ruanda': '🇷🇼', 'rwanda': '🇷🇼',
    'uganda': '🇺🇬',
    'tanzania': '🇹🇿',
    'papúa nueva guinea': '🇵🇬',
    'china': '🇨🇳',
    'tailandia': '🇹🇭',
    'myanmar': '🇲🇲',
  };
  return flags[pais.toLowerCase()] ?? '🌍';
}
