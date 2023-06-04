import 'package:card_app/controllers/dashboard_provider.dart';
import 'package:card_app/presentation/add_card_page.dart';
import 'package:card_app/widgets/display_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants.dart';
import '../models/card_model.dart';
import '../widgets/expandable_tile.dart';

final provider =
    ChangeNotifierProvider<DashboardProvider>((ref) => DashboardProvider());

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final PageController _debitPageController = PageController();
  final PageController _creditPageController = PageController();

  @override
  void dispose() {
    _debitPageController.dispose();
    _creditPageController.dispose();
    super.dispose();
  }

  OverlayEntry? entry;
  late List<CardModel> debitCards, creditCards;
  List documents = [];
  bool isFloating = false;
  bool isCreditTileExpanded = false,
      isDebitTileExpanded = false,
      isDocumentTileExpanded = false;

  void expandDebitTile() {
    if (isDebitTileExpanded) {
      isDebitTileExpanded = false;
      setState(() {});
    } else {
      setState(() {
        isCreditTileExpanded = false;
        isDebitTileExpanded = true;
        isDocumentTileExpanded = false;
      });
    }
  }

  void expandCreditTile() {
    if (isCreditTileExpanded) {
      isCreditTileExpanded = false;
      setState(() {});
    } else {
      setState(() {
        isCreditTileExpanded = true;
        isDebitTileExpanded = false;
        isDocumentTileExpanded = false;
      });
    }
  }

  void expandDocumentTile() {
    if (isDocumentTileExpanded) {
      isDocumentTileExpanded = false;
      setState(() {});
    } else {
      setState(() {
        isCreditTileExpanded = false;
        isDebitTileExpanded = false;
        isDocumentTileExpanded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debitCards = ref.watch(provider).debitCards;
    creditCards = ref.watch(provider).creditCards;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dashboard'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: expandCreditTile,
                child: ExpandableTile(
                  isExpanded: isCreditTileExpanded,
                  title: "Credit Cards",
                  count: creditCards.length,
                  childWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _creditPageController,
                          itemCount: debitCards.length,
                          itemBuilder: (context, index) {
                            var card = debitCards[index];
                            return Center(
                              child: DisplayCard(
                                bankName: card.bankName,
                                cardScheme: card.cardScheme,
                                cardNumber: card.cardNumber,
                                fullName: card.fullName,
                                cardType: card.cardType,
                                cardColor: card.cardColor,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: _creditPageController,
                              count: debitCards.length,
                              effect: ColorTransitionEffect(
                                dotHeight: 6,
                                dotWidth: 9,
                                dotColor: Colors.white38,
                                activeDotColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),],
                  ),
                ),
              ),
              GestureDetector(
                onTap: expandDebitTile,
                child: ExpandableTile(
                  isExpanded: isDebitTileExpanded,
                  title: "Debit Cards",
                  count: debitCards.length,
                  childWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _debitPageController,
                          itemCount: debitCards.length,
                          itemBuilder: (context, index) {
                            var card = debitCards[index];
                            return Center(
                              child: DisplayCard(
                                bankName: card.bankName,
                                cardScheme: card.cardScheme,
                                cardNumber: card.cardNumber,
                                fullName: card.fullName,
                                cardType: card.cardType,
                                cardColor: card.cardColor,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: _debitPageController,
                              count: debitCards.length,
                              effect: ColorTransitionEffect(
                                dotHeight: 6,
                                dotWidth: 9,
                                dotColor: Colors.white38,
                                activeDotColor: Colors.white,
                              ),
                          ),
                        ),
                        ),
                      ),],
                  ),
                ),
              ),
              GestureDetector(
                onTap: expandDocumentTile,
                child: ExpandableTile(
                  isExpanded: isDocumentTileExpanded,
                  title: "Documents",
                  count: documents.length,
                  // child: null,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCardPage()));
          // WidgetsBinding.instance.addPostFrameCallback((_) => showOverLay());
        },
        child: Center(
          child: Icon(
            isFloating ? Icons.close : Icons.add,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildOverlay() => Material(
        elevation: 8,
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.credit_card_outlined,
                color: Constants.yellow,
              ),
              title: Text(
                'Add Card',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.upload_file,
                color: Constants.yellow,
              ),
              title: Text(
                'Upload File',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      );

  hideOverlay() {
    entry?.remove();
    isFloating = false;
    entry = null;
  }

  showOverLay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
        builder: (context) => Positioned(
              height: 150,
              width: 150,
              child: buildOverlay(),
            ));

    overlay.insert(entry!);
  }
}
