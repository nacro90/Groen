import 'package:charcode/charcode.dart';

/// Definitions from [HTTP](https://github.com/nvim-neorg/norg-specs/blob/main/1.0-specification.norg)

/// [HTTP](https://www.fileformat.info/info/unicode/category/Zs/list.htm)
const whitespaces = {
  $tab,
  $space,
  $nbsp, // NO-BREAK SPACE
  0x1680, // OGHAM SPACE MARK
  0x2000, // EN QUAD
  0x2001, // EM QUAD
  0x2002, // EN SPACE
  0x2003, // EM SPACE
  0x2004, // THREE-PER-EM SPACE
  0x2005, // FOUR-PER-EM SPACE
  0x2006, // SIX-PER-EM SPACE
  0x2007, // FIGURE SPACE
  0x2008, // PUNCTUATION SPACE
  0x2009, // THIN SPACE
  0x200A, // HAIR SPACE
  0x202F, // NARROW NO-BREAK SPACE
  0x205F, // MEDIUM MATHEMATICAL SPACE
  0x3000, // IDEOGRAPHIC SPACE
};

const lineEndings = {
  $lf, // line feed
  $ff, // form feed
  $cr, // carriage return
};

const punctuations = {
  // Pc group -- Connectors
  0x005F, // _ Low Line
  0x203F, // ‿ Undertie
  0x2040, // ⁀ Character Tie
  0x2054, // ⁔ Inverted Undertie
  0xFE33, // ︳ Presentation Form For Vertical Low Line
  0xFE34, // ︴ Presentation Form For Vertical Wavy Low Line
  0xFE4D, // ﹍ Dashed Low Line
  0xFE4E, // ﹎ Centreline Low Line
  0xFE4F, // ﹏ Wavy Low Line
  0xFF3F, // ＿ Fullwidth Low Line

  // Pd group -- Dashes
  0x002D, // - Hyphen-Minus
  0x058A, // ֊ Armenian Hyphen
  0x05BE, // ־ Hebrew Punctuation Maqaf
  0x1400, // ᐀ Canadian Syllabics Hyphen
  0x1806, // ᠆ Mongolian Todo Soft Hyphen
  0x2010, // ‐ Hyphen
  0x2011, // ‑ Non-Breaking Hyphen
  0x2012, // ‒ Figure Dash
  0x2013, // – En Dash
  0x2014, // — Em Dash
  0x2015, // ― Horizontal Bar
  0x2E17, // ⸗ Double Oblique Hyphen
  0x2E1A, // ⸚ Hyphen with Diaeresis
  0x2E3A, // ⸺ Two-Em Dash
  0x2E3B, // ⸻ Three-Em Dash
  0x2E40, // ⹀ Double Hyphen
  0x301C, // 〜 Wave Dash
  0x3030, // 〰 Wavy Dash
  0x30A0, // ゠ Katakana-Hiragana Double Hyphen
  0xFE31, // ︱ Presentation Form For Vertical Em Dash
  0xFE32, // ︲ Presentation Form For Vertical En Dash
  0xFE58, // ﹘ Small Em Dash
  0xFE63, // ﹣ Small Hyphen-Minus
  0xFF0D, // － Fullwidth Hyphen-Minus
  0x10EAD, // 𐺭 Yezidi Hyphenation Mark

// Pe group -- Close Punctuations
  0x0029, // ) Right Parenthesis
  0x005D, // ] Right Square Bracket
  0x007D, // } Right Curly Bracket
  0x0F3B, // ༻ Tibetan Mark Gug Rtags Gyas
  0x0F3D, // ༽ Tibetan Mark Ang Khang Gyas
  0x169C, // ᚜ Ogham Reversed Feather Mark
  0x2046, // ⁆ Right Square Bracket with Quill
  0x207E, // ⁾ Superscript Right Parenthesis
  0x208E, // ₎ Subscript Right Parenthesis
  0x2309, // ⌉ Right Ceiling
  0x230B, // ⌋ Right Floor
  0x232A, // 〉 Right-Pointing Angle Bracket
  0x2769, // ❩ Medium Right Parenthesis Ornament
  0x276B, // ❫ Medium Flattened Right Parenthesis Ornament
  0x276D, // ❭ Medium Right-Pointing Angle Bracket Ornament
  0x276F, // ❯ Heavy Right-Pointing Angle Quotation Mark Ornament
  0x2771, // ❱ Heavy Right-Pointing Angle Bracket Ornament
  0x2773, // ❳ Light Right Tortoise Shell Bracket Ornament
  0x2775, // ❵ Medium Right Curly Bracket Ornament
  0x27C6, // ⟆ Right S-Shaped Bag Delimiter
  0x27E7, // ⟧ Mathematical Right White Square Bracket
  0x27E9, // ⟩ Mathematical Right Angle Bracket
  0x27EB, // ⟫ Mathematical Right Double Angle Bracket
  0x27ED, // ⟭ Mathematical Right White Tortoise Shell Bracket
  0x27EF, // ⟯ Mathematical Right Flattened Parenthesis
  0x2984, // ⦄ Right White Curly Bracket
  0x2986, // ⦆ Right White Parenthesis
  0x2988, // ⦈ Z Notation Right Image Bracket
  0x298A, // ⦊ Z Notation Right Binding Bracket
  0x298C, // ⦌ Right Square Bracket with Underbar
  0x298E, // ⦎ Right Square Bracket with Tick In Bottom Corner
  0x2990, // ⦐ Right Square Bracket with Tick In Top Corner
  0x2992, // ⦒ Right Angle Bracket with Dot
  0x2994, // ⦔ Right Arc Greater-Than Bracket
  0x2996, // ⦖ Double Right Arc Less-Than Bracket
  0x2998, // ⦘ Right Black Tortoise Shell Bracket
  0x29D9, // ⧙ Right Wiggly Fence
  0x29DB, // ⧛ Right Double Wiggly Fence
  0x29FD, // ⧽ Right-Pointing Curved Angle Bracket
  0x2E23, // ⸣ Top Right Half Bracket
  0x2E25, // ⸥ Bottom Right Half Bracket
  0x2E27, // ⸧ Right Sideways U Bracket
  0x2E29, // ⸩ Right Double Parenthesis
  0x3009, // 〉 Right Angle Bracket
  0x300B, // 》 Right Double Angle Bracket
  0x300D, // 」 Right Corner Bracket
  0x300F, // 』 Right White Corner Bracket
  0x3011, // 】 Right Black Lenticular Bracket
  0x3015, // 〕 Right Tortoise Shell Bracket
  0x3017, // 〗 Right White Lenticular Bracket
  0x3019, // 〙 Right White Tortoise Shell Bracket
  0x301B, // 〛 Right White Square Bracket
  0x301E, // 〞 Double Prime Quotation Mark
  0x301F, // 〟 Low Double Prime Quotation Mark
  0xFD3E, // ﴾ Ornate Left Parenthesis
  0xFE18, // ︘ Presentation Form For Vertical Right White Lenticular Brakcet
  0xFE36, // ︶ Presentation Form For Vertical Right Parenthesis
  0xFE38, // ︸ Presentation Form For Vertical Right Curly Bracket
  0xFE3A, // ︺ Presentation Form For Vertical Right Tortoise Shell Bracket
  0xFE3C, // ︼ Presentation Form For Vertical Right Black Lenticular Bracket
  0xFE3E, // ︾ Presentation Form For Vertical Right Double Angle Bracket
  0xFE40, // ﹀ Presentation Form For Vertical Right Angle Bracket
  0xFE42, // ﹂ Presentation Form For Vertical Right Corner Bracket
  0xFE44, // ﹄ Presentation Form For Vertical Right White Corner Bracket
  0xFE48, // ﹈ Presentation Form For Vertical Right Square Bracket
  0xFE5A, // ﹚ Small Right Parenthesis
  0xFE5C, // ﹜ Small Right Curly Bracket
  0xFE5E, // ﹞ Small Right Tortoise Shell Bracket
  0xFF09, // ） Fullwidth Right Parenthesis
  0xFF3D, // ］ Fullwidth Right Square Bracket
  0xFF5D, // ｝ Fullwidth Right Curly Bracket
  0xFF60, // ｠ Fullwidth Right White Parenthesis
  0xFF63, // ｣ Halfwidth Right Corner Bracket

// Pf group -- Final punctuations
  0x00BB, // » Right-Pointing Double Angle Quotation Mark
  0x2019, // ’ Right Single Quotation Mark
  0x201D, // ” Right Double Quotation Mark
  0x203A, // › Single Right-Pointing Angle Quotation Mark
  0x2E03, // ⸃ Right Substitution Bracket
  0x2E05, // ⸅ Right Dotted Substitution Bracket
  0x2E0A, // ⸊ Right Transposition Bracket
  0x2E0D, // ⸍ Right Raised Omission Bracket
  0x2E1D, // ⸝ Right Low Paraphrase Bracket
  0x2E21, // ⸡ Right Vertical Bar with Quill

// Pi group -- Initial punctuations
  0x00AB, // « Left-Pointing Double Angle Quotation Mark
  0x2018, // ‘ Left Single Quotation Mark
  0x201B, // ‛ Single High-Reversed-9 Quotation Mark
  0x201C, // “ Left Double Quotation Mark
  0x201F, // ‟ Double High-Reversed-9 Quotation Mark
  0x2039, // ‹ Single Left-Pointing Angle Quotation Mark
  0x2E02, // ⸂ Left Substitution Bracket
  0x2E04, // ⸄ Left Dotted Substitution Bracket
  0x2E09, // ⸉ Left Transposition Bracket
  0x2E0C, // ⸌ Left Raised Omission Bracket
  0x2E1C, // ⸜ Left Low Paraphrase Bracket
  0x2E20, // ⸠ Left Vertical Bar with Quill

// Po group -- Other punctuations
  0x0021, // ! Exclamation Mark
  0x0022, // " Quotation Mark
  0x0023, // # Number Sign
  0x0025, // % Percent Sign
  0x0026, // & Ampersand
  0x0027, // ' Apostrophe
  0x002A, // * Asterisk
  0x002C, // , Comma
  0x002E, // . Full Stop
  0x002F, // / Solidus
  0x003A, // : Colon
  0x003B, // ; Semicolon
  0x003F, // ? Question Mark
  0x0040, // @ Commercial At
  0x005C, // \ Reverse Solidus
  0x00A1, // ¡ Inverted Exclamation Mark
  0x00A7, // § Section Sign
  0x00B6, // ¶ Pilcrow Sign
  0x00B7, // · Middle Dot
  0x00BF, // ¿ Inverted Question Mark
  0x037E, // ; Greek Question Mark
  0x0387, // · Greek Ano Teleia
  0x055A, // ՚ Armenian Apostrophe
  0x055B, // ՛ Armenian Emphasis Mark
  0x055C, // ՜ Armenian Exclamation Mark
  0x055D, // ՝ Armenian Comma
  0x055E, // ՞ Armenian Question Mark
  0x055F, // ՟ Armenian Abbreviation Mark
  0x0589, // ։ Armenian Full Stop
  0x05C0, // ׀ Hebrew Punctuation Paseq
  0x05C3, // ׃ Hebrew Punctuation Sof Pasuq
  0x05C6, // ׆ Hebrew Punctuation Nun Hafukha
  0x05F3, // ׳ Hebrew Punctuation Geresh
  0x05F4, // ״ Hebrew Punctuation Gershayim
  0x0609, // ؉ Arabic-Indic Per Mille Sign
  0x060A, // ؊ Arabic-Indic Per Ten Thousand Sign
  0x060C, // ، Arabic Comma
  0x060D, // ؍ Arabic Date Separator
  0x061B, // ؛ Arabic Semicolon
  0x061E, // ؞ Arabic Triple Dot Punctuation Mark
  0x061F, // ؟ Arabic Question Mark
  0x066A, // ٪ Arabic Percent Sign
  0x066B, // ٫ Arabic Decimal Separator
  0x066C, // ٬ Arabic Thousands Separator
  0x066D, // ٭ Arabic Five Pointed Star
  0x06D4, // ۔ Arabic Full Stop
  0x0700, // ܀ Syriac End of Paragraph
  0x0701, // ܁ Syriac Supralinear Full Stop
  0x0702, // ܂ Syriac Sublinear Full Stop
  0x0703, // ܃ Syriac Supralinear Colon
  0x0704, // ܄ Syriac Sublinear Colon
  0x0705, // ܅ Syriac Horizontal Colon
  0x0706, // ܆ Syriac Colon Skewed Left
  0x0707, // ܇ Syriac Colon Skewed Right
  0x0708, // ܈ Syriac Supralinear Colon Skewed Left
  0x0709, // ܉ Syriac Sublinear Colon Skewed Right
  0x070A, // ܊ Syriac Contraction
  0x070B, // ܋ Syriac Harklean Obelus
  0x070C, // ܌ Syriac Harklean Metobelus
  0x070D, // ܍ Syriac Harklean Asteriscus
  0x07F7, // ߷ Nko Symbol Gbakurunen
  0x07F8, // ߸ Nko Comma
  0x07F9, // ߹ Nko Exclamation Mark
  0x0830, // ࠰ Samaritan Punctuation Nequdaa
  0x0831, // ࠱ Samaritan Punctuation Afsaaq
  0x0832, // ࠲ Samaritan Punctuation Anged
  0x0833, // ࠳ Samaritan Punctuation Bau
  0x0834, // ࠴ Samaritan Punctuation Atmaau
  0x0835, // ࠵ Samaritan Punctuation Shiyyaalaa
  0x0836, // ࠶ Samaritan Abbreviation Mark
  0x0837, // ࠷ Samaritan Punctuation Melodic Qitsa
  0x0838, // ࠸ Samaritan Punctuation Ziqaa
  0x0839, // ࠹ Samaritan Punctuation Qitsa
  0x083A, // ࠺ Samaritan Punctuation Zaef
  0x083B, // ࠻ Samaritan Punctuation Turu
  0x083C, // ࠼ Samaritan Punctuation Arkaanu
  0x083D, // ࠽ Samaritan Punctuation Sof Mashfaat
  0x083E, // ࠾ Samaritan Punctuation Annaau
  0x085E, // ࡞ Mandaic Punctuation
  0x0964, // । Devanagari Danda
  0x0965, // ॥ Devanagari Double Danda
  0x0970, // ॰ Devanagari Abbreviation Sign
  0x09FD, // ৽ Bengali Abbreviation Sign
  0x0A76, // ੶ Gurmukhi Abbreviation Sign
  0x0AF0, // ૰ Gujarati Abbreviation Sign
  0x0C77, // ౷ Telugu Sign Siddham
  0x0C84, // ಄ Kannada Sign Siddham
  0x0DF4, // ෴ Sinhala Punctuation Kunddaliya
  0x0E4F, // ๏ Thai Character Fongman
  0x0E5A, // ๚ Thai Character Angkhankhu
  0x0E5B, // ๛ Thai Character Khomut
  0x0F04, // ༄ Tibetan Mark Initial Yig Mgo Mdun Ma
  0x0F05, // ༅ Tibetan Mark Closing Yig Mgo Sgab Ma
  0x0F06, // ༆ Tibetan Mark Caret Yig Mgo Phur Shad Ma
  0x0F07, // ༇ Tibetan Mark Yig Mgo Tsheg Shad Ma
  0x0F08, // ༈ Tibetan Mark Sbrul Shad
  0x0F09, // ༉ Tibetan Mark Bskur Yig Mgo
  0x0F0A, // ༊ Tibetan Mark Bka-undefined Shog Yig Mgo
  0x0F0B, // ་ Tibetan Mark Intersyllabic Tsheg
  0x0F0C, // ༌ Tibetan Mark Delimiter Tsheg Bstar
  0x0F0D, // ། Tibetan Mark Shad
  0x0F0E, // ༎ Tibetan Mark Nyis Shad
  0x0F0F, // ༏ Tibetan Mark Tsheg Shad
  0x0F10, // ༐ Tibetan Mark Nyis Tsheg Shad
  0x0F11, // ༑ Tibetan Mark Rin Chen Spungs Shad
  0x0F12, // ༒ Tibetan Mark Rgya Gram Shad
  0x0F14, // ༔ Tibetan Mark Gter Tsheg
  0x0F85, // ྅ Tibetan Mark Paluta
  0x0FD0, // ࿐ Tibetan Mark Bska-undefined Shog Gi Mgo Rgyan
  0x0FD1, // ࿑ Tibetan Mark Mnyam Yig Gi Mgo Rgyan
  0x0FD2, // ࿒ Tibetan Mark Nyis Tsheg
  0x0FD3, // ࿓ Tibetan Mark Initial Brda Rnying Yig Mgo Mdun Ma
  0x0FD4, // ࿔ Tibetan Mark Closing Brda Rnying Yig Mgo Sgab Ma
  0x0FD9, // ࿙ Tibetan Mark Leading Mchan Rtags
  0x0FDA, // ࿚ Tibetan Mark Trailing Mchan Rtags
  0x104A, // ၊ Myanmar Sign Little Section
  0x104B, // ။ Myanmar Sign Section
  0x104C, // ၌ Myanmar Symbol Locative
  0x104D, // ၍ Myanmar Symbol Completed
  0x104E, // ၎ Myanmar Symbol Aforementioned
  0x104F, // ၏ Myanmar Symbol Genitive
  0x10FB, // ჻ Georgian Paragraph Separator
  0x1360, // ፠ Ethiopic Section Mark
  0x1361, // ፡ Ethiopic Wordspace
  0x1362, // ። Ethiopic Full Stop
  0x1363, // ፣ Ethiopic Comma
  0x1364, // ፤ Ethiopic Semicolon
  0x1365, // ፥ Ethiopic Colon
  0x1366, // ፦ Ethiopic Preface Colon
  0x1367, // ፧ Ethiopic Question Mark
  0x1368, // ፨ Ethiopic Paragraph Separator
  0x166E, // ᙮ Canadian Syllabics Full Stop
  0x16EB, // ᛫ Runic Single Punctuation
  0x16EC, // ᛬ Runic Multiple Punctuation
  0x16ED, // ᛭ Runic Cross Punctuation
  0x1735, // ᜵ Philippine Single Punctuation
  0x1736, // ᜶ Philippine Double Punctuation
  0x17D4, // ។ Khmer Sign Khan
  0x17D5, // ៕ Khmer Sign Bariyoosan
  0x17D6, // ៖ Khmer Sign Camnuc Pii Kuuh
  0x17D8, // ៘ Khmer Sign Beyyal
  0x17D9, // ៙ Khmer Sign Phnaek Muan
  0x17DA, // ៚ Khmer Sign Koomuut
  0x1800, // ᠀ Mongolian Birga
  0x1801, // ᠁ Mongolian Ellipsis
  0x1802, // ᠂ Mongolian Comma
  0x1803, // ᠃ Mongolian Full Stop
  0x1804, // ᠄ Mongolian Colon
  0x1805, // ᠅ Mongolian Four Dots
  0x1807, // ᠇ Mongolian Sibe Syllable Boundary Marker
  0x1808, // ᠈ Mongolian Manchu Comma
  0x1809, // ᠉ Mongolian Manchu Full Stop
  0x180A, // ᠊ Mongolian Nirugu
  0x1944, // ᥄ Limbu Exclamation Mark
  0x1945, // ᥅ Limbu Question Mark
  0x1A1E, // ᨞ Buginese Pallawa
  0x1A1F, // ᨟ Buginese End of Section
  0x1AA0, // ᪠ Tai Tham Sign Wiang
  0x1AA1, // ᪡ Tai Tham Sign Wiangwaak
  0x1AA2, // ᪢ Tai Tham Sign Sawan
  0x1AA3, // ᪣ Tai Tham Sign Keow
  0x1AA4, // ᪤ Tai Tham Sign Hoy
  0x1AA5, // ᪥ Tai Tham Sign Dokmai
  0x1AA6, // ᪦ Tai Tham Sign Reversed Rotated Rana
  0x1AA8, // ᪨ Tai Tham Sign Kaan
  0x1AA9, // ᪩ Tai Tham Sign Kaankuu
  0x1AAA, // ᪪ Tai Tham Sign Satkaan
  0x1AAB, // ᪫ Tai Tham Sign Satkaankuu
  0x1AAC, // ᪬ Tai Tham Sign Hang
  0x1AAD, // ᪭ Tai Tham Sign Caang
  0x1B5A, // ᭚ Balinese Panti
  0x1B5B, // ᭛ Balinese Pamada
  0x1B5C, // ᭜ Balinese Windu
  0x1B5D, // ᭝ Balinese Carik Pamungkah
  0x1B5E, // ᭞ Balinese Carik Siki
  0x1B5F, // ᭟ Balinese Carik Pareren
  0x1B60, // ᭠ Balinese Pameneng
  0x1BFC, // ᯼ Batak Symbol Bindu Na Metek
  0x1BFD, // ᯽ Batak Symbol Bindu Pinarboras
  0x1BFE, // ᯾ Batak Symbol Bindu Judul
  0x1BFF, // ᯿ Batak Symbol Bindu Pangolat
  0x1C3B, // ᰻ Lepcha Punctuation Ta-Rol
  0x1C3C, // ᰼ Lepcha Punctuation Nyet Thyoom Ta-Rol
  0x1C3D, // ᰽ Lepcha Punctuation Cer-Wa
  0x1C3E, // ᰾ Lepcha Punctuation Tshook Cer-Wa
  0x1C3F, // ᰿ Lepcha Punctuation Tshook
  0x1C7E, // ᱾ Ol Chiki Punctuation Mucaad
  0x1C7F, // ᱿ Ol Chiki Punctuation Double Mucaad
  0x1CC0, // ᳀ Sundanese Punctuation Bindu Surya
  0x1CC1, // ᳁ Sundanese Punctuation Bindu Panglong
  0x1CC2, // ᳂ Sundanese Punctuation Bindu Purnama
  0x1CC3, // ᳃ Sundanese Punctuation Bindu Cakra
  0x1CC4, // ᳄ Sundanese Punctuation Bindu Leu Satanga
  0x1CC5, // ᳅ Sundanese Punctuation Bindu Ka Satanga
  0x1CC6, // ᳆ Sundanese Punctuation Bindu Da Satanga
  0x1CC7, // ᳇ Sundanese Punctuation Bindu Ba Satanga
  0x1CD3, // ᳓ Vedic Sign Nihshvasa
  0x2016, // ‖ Double Vertical Line
  0x2017, // ‗ Double Low Line
  0x2020, // † Dagger
  0x2021, // ‡ Double Dagger
  0x2022, // • Bullet
  0x2023, // ‣ Triangular Bullet
  0x2024, // ․ One Dot Leader
  0x2025, // ‥ Two Dot Leader
  0x2026, // … Horizontal Ellipsis
  0x2027, // ‧ Hyphenation Point
  0x2030, // ‰ Per Mille Sign
  0x2031, // ‱ Per Ten Thousand Sign
  0x2032, // ′ Prime
  0x2033, // ″ Double Prime
  0x2034, // ‴ Triple Prime
  0x2035, // ‵ Reversed Prime
  0x2036, // ‶ Reversed Double Prime
  0x2037, // ‷ Reversed Triple Prime
  0x2038, // ‸ Caret
  0x203B, // ※ Reference Mark
  0x203C, // ‼ Double Exclamation Mark
  0x203D, // ‽ Interrobang
  0x203E, // ‾ Overline
  0x2041, // ⁁ Caret Insertion Point
  0x2042, // ⁂ Asterism
  0x2043, // ⁃ Hyphen Bullet
  0x2047, // ⁇ Double Question Mark
  0x2048, // ⁈ Question Exclamation Mark
  0x2049, // ⁉ Exclamation Question Mark
  0x204A, // ⁊ Tironian Sign Et
  0x204B, // ⁋ Reversed Pilcrow Sign
  0x204C, // ⁌ Black Leftwards Bullet
  0x204D, // ⁍ Black Rightwards Bullet
  0x204E, // ⁎ Low Asterisk
  0x204F, // ⁏ Reversed Semicolon
  0x2050, // ⁐ Close Up
  0x2051, // ⁑ Two Asterisks Aligned Vertically
  0x2053, // ⁓ Swung Dash
  0x2055, // ⁕ Flower Punctuation Mark
  0x2056, // ⁖ Three Dot Punctuation
  0x2057, // ⁗ Quadruple Prime
  0x2058, // ⁘ Four Dot Punctuation
  0x2059, // ⁙ Five Dot Punctuation
  0x205A, // ⁚ Two Dot Punctuation
  0x205B, // ⁛ Four Dot Mark
  0x205C, // ⁜ Dotted Cross
  0x205D, // ⁝ Tricolon
  0x205E, // ⁞ Vertical Four Dots
  0x2CF9, // ⳹ Coptic Old Nubian Full Stop
  0x2CFA, // ⳺ Coptic Old Nubian Direct Question Mark
  0x2CFB, // ⳻ Coptic Old Nubian Indirect Question Mark
  0x2CFC, // ⳼ Coptic Old Nubian Verse Divider
  0x2CFE, // ⳾ Coptic Full Stop
  0x2CFF, // ⳿ Coptic Morphological Divider
  0x2D70, // ⵰ Tifinagh Separator Mark
  0x2E00, // ⸀ Right Angle Substitution Marker
  0x2E01, // ⸁ Right Angle Dotted Substitution Marker
  0x2E06, // ⸆ Raised Interpolation Marker
  0x2E07, // ⸇ Raised Dotted Interpolation Marker
  0x2E08, // ⸈ Dotted Transposition Marker
  0x2E0B, // ⸋ Raised Square
  0x2E0E, // ⸎ Editorial Coronis
  0x2E0F, // ⸏ Paragraphos
  0x2E10, // ⸐ Forked Paragraphos
  0x2E11, // ⸑ Reversed Forked Paragraphos
  0x2E12, // ⸒ Hypodiastole
  0x2E13, // ⸓ Dotted Obelos
  0x2E14, // ⸔ Downwards Ancora
  0x2E15, // ⸕ Upwards Ancora
  0x2E16, // ⸖ Dotted Right-Pointing Angle
  0x2E18, // ⸘ Inverted Interrobang
  0x2E19, // ⸙ Palm Branch
  0x2E1B, // ⸛ Tilde with Ring Above
  0x2E1E, // ⸞ Tilde with Dot Above
  0x2E1F, // ⸟ Tilde with Dot Below
  0x2E2A, // ⸪ Two Dots Over One Dot Punctuation
  0x2E2B, // ⸫ One Dot Over Two Dots Punctuation
  0x2E2C, // ⸬ Squared Four Dot Punctuation
  0x2E2D, // ⸭ Five Dot Mark
  0x2E2E, // ⸮ Reversed Question Mark
  0x2E30, // ⸰ Ring Point
  0x2E31, // ⸱ Word Separator Middle Dot
  0x2E32, // ⸲ Turned Comma
  0x2E33, // ⸳ Raised Dot
  0x2E34, // ⸴ Raised Comma
  0x2E35, // ⸵ Turned Semicolon
  0x2E36, // ⸶ Dagger with Left Guard
  0x2E37, // ⸷ Dagger with Right Guard
  0x2E38, // ⸸ Turned Dagger
  0x2E39, // ⸹ Top Half Section Sign
  0x2E3C, // ⸼ Stenographic Full Stop
  0x2E3D, // ⸽ Vertical Six Dots
  0x2E3E, // ⸾ Wiggly Vertical Line
  0x2E3F, // ⸿ Capitulum
  0x2E41, // ⹁ Reversed Comma
  0x2E43, // ⹃ Dash with Left Upturn
  0x2E44, // ⹄ Double Suspension Mark
  0x2E45, // ⹅ Inverted Low Kavyka
  0x2E46, // ⹆ Inverted Low Kavyka with Kavyka Above
  0x2E47, // ⹇ Low Kavyka
  0x2E48, // ⹈ Low Kavyka with Dot
  0x2E49, // ⹉ Double Stacked Comma
  0x2E4A, // ⹊ Dotted Solidus
  0x2E4B, // ⹋ Triple Dagger
  0x2E4C, // ⹌ Medieval Comma
  0x2E4D, // ⹍ Paragraphus Mark
  0x2E4E, // ⹎ Punctus Elevatus Mark
  0x2E4F, // ⹏ Cornish Verse Divider
  0x2E52, // ⹒ Tironian Sign Capital Et
  0x3001, // 、 Ideographic Comma
  0x3002, // 。 Ideographic Full Stop
  0x3003, // 〃 Ditto Mark
  0x303D, // 〽 Part Alternation Mark
  0x30FB, // ・ Katakana Middle Dot
  0xA4FE, // ꓾ Lisu Punctuation Comma
  0xA4FF, // ꓿ Lisu Punctuation Full Stop
  0xA60D, // ꘍ Vai Comma
  0xA60E, // ꘎ Vai Full Stop
  0xA60F, // ꘏ Vai Question Mark
  0xA673, // ꙳ Slavonic Asterisk
  0xA67E, // ꙾ Cyrillic Kavyka
  0xA6F2, // ꛲ Bamum Njaemli
  0xA6F3, // ꛳ Bamum Full Stop
  0xA6F4, // ꛴ Bamum Colon
  0xA6F5, // ꛵ Bamum Comma
  0xA6F6, // ꛶ Bamum Semicolon
  0xA6F7, // ꛷ Bamum Question Mark
  0xA874, // ꡴ Phags-Pa Single Head Mark
  0xA875, // ꡵ Phags-Pa Double Head Mark
  0xA876, // ꡶ Phags-Pa Mark Shad
  0xA877, // ꡷ Phags-Pa Mark Double Shad
  0xA8CE, // ꣎ Saurashtra Danda
  0xA8CF, // ꣏ Saurashtra Double Danda
  0xA8F8, // ꣸ Devanagari Sign Pushpika
  0xA8F9, // ꣹ Devanagari Gap Filler
  0xA8FA, // ꣺ Devanagari Caret
  0xA8FC, // ꣼ Devanagari Sign Siddham
  0xA92E, // ꤮ Kayah Li Sign Cwi
  0xA92F, // ꤯ Kayah Li Sign Shya
  0xA95F, // ꥟ Rejang Section Mark
  0xA9C1, // ꧁ Javanese Left Rerenggan
  0xA9C2, // ꧂ Javanese Right Rerenggan
  0xA9C3, // ꧃ Javanese Pada Andap
  0xA9C4, // ꧄ Javanese Pada Madya
  0xA9C5, // ꧅ Javanese Pada Luhur
  0xA9C6, // ꧆ Javanese Pada Windu
  0xA9C7, // ꧇ Javanese Pada Pangkat
  0xA9C8, // ꧈ Javanese Pada Lingsa
  0xA9C9, // ꧉ Javanese Pada Lungsi
  0xA9CA, // ꧊ Javanese Pada Adeg
  0xA9CB, // ꧋ Javanese Pada Adeg Adeg
  0xA9CC, // ꧌ Javanese Pada Piseleh
  0xA9CD, // ꧍ Javanese Turned Pada Piseleh
  0xA9DE, // ꧞ Javanese Pada Tirta Tumetes
  0xA9DF, // ꧟ Javanese Pada Isen-Isen
  0xAA5C, // ꩜ Cham Punctuation Spiral
  0xAA5D, // ꩝ Cham Punctuation Danda
  0xAA5E, // ꩞ Cham Punctuation Double Danda
  0xAA5F, // ꩟ Cham Punctuation Triple Danda
  0xAADE, // ꫞ Tai Viet Symbol Ho Hoi
  0xAADF, // ꫟ Tai Viet Symbol Koi Koi
  0xAAF0, // ꫰ Meetei Mayek Cheikhan
  0xAAF1, // ꫱ Meetei Mayek Ahang Khudam
  0xABEB, // ꯫ Meetei Mayek Cheikhei
  0xFE10, // ︐ Presentation Form For Vertical Comma
  0xFE11, // ︑ Presentation Form For Vertical Ideographic Comma
  0xFE12, // ︒ Presentation Form For Vertical Ideographic Full Stop
  0xFE13, // ︓ Presentation Form For Vertical Colon
  0xFE14, // ︔ Presentation Form For Vertical Semicolon
  0xFE15, // ︕ Presentation Form For Vertical Exclamation Mark
  0xFE16, // ︖ Presentation Form For Vertical Question Mark
  0xFE19, // ︙ Presentation Form For Vertical Horizontal Ellipsis
  0xFE30, // ︰ Presentation Form For Vertical Two Dot Leader
  0xFE45, // ﹅ Sesame Dot
  0xFE46, // ﹆ White Sesame Dot
  0xFE49, // ﹉ Dashed Overline
  0xFE4A, // ﹊ Centreline Overline
  0xFE4B, // ﹋ Wavy Overline
  0xFE4C, // ﹌ Double Wavy Overline
  0xFE50, // ﹐ Small Comma
  0xFE51, // ﹑ Small Ideographic Comma
  0xFE52, // ﹒ Small Full Stop
  0xFE54, // ﹔ Small Semicolon
  0xFE55, // ﹕ Small Colon
  0xFE56, // ﹖ Small Question Mark
  0xFE57, // ﹗ Small Exclamation Mark
  0xFE5F, // ﹟ Small Number Sign
  0xFE60, // ﹠ Small Ampersand
  0xFE61, // ﹡ Small Asterisk
  0xFE68, // ﹨ Small Reverse Solidus
  0xFE6A, // ﹪ Small Percent Sign
  0xFE6B, // ﹫ Small Commercial At
  0xFF01, // ！ Fullwidth Exclamation Mark
  0xFF02, // ＂ Fullwidth Quotation Mark
  0xFF03, // ＃ Fullwidth Number Sign
  0xFF05, // ％ Fullwidth Percent Sign
  0xFF06, // ＆ Fullwidth Ampersand
  0xFF07, // ＇ Fullwidth Apostrophe
  0xFF0A, // ＊ Fullwidth Asterisk
  0xFF0C, // ， Fullwidth Comma
  0xFF0E, // ． Fullwidth Full Stop
  0xFF0F, // ／ Fullwidth Solidus
  0xFF1A, // ： Fullwidth Colon
  0xFF1B, // ； Fullwidth Semicolon
  0xFF1F, // ？ Fullwidth Question Mark
  0xFF20, // ＠ Fullwidth Commercial At
  0xFF3C, // ＼ Fullwidth Reverse Solidus
  0xFF61, // ｡ Halfwidth Ideographic Full Stop
  0xFF64, // ､ Halfwidth Ideographic Comma
  0xFF65, // ･ Halfwidth Katakana Middle Dot
  0x10100, // 𐄀 Aegean Word Separator Line
  0x10101, // 𐄁 Aegean Word Separator Dot
  0x10102, // 𐄂 Aegean Check Mark
  0x1039F, // 𐎟 Ugaritic Word Divider
  0x103D0, // 𐏐 Old Persian Word Divider
  0x1056F, // 𐕯 Caucasian Albanian Citation Mark
  0x10857, // 𐡗 Imperial Aramaic Section Sign
  0x1091F, // 𐤟 Phoenician Word Separator
  0x1093F, // 𐤿 Lydian Triangular Mark
  0x10A50, // 𐩐 Kharoshthi Punctuation Dot
  0x10A51, // 𐩑 Kharoshthi Punctuation Small Circle
  0x10A52, // 𐩒 Kharoshthi Punctuation Circle
  0x10A53, // 𐩓 Kharoshthi Punctuation Crescent Bar
  0x10A54, // 𐩔 Kharoshthi Punctuation Mangalam
  0x10A55, // 𐩕 Kharoshthi Punctuation Lotus
  0x10A56, // 𐩖 Kharoshthi Punctuation Danda
  0x10A57, // 𐩗 Kharoshthi Punctuation Double Danda
  0x10A58, // 𐩘 Kharoshthi Punctuation Lines
  0x10A7F, // 𐩿 Old South Arabian Numeric Indicator
  0x10AF0, // 𐫰 Manichaean Punctuation Star
  0x10AF1, // 𐫱 Manichaean Punctuation Fleuron
  0x10AF2, // 𐫲 Manichaean Punctuation Double Dot Within Dot
  0x10AF3, // 𐫳 Manichaean Punctuation Dot Within Dot
  0x10AF4, // 𐫴 Manichaean Punctuation Dot
  0x10AF5, // 𐫵 Manichaean Punctuation Two Dots
  0x10AF6, // 𐫶 Manichaean Punctuation Line Filler
  0x10B39, // 𐬹 Avestan Abbreviation Mark
  0x10B3A, // 𐬺 Tiny Two Dots Over One Dot Punctuation
  0x10B3B, // 𐬻 Small Two Dots Over One Dot Punctuation
  0x10B3C, // 𐬼 Large Two Dots Over One Dot Punctuation
  0x10B3D, // 𐬽 Large One Dot Over Two Dots Punctuation
  0x10B3E, // 𐬾 Large Two Rings Over One Ring Punctuation
  0x10B3F, // 𐬿 Large One Ring Over Two Rings Punctuation
  0x10B99, // 𐮙 Psalter Pahlavi Section Mark
  0x10B9A, // 𐮚 Psalter Pahlavi Turned Section Mark
  0x10B9B, // 𐮛 Psalter Pahlavi Four Dots with Cross
  0x10B9C, // 𐮜 Psalter Pahlavi Four Dots with Dot
  0x10F55, // 𐽕 Sogdian Punctuation Two Vertical Bars
  0x10F56, // 𐽖 Sogdian Punctuation Two Vertical Bars with Dots
  0x10F57, // 𐽗 Sogdian Punctuation Circle with Dot
  0x10F58, // 𐽘 Sogdian Punctuation Two Circles with Dots
  0x10F59, // 𐽙 Sogdian Punctuation Half Circle with Dot
  0x11047, // 𑁇 Brahmi Danda
  0x11048, // 𑁈 Brahmi Double Danda
  0x11049, // 𑁉 Brahmi Punctuation Dot
  0x1104A, // 𑁊 Brahmi Punctuation Double Dot
  0x1104B, // 𑁋 Brahmi Punctuation Line
  0x1104C, // 𑁌 Brahmi Punctuation Crescent Bar
  0x1104D, // 𑁍 Brahmi Punctuation Lotus
  0x110BB, // 𑂻 Kaithi Abbreviation Sign
  0x110BC, // 𑂼 Kaithi Enumeration Sign
  0x110BE, // 𑂾 Kaithi Section Mark
  0x110BF, // 𑂿 Kaithi Double Section Mark
  0x110C0, // 𑃀 Kaithi Danda
  0x110C1, // 𑃁 Kaithi Double Danda
  0x11140, // 𑅀 Chakma Section Mark
  0x11141, // 𑅁 Chakma Danda
  0x11142, // 𑅂 Chakma Double Danda
  0x11143, // 𑅃 Chakma Question Mark
  0x11174, // 𑅴 Mahajani Abbreviation Sign
  0x11175, // 𑅵 Mahajani Section Mark
  0x111C5, // 𑇅 Sharada Danda
  0x111C6, // 𑇆 Sharada Double Danda
  0x111C7, // 𑇇 Sharada Abbreviation Sign
  0x111C8, // 𑇈 Sharada Separator
  0x111CD, // 𑇍 Sharada Sutra Mark
  0x111DB, // 𑇛 Sharada Sign Siddham
  0x111DD, // 𑇝 Sharada Continuation Sign
  0x111DE, // 𑇞 Sharada Section Mark-1
  0x111DF, // 𑇟 Sharada Section Mark-2
  0x11238, // 𑈸 Khojki Danda
  0x11239, // 𑈹 Khojki Double Danda
  0x1123A, // 𑈺 Khojki Word Separator
  0x1123B, // 𑈻 Khojki Section Mark
  0x1123C, // 𑈼 Khojki Double Section Mark
  0x1123D, // 𑈽 Khojki Abbreviation Sign
  0x112A9, // 𑊩 Multani Section Mark
  0x1144B, // 𑑋 Newa Danda
  0x1144C, // 𑑌 Newa Double Danda
  0x1144D, // 𑑍 Newa Comma
  0x1144E, // 𑑎 Newa Gap Filler
  0x1144F, // 𑑏 Newa Abbreviation Sign
  0x1145A, // 𑑚 Newa Double Comma
  0x1145B, // 𑑛 Newa Placeholder Mark
  0x1145D, // 𑑝 Newa Insertion Sign
  0x114C6, // 𑓆 Tirhuta Abbreviation Sign
  0x115C1, // 𑗁 Siddham Sign Siddham
  0x115C2, // 𑗂 Siddham Danda
  0x115C3, // 𑗃 Siddham Double Danda
  0x115C4, // 𑗄 Siddham Separator Dot
  0x115C5, // 𑗅 Siddham Separator Bar
  0x115C6, // 𑗆 Siddham Repetition Mark-1
  0x115C7, // 𑗇 Siddham Repetition Mark-2
  0x115C8, // 𑗈 Siddham Repetition Mark-3
  0x115C9, // 𑗉 Siddham End of Text Mark
  0x115CA, // 𑗊 Siddham Section Mark with Trident and U-Shaped Ornaments
  0x115CB, // 𑗋 Siddham Section Mark with Trident and Dotted Crescents
  0x115CC, // 𑗌 Siddham Section Mark with Rays and Dotted Crescents
  0x115CD, // 𑗍 Siddham Section Mark with Rays and Dotted Double Crescents
  0x115CE, // 𑗎 Siddham Section Mark with Rays and Dotted Triple Crescents
  0x115CF, // 𑗏 Siddham Section Mark Double Ring
  0x115D0, // 𑗐 Siddham Section Mark Double Ring with Rays
  0x115D1, // 𑗑 Siddham Section Mark with Double Crescents
  0x115D2, // 𑗒 Siddham Section Mark with Triple Crescents
  0x115D3, // 𑗓 Siddham Section Mark with Quadruple Crescents
  0x115D4, // 𑗔 Siddham Section Mark with Septuple Crescents
  0x115D5, // 𑗕 Siddham Section Mark with Circles and Rays
  0x115D6, // 𑗖 Siddham Section Mark with Circles and Two Enclosures
  0x115D7, // 𑗗 Siddham Section Mark with Circles and Four Enclosures
  0x11641, // 𑙁 Modi Danda
  0x11642, // 𑙂 Modi Double Danda
  0x11643, // 𑙃 Modi Abbreviation Sign
  0x11660, // 𑙠 Mongolian Birga with Ornament
  0x11661, // 𑙡 Mongolian Rotated Birga
  0x11662, // 𑙢 Mongolian Double Birga with Ornament
  0x11663, // 𑙣 Mongolian Triple Birga with Ornament
  0x11664, // 𑙤 Mongolian Birga with Double Ornament
  0x11665, // 𑙥 Mongolian Rotated Birga with Ornament
  0x11666, // 𑙦 Mongolian Rotated Birga with Double Ornament
  0x11667, // 𑙧 Mongolian Inverted Birga
  0x11668, // 𑙨 Mongolian Inverted Birga with Double Ornament
  0x11669, // 𑙩 Mongolian Swirl Birga
  0x1166A, // 𑙪 Mongolian Swirl Birga with Ornament
  0x1166B, // 𑙫 Mongolian Swirl Birga with Double Ornament
  0x1166C, // 𑙬 Mongolian Turned Swirl Birga with Double Ornament
  0x1173C, // 𑜼 Ahom Sign Small Section
  0x1173D, // 𑜽 Ahom Sign Section
  0x1173E, // 𑜾 Ahom Sign Rulai
  0x1183B, // 𑠻 Dogra Abbreviation Sign
  0x11944, // 𑥄 Dives Akuru Double Danda
  0x11945, // 𑥅 Dives Akuru Gap Filler
  0x11946, // 𑥆 Dives Akuru End of Text Mark
  0x119E2, // 𑧢 Nandinagari Sign Siddham
  0x11A3F, // 𑨿 Zanabazar Square Initial Head Mark
  0x11A40, // 𑩀 Zanabazar Square Closing Head Mark
  0x11A41, // 𑩁 Zanabazar Square Mark Tsheg
  0x11A42, // 𑩂 Zanabazar Square Mark Shad
  0x11A43, // 𑩃 Zanabazar Square Mark Double Shad
  0x11A44, // 𑩄 Zanabazar Square Mark Long Tsheg
  0x11A45, // 𑩅 Zanabazar Square Initial Double-Lined Head Mark
  0x11A46, // 𑩆 Zanabazar Square Closing Double-Lined Head Mark
  0x11A9A, // 𑪚 Soyombo Mark Tsheg
  0x11A9B, // 𑪛 Soyombo Mark Shad
  0x11A9C, // 𑪜 Soyombo Mark Double Shad
  0x11A9E, // 𑪞 Soyombo Head Mark with Moon and Sun and Triple Flame
  0x11A9F, // 𑪟 Soyombo Head Mark with Moon and Sun and Flame
  0x11AA0, // 𑪠 Soyombo Head Mark with Moon and Sun
  0x11AA1, // 𑪡 Soyombo Terminal Mark-1
  0x11AA2, // 𑪢 Soyombo Terminal Mark-2
  0x11C41, // 𑱁 Bhaiksuki Danda
  0x11C42, // 𑱂 Bhaiksuki Double Danda
  0x11C43, // 𑱃 Bhaiksuki Word Separator
  0x11C44, // 𑱄 Bhaiksuki Gap Filler-1
  0x11C45, // 𑱅 Bhaiksuki Gap Filler-2
  0x11C70, // 𑱰 Marchen Head Mark
  0x11C71, // 𑱱 Marchen Mark Shad
  0x11EF7, // 𑻷 Makasar Passimbang
  0x11EF8, // 𑻸 Makasar End of Section
  0x11FFF, // 𑿿 Tamil Punctuation End of Text
  0x12470, // 𒑰 Cuneiform Punctuation Sign Old Assyrian Word Divider
  0x12471, // 𒑱 Cuneiform Punctuation Sign Vertical Colon
  0x12472, // 𒑲 Cuneiform Punctuation Sign Diagonal Colon
  0x12473, // 𒑳 Cuneiform Punctuation Sign Diagonal Tricolon
  0x12474, // 𒑴 Cuneiform Punctuation Sign Diagonal Quadcolon
  0x16A6E, // 𖩮 Mro Danda
  0x16A6F, // 𖩯 Mro Double Danda
  0x16AF5, // 𖫵 Bassa Vah Full Stop
  0x16B37, // 𖬷 Pahawh Hmong Sign Vos Thom
  0x16B38, // 𖬸 Pahawh Hmong Sign Vos Tshab Ceeb
  0x16B39, // 𖬹 Pahawh Hmong Sign Cim Cheem
  0x16B3A, // 𖬺 Pahawh Hmong Sign Vos Thiab
  0x16B3B, // 𖬻 Pahawh Hmong Sign Vos Feem
  0x16B44, // 𖭄 Pahawh Hmong Sign Xaus
  0x16E97, // 𖺗 Medefaidrin Comma
  0x16E98, // 𖺘 Medefaidrin Full Stop
  0x16E99, // 𖺙 Medefaidrin Symbol Aiva
  0x16E9A, // 𖺚 Medefaidrin Exclamation Oh
  0x16FE2, // 𖿢 Old Chinese Hook Mark
  0x1BC9F, // 𛲟 Duployan Punctuation Chinook Full Stop
  0x1DA87, // 𝪇 Signwriting Comma
  0x1DA88, // 𝪈 Signwriting Full Stop
  0x1DA89, // 𝪉 Signwriting Semicolon
  0x1DA8A, // 𝪊 Signwriting Colon
  0x1DA8B, // 𝪋 Signwriting Parenthesis
  0x1E95E, // 𞥞 Adlam Initial Exclamation Mark
  0x1E95F, // 𞥟 Adlam Initial Question Mark

// Ps group -- Open punctuation
  0x0028, // ( Left Parenthesis
  0x005B, // [ Left Square Bracket
  0x007B, // { Left Curly Bracket
  0x0F3A, // ༺ Tibetan Mark Gug Rtags Gyon
  0x0F3C, // ༼ Tibetan Mark Ang Khang Gyon
  0x169B, // ᚛ Ogham Feather Mark
  0x201A, // ‚ Single Low-9 Quotation Mark
  0x201E, // „ Double Low-9 Quotation Mark
  0x2045, // ⁅ Left Square Bracket with Quill
  0x207D, // ⁽ Superscript Left Parenthesis
  0x208D, // ₍ Subscript Left Parenthesis
  0x2308, // ⌈ Left Ceiling
  0x230A, // ⌊ Left Floor
  0x2329, // 〈 Left-Pointing Angle Bracket
  0x2768, // ❨ Medium Left Parenthesis Ornament
  0x276A, // ❪ Medium Flattened Left Parenthesis Ornament
  0x276C, // ❬ Medium Left-Pointing Angle Bracket Ornament
  0x276E, // ❮ Heavy Left-Pointing Angle Quotation Mark Ornament
  0x2770, // ❰ Heavy Left-Pointing Angle Bracket Ornament
  0x2772, // ❲ Light Left Tortoise Shell Bracket Ornament
  0x2774, // ❴ Medium Left Curly Bracket Ornament
  0x27C5, // ⟅ Left S-Shaped Bag Delimiter
  0x27E6, // ⟦ Mathematical Left White Square Bracket
  0x27E8, // ⟨ Mathematical Left Angle Bracket
  0x27EA, // ⟪ Mathematical Left Double Angle Bracket
  0x27EC, // ⟬ Mathematical Left White Tortoise Shell Bracket
  0x27EE, // ⟮ Mathematical Left Flattened Parenthesis
  0x2983, // ⦃ Left White Curly Bracket
  0x2985, // ⦅ Left White Parenthesis
  0x2987, // ⦇ Z Notation Left Image Bracket
  0x2989, // ⦉ Z Notation Left Binding Bracket
  0x298B, // ⦋ Left Square Bracket with Underbar
  0x298D, // ⦍ Left Square Bracket with Tick In Top Corner
  0x298F, // ⦏ Left Square Bracket with Tick In Bottom Corner
  0x2991, // ⦑ Left Angle Bracket with Dot
  0x2993, // ⦓ Left Arc Less-Than Bracket
  0x2995, // ⦕ Double Left Arc Greater-Than Bracket
  0x2997, // ⦗ Left Black Tortoise Shell Bracket
  0x29D8, // ⧘ Left Wiggly Fence
  0x29DA, // ⧚ Left Double Wiggly Fence
  0x29FC, // ⧼ Left-Pointing Curved Angle Bracket
  0x2E22, // ⸢ Top Left Half Bracket
  0x2E24, // ⸤ Bottom Left Half Bracket
  0x2E26, // ⸦ Left Sideways U Bracket
  0x2E28, // ⸨ Left Double Parenthesis
  0x2E42, // ⹂ Double Low-Reversed-9 Quotation Mark
  0x3008, // 〈 Left Angle Bracket
  0x300A, // 《 Left Double Angle Bracket
  0x300C, // 「 Left Corner Bracket
  0x300E, // 『 Left White Corner Bracket
  0x3010, // 【 Left Black Lenticular Bracket
  0x3014, // 〔 Left Tortoise Shell Bracket
  0x3016, // 〖 Left White Lenticular Bracket
  0x3018, // 〘 Left White Tortoise Shell Bracket
  0x301A, // 〚 Left White Square Bracket
  0x301D, // 〝 Reversed Double Prime Quotation Mark
  0xFD3F, // ﴿ Ornate Right Parenthesis
  0xFE17, // ︗ Presentation Form For Vertical Left White Lenticular Bracket
  0xFE35, // ︵ Presentation Form For Vertical Left Parenthesis
  0xFE37, // ︷ Presentation Form For Vertical Left Curly Bracket
  0xFE39, // ︹ Presentation Form For Vertical Left Tortoise Shell Bracket
  0xFE3B, // ︻ Presentation Form For Vertical Left Black Lenticular Bracket
  0xFE3D, // ︽ Presentation Form For Vertical Left Double Angle Bracket
  0xFE3F, // ︿ Presentation Form For Vertical Left Angle Bracket
  0xFE41, // ﹁ Presentation Form For Vertical Left Corner Bracket
  0xFE43, // ﹃ Presentation Form For Vertical Left White Corner Bracket
  0xFE47, // ﹇ Presentation Form For Vertical Left Square Bracket
  0xFE59, // ﹙ Small Left Parenthesis
  0xFE5B, // ﹛ Small Left Curly Bracket
  0xFE5D, // ﹝ Small Left Tortoise Shell Bracket
  0xFF08, // （ Fullwidth Left Parenthesis
  0xFF3B, // ［ Fullwidth Left Square Bracket
  0xFF5B, // ｛ Fullwidth Left Curly Bracket
  0xFF5F, // ｟ Fullwidth Left White Parenthesis
  0xFF62, // ｢ Halfwidth Left Corner Bracket
};
