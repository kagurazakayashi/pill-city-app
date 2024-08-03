import 'package:flutter/material.dart';
import 'package:pillcity/common/i18n_function/i18n_function.dart';
import 'package:pillcity/common/network/network_enum_status.dart';
import 'package:pillcity/data/global.dart';
import 'package:pillcity/settings/network/proxy_function.dart';
import 'package:pillcity/settings/network/proxy_view_controller.dart';

class ProxyView extends State<ProxyViewController> {
  final ProxyFunction _f = ProxyFunction();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _timeoutController = TextEditingController();
  NetworkProxyMode? _proxyMode = NetworkProxyMode.defaultMode;
  bool _chkCertificate = true;

  @override
  void initState() {
    _proxyMode = _f.loadProxyMode();
    _ipController.text = g_proxy[1];
    _portController.text = g_proxy[2];
    _timeoutController.text =
        (g_networkTimeout[0] / 1000).truncate().toString();
    _chkCertificate = (g_proxy[3].isNotEmpty);
    super.initState();
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _timeoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _f.context ??= context;
    return PopScope(
      onPopInvoked: (bool isPop) {
        if (isPop) {
          _f.willPop(_proxyMode, _ipController.text, _portController.text,
              _chkCertificate, _timeoutController.text);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('setting.network.setting')),
          backgroundColor: Colors.red[400],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(tr('setting.network.transmission')),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _timeoutController,
                decoration: InputDecoration(
                  labelText: tr('setting.network.timeout'),
                  prefixIcon: const Icon(Icons.timer_outlined),
                ),
                validator: (value) {
                  return _f.validateTimeout(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(tr('setting.network.httpscert')),
                  const Spacer(),
                  Switch(
                    value: _chkCertificate,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        _chkCertificate = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(tr('setting.network.proxy')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(tr('setting.network.sys')),
                      leading: Radio<NetworkProxyMode>(
                        value: NetworkProxyMode.defaultMode,
                        groupValue: _proxyMode,
                        onChanged: (NetworkProxyMode? value) {
                          setState(() {
                            _proxyMode = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(tr('setting.network.http')),
                      leading: Radio<NetworkProxyMode>(
                        value: NetworkProxyMode.http,
                        groupValue: _proxyMode,
                        onChanged: (NetworkProxyMode? value) {
                          setState(() {
                            _proxyMode = value;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _ipController,
                      decoration: InputDecoration(
                        labelText: tr('setting.network.ip'),
                        prefixIcon: const Icon(Icons.settings_ethernet),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _ipController.text = '';
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        return _f.validateIp(value);
                      },
                    ),
                    TextFormField(
                      controller: _portController,
                      decoration: InputDecoration(
                        labelText: tr('setting.network.port'),
                        prefixIcon: const Icon(Icons.settings_input_hdmi),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _portController.text = '';
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        return _f.validatePort(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 64)),
          ],
        ),
      ),
    );
  }
}
