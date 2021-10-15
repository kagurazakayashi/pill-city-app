import 'package:flutter/material.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/common/network/network_enum_status.dart';
import 'package:pill_city/data/global.dart';
import 'package:pill_city/settings/proxy/proxy_function.dart';
import 'package:pill_city/settings/proxy/proxy_view_controller.dart';

class ProxyView extends State<ProxyViewController> {
  final ProxyFunction _f = ProxyFunction();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  NetworkProxyMode? _proxyMode = NetworkProxyMode.defaultMode;
  bool _chkCertificate = true;

  @override
  void initState() {
    _proxyMode = _f.loadProxyMode();
    _ipController.text = g_proxy[1];
    _portController.text = g_proxy[2];
    _chkCertificate = (g_proxy[3].isNotEmpty);
    super.initState();
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _f.context ??= context;
    return WillPopScope(
      onWillPop: () => _f.willPop(_proxyMode, _ipController.text,
          _portController.text, _chkCertificate),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('setting.proxy.setting')),
          backgroundColor: Colors.red[400],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(tr('setting.proxy.security')),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(tr('setting.proxy.httpscert')),
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
              child: Text(tr('setting.proxy.proxy')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(tr('setting.proxy.sys')),
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
                      title: Text(tr('setting.proxy.http')),
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
                        labelText: tr('setting.proxy.ip'),
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
                        labelText: tr('setting.proxy.port'),
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
