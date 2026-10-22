import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

const navy = Color(0xFF10172B);
const surface = Color(0xFF171F35);
const accent = Color(0xFF70E1C4);
const subtle = Color(0xFFACBAD0);

Future<void> openExternal(String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null && await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Gabriel Lima • Portfólio Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: navy,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.dark),
          fontFamily: 'Roboto',
        ),
        home: const PortfolioPage(),
      );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final projectKey = GlobalKey();
  final aboutKey = GlobalKey();
  final contactKey = GlobalKey();
  void goTo(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 750;
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF2C3650)))),
              child: Center(child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1140),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20, runSpacing: 14, children: [
                      const Text('GL. / PORTFÓLIO', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 19, color: accent)),
                      Wrap(spacing: 7, children: [
                        TextButton(onPressed: () => goTo(projectKey), child: const Text('Projetos')),
                        TextButton(onPressed: () => goTo(aboutKey), child: const Text('Sobre')),
                        TextButton(onPressed: () => goTo(contactKey), child: const Text('Contato')),
                      ]),
                    ]),
                ),
              )),
            ),
            Center(child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1140),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: compact ? 32 : 60),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('DESENVOLVIMENTO DE SOFTWARE  /  OUTUBRO 2026', style: TextStyle(color: accent, fontSize: compact ? 11 : 13, letterSpacing: 2, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  Text('Projetos que combinam tecnologia e boas experiências.', style: TextStyle(fontSize: compact ? 37 : 56, height: 1.1, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  const Text('Uma vitrine acadêmica de interfaces, arquitetura e desenvolvimento de aplicações.', style: TextStyle(color: subtle, fontSize: 17, height: 1.5)),
                  const SizedBox(height: 42),
                  Container(key: projectKey, child: const SectionTitle('01 / PROJETO EM DESTAQUE')),
                  const SizedBox(height: 15),
                  Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Wrap(spacing: 8, runSpacing: 8, children: const [ChipLabel('FRONT-END'), ChipLabel('FLUTTER WEB'), ChipLabel('OUT 2026')]),
                    const SizedBox(height: 20),
                    Text('Dashboard E-commerce em Tempo Real', style: TextStyle(fontWeight: FontWeight.bold, height: 1.15, fontSize: compact ? 28 : 37)),
                    const SizedBox(height: 15),
                    const Text('Estudo de caso de uma plataforma para acompanhar vendas, pedidos e conversões por meio de indicadores visuais. Este portfólio foi desenvolvido em Flutter.', style: TextStyle(color: subtle, fontSize: 16, height: 1.55)),
                    const SizedBox(height: 24),
                    Wrap(spacing: 12, runSpacing: 10, children: [
                      FilledButton.icon(onPressed: () => openExternal('https://github.com/imgabriellima1'), icon: const Icon(Icons.code), label: const Text('Ver meu GitHub')),
                      OutlinedButton.icon(onPressed: () => goTo(aboutKey), icon: const Icon(Icons.arrow_downward), label: const Text('Explorar projeto')),
                    ]),
                  ])),
                  const SizedBox(height: 24),
                  const DashboardPreview(),
                  const SizedBox(height: 52),
                  Container(key: aboutKey, child: const SectionTitle('02 / O PROBLEMA E A SOLUÇÃO')),
                  const SizedBox(height: 17),
                  LayoutBuilder(builder: (context, bounds) {
                    final cols = bounds.maxWidth >= 700;
                    final cards = [
                      const InfoCard(icon: Icons.help_outline, title: 'O desafio', text: 'Lojistas precisam entender rapidamente a evolução das vendas sem depender de planilhas e atualizações manuais.'),
                      const InfoCard(icon: Icons.lightbulb_outline, title: 'A solução', text: 'Conceber uma interface visual com indicadores e componentes reutilizáveis que facilitem a leitura de informações.'),
                    ];
                    return cols ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [for (final c in cards) Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: c))]) : Column(children: [for (final c in cards) Padding(padding: const EdgeInsets.only(bottom: 12), child: c)]);
                  }),
                  const SizedBox(height: 49),
                  const SectionTitle('03 / ARQUITETURA E TECNOLOGIAS'),
                  const SizedBox(height: 16),
                  const TechnologyTile('Flutter', 'Framework utilizado para construir a interface multiplataforma.'),
                  const TechnologyTile('Dart', 'Linguagem utilizada para componentes e lógica de apresentação.'),
                  const TechnologyTile('GitHub Pages', 'Hospedagem estática gratuita para distribuir o build web.'),
                  const SizedBox(height: 49),
                  const SectionTitle('04 / CARACTERÍSTICAS'),
                  const SizedBox(height: 16),
                  LayoutBuilder(builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final count = width > 850 ? 3 : width > 540 ? 2 : 1;
                    final cardWidth = (width - (count - 1) * 14) / count;
                    return Wrap(spacing: 14, runSpacing: 14, children: [
                      SizedBox(width: cardWidth, child: const InfoCard(icon: Icons.devices, title: 'UI responsiva', text: 'Adapta a navegação, a tipografia e os cards para desktop e celular.')),
                      SizedBox(width: cardWidth, child: const InfoCard(icon: Icons.bar_chart, title: 'Dashboard visual', text: 'Prévia de indicadores e gráfico desenhado com widgets Flutter.')),
                      SizedBox(width: cardWidth, child: const InfoCard(icon: Icons.public, title: 'Publicação web', text: 'Deploy automatizável via GitHub Actions e GitHub Pages.')),
                    ]);
                  }),
                  const SizedBox(height: 49),
                  const SectionTitle('05 / RESULTADOS E APRENDIZADOS'),
                  const SizedBox(height: 16),
                  const Panel(child: Text('Protótipo demonstrativo de portfólio desenvolvido em Flutter Web, com navegação entre seções, layout adaptável e preparação para publicação estática. Os indicadores do dashboard são ilustrativos, não dados reais de produção.', style: TextStyle(color: subtle, fontSize: 16, height: 1.6))),
                  const SizedBox(height: 49),
                  Container(key: contactKey, child: const SectionTitle('06 / VAMOS CONVERSAR?')),
                  const SizedBox(height: 16),
                  Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Gostou do projeto?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    const Text('Explore meus outros projetos no GitHub e acompanhe novos estudos de tecnologia.', style: TextStyle(color: subtle, fontSize: 16)),
                    const SizedBox(height: 18),
                    FilledButton.icon(onPressed: () => openExternal('https://github.com/imgabriellima1'), icon: const Icon(Icons.open_in_new), label: const Text('Acessar meu GitHub')),
                  ])),
                  const SizedBox(height: 48),
                  const Center(child: Text('© 2026 Gabriel Lima · Desenvolvido em Flutter Web', style: TextStyle(color: subtle, fontSize: 12))),
                ]),
              ),
            )),
          ]),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Text(title, style: const TextStyle(color: accent, letterSpacing: 2, fontWeight: FontWeight.w800, fontSize: 13));
}

class ChipLabel extends StatelessWidget {
  final String label;
  const ChipLabel(this.label, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(color: const Color(0xFF263D48), borderRadius: BorderRadius.circular(7)),
        child: Text(label, style: const TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
      );
}

class Panel extends StatelessWidget {
  final Widget child;
  const Panel({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF303B55))),
        child: child,
      );
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const InfoCard({super.key, required this.icon, required this.title, required this.text});
  @override
  Widget build(BuildContext context) => Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: accent, size: 28),
        const SizedBox(height: 14),
        Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 9),
        Text(text, style: const TextStyle(color: subtle, height: 1.5)),
      ]));
}

class TechnologyTile extends StatelessWidget {
  final String name;
  final String description;
  const TechnologyTile(this.name, this.description, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Panel(child: Wrap(spacing: 18, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
          SizedBox(width: 160, child: Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: accent))),
          Text(description, style: const TextStyle(color: subtle)),
        ])),
      );
}

class DashboardPreview extends StatelessWidget {
  const DashboardPreview({super.key});
  @override
  Widget build(BuildContext context) => Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Icon(Icons.analytics_outlined, color: accent), const SizedBox(width: 10), const Expanded(child: Text('Visão geral do e-commerce', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19))), Container(width: 9, height: 9, decoration: const BoxDecoration(color: accent, shape: BoxShape.circle))]),
        const SizedBox(height: 6),
        const Text('Demonstração visual · Dados fictícios', style: TextStyle(color: subtle, fontSize: 12)),
        const SizedBox(height: 22),
        LayoutBuilder(builder: (context, bounds) {
          final cells = [const Metric('Receita', 'R\$ 48.920', '+12,8%'), const Metric('Pedidos', '1.284', '+8,2%'), const Metric('Conversão', '3,6%', '+0,4 p.p.')];
          if (bounds.maxWidth < 620) return Column(children: [for (final c in cells) Padding(padding: const EdgeInsets.only(bottom: 10), child: c)]);
          return Row(children: [for (final c in cells) Expanded(child: Padding(padding: const EdgeInsets.only(right: 10), child: c))]);
        }),
        const SizedBox(height: 25),
        const Text('Vendas nos últimos 7 dias', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(height: 155, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          for (final entry in <(String, double)>[('SEG', .48), ('TER', .63), ('QUA', .58), ('QUI', .83), ('SEX', .72), ('SÁB', 1), ('DOM', .79)])
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(child: Align(alignment: Alignment.bottomCenter, child: FractionallySizedBox(heightFactor: entry.$2, alignment: Alignment.bottomCenter, child: Container(decoration: const BoxDecoration(color: accent, borderRadius: BorderRadius.vertical(top: Radius.circular(7)))))),),
              const SizedBox(height: 9),
              Text(entry.$1, style: const TextStyle(color: subtle, fontSize: 10)),
            ]))),
        ])),
      ]));
}

class Metric extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  const Metric(this.label, this.value, this.change, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF303B55))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(color: subtle, fontSize: 12)),
          const SizedBox(height: 9),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24))),
          const SizedBox(height: 4),
          Text(change, style: const TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 12)),
        ]),
      );
}
