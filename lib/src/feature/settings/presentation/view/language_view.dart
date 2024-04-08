import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/snackbar_service.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/basic_sliver_appbar.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/sliverAppbarwithSearchbar.dart';

class LanguageSelectionView extends StatefulWidget {
  static String routePath = '/language-selection-view';

  const LanguageSelectionView({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  bool _isSliverAppBarExpanded = false;

  List<String> allLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Russian',
    'Italian',
    'Portuguese',
    'Dutch',
    'Turkish',
    'Swedish',
    'Danish',
    'Norwegian',
    'Finnish',
    'Greek',
    'Hebrew',
    'Hindi',
    'Bengali',
  ];

  String selectedLanguage = 'English';
  List<String> filteredLanguages = [];

  Map<String, String> languageSubtitles = {
    'English': 'Hello, this is English',
    'Spanish': 'Hola, esto es español',
    'French': 'Bonjour, c\'est le français',
    'German': 'Hallo, das ist Deutsch',
    'Chinese': '你好，这是中文',
    'Japanese': 'こんにちは、これは日本語です',
    'Korean': '안녕하세요, 이것은 한국어입니다',
    'Arabic': 'مرحبًا، هذا باللغة العربية',
    'Russian': 'Привет, это по-русски',
    'Italian': 'Ciao, questo è italiano',
    'Portuguese': 'Olá, isto é português',
    'Dutch': 'Hallo, dit is Nederlands',
    'Turkish': 'Merhaba, bu Türkçe',
    'Swedish': 'Hej, detta är svenska',
    'Danish': 'Hej, dette er dansk',
    'Norwegian': 'Hei, dette er norsk',
    'Finnish': 'Hei, tämä on suomeksi',
    'Greek': 'Γεια σας, αυτό είναι στα ελληνικά',
    'Hebrew': 'שלום, זה בעברית',
    'Hindi': 'नमस्ते, यह हिंदी में है',
    'Bengali': 'হ্যালো, এটি বাঙালি',
  };

  _onLanguageSelected(String str) {
    selectedLanguage = str;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Initially, set the filtered languages to be all languages
    filteredLanguages.addAll(allLanguages);

    scrollController.addListener(() {
      setState(() {
        _isSliverAppBarExpanded =
            (scrollController.hasClients && scrollController.offset > 10);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
     
      // backgroundColor: ColorAssets.white,
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppbarwithSearchBar(
              context: context,
              controller: controller,
              title: "Language Settings",
              isSliverAppBarExpanded: _isSliverAppBarExpanded,
              onChange: _onSearchTextChanged,
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text(
                      "Selected language",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                          fontSize: 16),
                    ),
                  ),
                  CustomListTile(
                    onTap: () {},
                    title: Text(
                      selectedLanguage,
                      style: const TextStyle(
                        // color: ColorAssets.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      languageSubtitles[selectedLanguage] ?? '',
                      style: TextStyle(
                        color: ColorAssets.primaryBlue,
                      ),
                    ),
                  ),
                  const Divider()
                ],
              ),
            ),
            SliverList.builder(
              itemCount: filteredLanguages.length,
              itemBuilder: (context, index) {
                String language = filteredLanguages[index];
                if (filteredLanguages[index] == selectedLanguage) {
                  return const SizedBox.shrink();
                }
                return CustomListTile(
                  leadingIcon: null,
                  title: Text(
                    language,
                    style: const TextStyle(
                      // color: ColorAssets.blackFaded,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(languageSubtitles[language] ?? ''),
                  onTap: () {
                    SnackBarService.showSnackBarWithAction(
                        context: context,
                        message: "Set $language Language for app",
                        ontap: () =>
                            _onLanguageSelected(filteredLanguages[index]));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _onSearchTextChanged(String searchTerm) {
    setState(() {
      filteredLanguages = allLanguages
          .where((language) =>
              language.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }
}
