# Portfólio Flutter Web — Gabriel Lima

Aplicação em Flutter inspirada no wireframe `Portifolio.txt` da atividade da faculdade.

## Conteúdo
- Menu Projetos / Sobre / Contato com rolagem até a seção.
- Card de projeto em destaque, mockup de dashboard ilustrativo.
- Desafio e solução, tecnologias, características, aprendizados e CTA.
- Layout responsivo para desktop e celular.

**Observação:** o dashboard exibido é apenas uma demonstração estática com valores fictícios. Não há backend, WebSocket, autenticação ou dados de produção. Os textos do trabalho original eram exemplos de layout, não evidência de funcionalidades implementadas.

## Executar localmente

Requer Flutter SDK e Git instalados. Abra o terminal na raiz deste diretório:

```bash
flutter create --platforms web .
flutter pub get
flutter run -d chrome
```

## Publicar em GitHub Pages

1. Crie um repositório público novo com o nome **portfolio-flutter** em sua conta GitHub.
2. No terminal, execute os comandos abaixo na raiz desta pasta:

```bash
git init
git branch -M main
git add .
git commit -m "Criar portfolio Flutter responsivo"
git remote add origin https://github.com/imgabriellima1/portfolio-flutter.git
git push -u origin main
```

3. O workflow em `.github/workflows/deploy.yml` compila o Flutter Web no GitHub Actions e publica **apenas build/web** na branch `gh-pages`.
4. No repositório, abra **Settings > Pages > Build and deployment > Deploy from a branch**. Selecione **gh-pages** e **/(root)** e clique em **Save**.
5. Confira as execuções na aba **Actions**. Após conclusão e atualização do Pages, acesse:

https://imgabriellima1.github.io/portfolio-flutter/

Se o workflow encontrar erro 403, habilite em **Settings > Actions > General > Workflow permissions > Read and write permissions**, quando essa opção estiver disponível.

## Build manual alternativo

```bash
flutter build web --base-href /portfolio-flutter/ --release
```

O conteúdo de `build/web` é o único que deve ir para a branch `gh-pages`, **não** o código-fonte Flutter.
