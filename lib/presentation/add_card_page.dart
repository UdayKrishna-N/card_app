// ignore_for_file: use_build_context_synchronously

import 'package:card_app/database/app_database.dart';
import 'package:card_app/models/card_model.dart';
import 'package:card_app/presentation/dashboard.dart';
// import 'package:card_app/presentation/dashboard.dart';
import 'package:card_app/widgets/button.dart';
import 'package:card_app/widgets/card_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/new_card_provider.dart';
import '../enums/card_scheme_enum.dart';
import '../widgets/input_field.dart';
import '../widgets/valid_thru_field.dart';

final newCardProvider =
    ChangeNotifierProvider.autoDispose<NewCardProvider>((ref) {
  return NewCardProvider();
});

class AddCardPage extends ConsumerStatefulWidget {
  const AddCardPage({super.key});

  @override
  ConsumerState<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends ConsumerState<AddCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CardModel newCard;

  // TextEditingControllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController validThruController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  getCardScheme(CardScheme scheme) {
    switch (scheme) {
      case CardScheme.visa:
        return Positioned(
          right: 10,
          child: SizedBox(
            width: 70,
            height: 60,
            child: Image.asset(
              'assets/icons/visa.png',
              width: 70,
              fit: BoxFit.contain,
            ),
          ),
        );
      case CardScheme.mastercard:
        return Positioned(
          right: 10,
          top: 5,
          child: SizedBox(
            width: 60,
            height: 50,
            child: Image.asset(
              'assets/icons/mastercard.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      case CardScheme.rupay:
        return Positioned(
          right: 10,
          child: SizedBox(
            width: 50,
            height: 60,
            child: Image.asset(
              'assets/icons/rupay.png',
              width: 70,
              fit: BoxFit.contain,
            ),
          ),
        );
      case CardScheme.none:
        return SizedBox.shrink();
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    newCard = ref.watch(newCardProvider).card;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context), icon: Icon(Icons.clear)),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 30, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InputField(
                      controller: bankNameController,
                      labelText: 'Bank Name',
                      onChanged: (value) {
                        ref.read(newCardProvider).updateBankName(value);
                      },
                      prefixIcon: null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: fullNameController,
                      labelText: 'Full Name',
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        ref.read(newCardProvider).updateName(value);
                      },
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        CardNumberField(
                          controller: cardNumberController,
                          labelText: 'Enter Card Number',
                          prefixIcon: Icon(Icons.credit_card_outlined),
                          onChanged: (value) {
                            ref.read(newCardProvider).updateCardNumber(value);
                            if (value.length == 7) {
                              ref
                                  .read(newCardProvider)
                                  .getBin(value.replaceAll(' ', ''));
                            } else if (value.length < 7) {
                              ref.read(newCardProvider).makeItNone();
                            }
                          },
                        ),
                        getCardScheme(newCard.cardScheme),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ValidThruField(
                            controller: validThruController,
                            labelText: 'ValidThru',
                            onChanged: (value) {
                              ref.read(newCardProvider).updateValidThru(value);
                            },
                            prefixIcon: null,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: InputField(
                            controller: cvvController,
                            labelText: 'CVV',
                            onChanged: (value) => ref.read(newCardProvider).updateCVV(value),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            prefixIcon: null,
                            textLength: 3,
                            digitsOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Button(
              buttonText: 'Add Card',
              onTap: () async {
                var card = ref.read(newCardProvider).card;
                ref.read(provider).saveCard(card);
                await Future.delayed(Duration(microseconds: 500), () {});
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
