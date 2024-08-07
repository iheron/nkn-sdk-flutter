import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nkn_sdk_flutter/client.dart';
import 'package:nkn_sdk_flutter/crypto.dart';
import 'package:nkn_sdk_flutter/utils/hash.dart';
import 'package:nkn_sdk_flutter/utils/hex.dart';
import 'package:nkn_sdk_flutter/wallet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wallet.install();
  Client.install();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Client? _client1;
  Client? _client2;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(
                'Wallet',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.create(null, config: WalletConfig(password: '123'));
                      print(wallet.address);
                      print(wallet.seed);
                      print(wallet.publicKey);
                      print(wallet.keystore);
                      print(wallet.programHash);
                    },
                    child: Text('create'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.restore(
                          '{"Version":2,"IV":"d103adf904b4b2e8cca9659e88201e5d","MasterKey":"20042c80ccb809c72eb5cf4390b29b2ef0efb014b38f7229d48fb415ccf80668","SeedEncrypted":"3bcdca17d84dc7088c4b3f929cf1e96cf66c988f2b306f076fd181e04c5be187","Address":"NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7","Scrypt":{"Salt":"a455be75074c2230","N":32768,"R":8,"P":1}}',
                          config: WalletConfig(password: '123'));
                      print(wallet.address);
                      print(wallet.seed);
                      print(wallet.publicKey);
                      print(wallet.keystore);
                      print(wallet.programHash);
                    },
                    child: Text('restore'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.restore(
                          '{"Version":2,"IV":"d103adf904b4b2e8cca9659e88201e5d","MasterKey":"20042c80ccb809c72eb5cf4390b29b2ef0efb014b38f7229d48fb415ccf80668","SeedEncrypted":"3bcdca17d84dc7088c4b3f929cf1e96cf66c988f2b306f076fd181e04c5be187","Address":"NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7","Scrypt":{"Salt":"a455be75074c2230","N":32768,"R":8,"P":1}}',
                          config: WalletConfig(password: '123'));
                      print(await wallet.getBalance());
                    },
                    child: Text('getBalance'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.restore(
                          '{"Version":2,"IV":"d103adf904b4b2e8cca9659e88201e5d","MasterKey":"20042c80ccb809c72eb5cf4390b29b2ef0efb014b38f7229d48fb415ccf80668","SeedEncrypted":"3bcdca17d84dc7088c4b3f929cf1e96cf66c988f2b306f076fd181e04c5be187","Address":"NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7","Scrypt":{"Salt":"a455be75074c2230","N":32768,"R":8,"P":1}}',
                          config: WalletConfig(password: '123'));
                      print(await wallet.getBalance());
                      String? hash = await wallet.transfer(wallet.address, '0');
                      print(hash);
                    },
                    child: Text('transfer'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.restore(
                          '{"Version":2,"IV":"d103adf904b4b2e8cca9659e88201e5d","MasterKey":"20042c80ccb809c72eb5cf4390b29b2ef0efb014b38f7229d48fb415ccf80668","SeedEncrypted":"3bcdca17d84dc7088c4b3f929cf1e96cf66c988f2b306f076fd181e04c5be187","Address":"NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7","Scrypt":{"Salt":"a455be75074c2230","N":32768,"R":8,"P":1}}',
                          config: WalletConfig(password: '123'));
                      int? nonce = await wallet.getNonce();
                      print(nonce);
                    },
                    child: Text('getNonce'),
                  ),
                  TextButton(
                    onPressed: () async {
                      int? height = await Wallet.getHeight();
                      print(height);
                    },
                    child: Text('getHeight'),
                  ),
                  TextButton(
                    onPressed: () async {
                      int? nonce = await Wallet.getNonceByAddress('NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7');
                      print(nonce);
                    },
                    child: Text('getNonceByAddress'),
                  ),
                ],
              ),
              Text(
                'Client1',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.restore(
                          '{"Version":2,"IV":"d103adf904b4b2e8cca9659e88201e5d","MasterKey":"20042c80ccb809c72eb5cf4390b29b2ef0efb014b38f7229d48fb415ccf80668","SeedEncrypted":"3bcdca17d84dc7088c4b3f929cf1e96cf66c988f2b306f076fd181e04c5be187","Address":"NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7","Scrypt":{"Salt":"a455be75074c2230","N":32768,"R":8,"P":1}}',
                          config: WalletConfig(password: '123'));
                      await _client1?.close();
                      _client1 = await Client.create(
                        wallet.seed,
                        config: ClientConfig(
                          dnsResolverConfig: [
                            DnsResolverConfig(
                              dnsServer: '8.8.8.8:53',
                            ),
                          ],
                        ),
                      );
                      print('-------------_client1----------');
                      print(_client1?.address);
                      _client1?.onConnect.listen((event) {
                        print('------onConnect1-----');
                        print(event.node);
                      });

                      Map dic = Map();
                      _client1?.onMessage.listen((event) {
                        print('------onMessage1-----');
                        if (dic[event.src] == null) {
                          dic[event.src] = 1;
                        } else {
                          dic[event.src] += 1;
                        }
                        print(dic[event.src]);
                        // print(event.type);
                        // print(event.encrypted);
                        // print(event.messageId);
                        print(event.data);
                        // print(event.src);
                        print(event.noReply);
                        if (event.noReply != true) {
                          event.reply(jsonEncode({'id': DateTime.now().millisecondsSinceEpoch.toString(), 'contentType': 'text', 'content': 'reply'}));
                        }
                      });
                    },
                    child: Text('create'),
                  ),
                  TextButton(
                    onPressed: () async {
                      _client1?.close();
                    },
                    child: Text('close'),
                  ),
                  TextButton(
                      onPressed: () async {
                        await _client1?.reconnect();
                      },
                      child: Text('reconnect')),
                  TextButton(
                    onPressed: () async {
                      print(jsonEncode({'id': DateTime.now().millisecondsSinceEpoch.toString(), 'contentType': 'text', 'content': 'hi'}));
                      var res = await _client1
                          ?.sendText([_client2!.address], jsonEncode({'id': DateTime.now().millisecondsSinceEpoch.toString(), 'contentType': 'text', 'content': 'hi'}));
                      print(res);
                    },
                    child: Text('sendText'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.subscribe(topic: genChannelId('ttest'));
                      print(res);
                    },
                    child: Text('subscribe'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.unsubscribe(topic: genChannelId('ttest'));
                      print(res);
                    },
                    child: Text('unsubscribe'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.getSubscribersCount(topic: genChannelId('ttest'));
                      print(res);
                    },
                    child: Text('getSubscribersCount'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.getSubscription(topic: genChannelId('ttest'), subscriber: _client1!.address);
                      print(res);
                    },
                    child: Text('getSubscription'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.getSubscribers(topic: genChannelId('ttest'));
                      print(res);
                    },
                    child: Text('getSubscribers'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.getHeight();
                      print(res);
                    },
                    child: Text('getHeight'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.getNonce();
                      print(res);
                    },
                    child: Text('getNonce'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client1?.getNonceByAddress('NKNVgahGfYYxYaJdGZHZSxBg2QJpUhRH24M7');
                      print(res);
                    },
                    child: Text('getNonceByAddress'),
                  ),
                ],
              ),
              Text(
                'Client2',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () async {
                      await _client2?.close();
                      _client2 = await Client.create(hexDecode('bd8bd3de4dd0f798fac5a0a56e536a8bacd5b7f46d0951d8665fd68d0a910996'));
                      _client2?.onConnect.listen((event) {
                        print('------onConnect2-----');
                        print(event.node);
                      });
                      _client2?.onMessage.listen((event) {
                        print('------onMessage2-----');
                        print(event.type);
                        print(event.encrypted);
                        print(event.messageId);
                        print(event.data);
                        print(event.src);
                      });
                    },
                    child: Text('create'),
                  ),
                  TextButton(
                    onPressed: () async {
                      _client2?.close();
                    },
                    child: Text('close'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await _client2?.sendText([_client1!.address], jsonEncode({'contentType': 'text', 'content': 'hi2'}), noReply: false);
                      print(res?.data);
                    },
                    child: Text('sendText'),
                  ),
                ],
              ),
              Text(
                'Crypto',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.create(hexDecode('a2df9fafa747b4da6afa58cdee8e170f0a71815584c3ed3bfa52040c89d0bd61'), config: WalletConfig(password: '123'));
                      Uint8List privateKey = await Crypto.getPrivateKeyFromSeed(wallet.seed);
                      var res = await Crypto.sign(privateKey, Uint8List.fromList(utf8.encode('Hello, world!')));
                      print(hexEncode(res));
                    },
                    child: Text('sign'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Wallet wallet = await Wallet.create(hexDecode('a2df9fafa747b4da6afa58cdee8e170f0a71815584c3ed3bfa52040c89d0bd61'), config: WalletConfig(password: '123'));

                      bool verified = await Crypto.verify(wallet.publicKey, Uint8List.fromList(utf8.encode('Hello, world!')),
                          hexDecode('fc81c36aa9002bb973fb7db3b8d334ae52194edf5e051d4c5105d20fbbad7287cd5172aea0acac43d843bf3b692aa486d96e4dcfbed9b7dcfb6e7c385c070d0d'));
                      print(verified);
                    },
                    child: Text('verify'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
