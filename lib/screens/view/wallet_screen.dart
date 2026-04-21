import 'package:firebase_project_hotel_bookking/controller/wallet_controller.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/custom_widgets.dart/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Walletscreen extends StatefulWidget {
  const Walletscreen({super.key});

  @override
  State<Walletscreen> createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<WalletController>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletController>(context);

    Widget allTransactions() {
      if (provider.walletStream == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return StreamBuilder(
        stream: provider.walletStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var ds = snapshot.data!.docs[index];

              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      ds["Date"] ?? "",
                      style: Appwidgets.headlinetextfeildstyle(),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      children: [
                        const Text("Amount Add to wallet"),
                        Text(
                          "\$${ds["Amount"] ?? "0"}",
                          style: const TextStyle(
                            color: Color(0xffef2b39),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      body: provider.wallet == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Text("Wallet", style: Appwidgets.headlinetextfeildstyle()),

                  const SizedBox(height: 10),

                  Expanded(
                    child: Container(
                      color: const Color(0xffececf8),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          walletCard(provider.wallet ?? "0"),

                          const SizedBox(height: 40),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              amountButton("100", () {
                                provider.makePayment("100", context);
                              }),
                              amountButton("50", () {
                                provider.makePayment("50", context);
                              }),
                              amountButton("200", () {
                                provider.makePayment("200", context);
                              }),
                            ],
                          ),

                          const SizedBox(height: 30),

                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: TextField(
                                    controller: provider.amountcontroller,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "amount",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (provider
                                            .amountcontroller
                                            .text
                                            .isNotEmpty) {
                                          provider.makePayment(
                                            provider.amountcontroller.text,
                                            context,
                                          );
                                        }
                                        provider.amountcontroller.clear();
                                      },
                                      child: const Text("Add"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffef2b39),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Add Money",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Your Transactions",
                                  style: Appwidgets.boldtextfeildstyle(),
                                ),
                                Expanded(child: allTransactions()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
