# FonoKit 🪶

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![GoRouter](https://img.shields.io/badge/Go_Router-%230175C2.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)

**FonoKit** é um aplicativo de fonoaudiologia infantil gamificado e de nível clínico. Inspirado na estética suave de aquarela do jogo *Gris*, oferece um ambiente calmo e livre de distrações para reabilitação fonética. O aplicativo é projetado com uma arquitetura limpa (Clean Architecture), modular e offline-first para garantir um uso fluido tanto na clínica quanto em casa.

---

## ✨ Funcionalidades Principais (Estado Atual)

O aplicativo está estruturado com quatro módulos principais de interface (features):

1. **Trilha de Aprendizado (`learning_path`):** 
   - Sistema de progressão baseado em nós (ex: Bilabiais, Alveolares).
   - Componente personalizado `TrackNodeWidget` para visualização interativa do progresso.
   - Detalhamento de sub-rotas de fonemas com `TrackSubPathPage`.

2. **Estudos (`study`):**
   - Biblioteca de livros infantis focados em fonação.
   - Tela de leitura dinâmica (`BookReadingPage`) acoplada a um ViewModel dedicado (`BookReadingViewModel`), permitindo o acompanhamento textual e estímulo visual/auditivo.

3. **Exercícios (`exercises`):**
   - Sessões práticas e interativas de fonética com `ExercisePage`.
   - Sistema de verificação de respostas baseado em opções, feedback tátil/visual imediato (sucesso/erro com delays para transições suaves) e opção de reprodução de áudio.

4. **Perfil (`profile`):**
   - Dashboard de progresso do paciente (`ProfilePage`), centralizando as informações de conquistas e evolução da criança.

---

## 🎨 Miki Design System

O visual do FonoKit baseia-se no **Miki Design System** (`lib/ui/core/theme/miki_design_system.dart`), uma biblioteca de estilo customizada que evita sobrecarga cognitiva:

* **Paleta Japonesa Pastel:** 
  - Fundo suave: `#F6F6F6`
  - Texto principal: `#373D4A`
  - Tons de destaque: Lavanda (`#C9CBF4`), Azul Gelo (`#D0EEF4`) e Rosa Bebê (`#F6C9C9`).
* **Tipografia Moderna (Google Fonts):**
  - **Plus Jakarta Sans** para títulos e cabeçalhos principais (`headlineLg`, `headlineMd`, `headlineSm`).
  - **Manrope** para corpo de texto e rótulos (`bodyLg`, `bodyMd`, `labelMd`, `labelSm`).
* **Decorações Fluidas:**
  - Efeito de Glassmorphism nativo (`MikiDecorations.glassMorphism()`).
  - Transições e animações suaves (`MikiFadeScaleTransitionPage`) para evitar cortes abruptos de tela.

---

## 🏗 Arquitetura do Sistema

O projeto adota uma divisão estrita baseada em **Clean Architecture** em conjunto com o padrão de apresentação **MVVM (Model-View-ViewModel)**.

```text
lib/
├── data/                       # Camada de Dados (Fontes de dados e repositórios)
│   └── repositories/           # Implementações de repositório (atualmente mockadas)
├── domain/                     # Camada de Domínio (Regras de negócio puras em Dart)
│   ├── models/                 # Modelos de dados imutáveis (Book, Exercise, LearningTrack)
│   └── repositories/           # Contratos/Interfaces dos Repositórios
├── generated/                  # Classes de localização geradas automaticamente (l10n)
├── l10n/                       # Arquivos de templates de tradução (.arb)
└── ui/                         # Camada de Apresentação (Flutter UI)
    ├── core/                   # Utilitários compartilhados, rotas e sistema de design
    │   ├── navigation/         # Configuração do GoRouter e transições
    │   ├── theme/              # Miki Design System (Cores, Fontes, Estilos)
    │   └── widgets/            # Componentes globais da interface (ex: BottomNavBar)
    └── features/               # Módulos funcionais isolados
        ├── exercises/          # Exercícios fonéticos interativos
        ├── learning_path/      # Trilha de progresso e nós de fonemas
        ├── profile/            # Perfil do paciente e progresso
        └── study/              # Biblioteca e leitura guiada de livros
```

### Componentes de Arquitetura Chave:
* **Domain Layer (Domínio):** Código Dart puro, livre de dependências do framework Flutter. Define os contratos e entidades principais.
* **Data Layer (Dados):** Implementações concretas dos repositórios (`MockExerciseRepository`, `MockLearningPathRepository`, `MockStudyRepository`). Estruturado para fácil migração para um banco de dados local robusto (como `drift`/SQLite) ou APIs remotas.
* **UI Layer (Apresentação):** 
  - **Gerenciamento de Estado:** Utiliza `ChangeNotifier` como ViewModel e `ListenableBuilder` nas Views para reconstruções eficientes e cirúrgicas do widget tree.
  - **Injeção de Dependências:** Configurada no `main.dart` usando `MultiProvider` para expor os ViewModels inicializados com suas respectivas dependências de repositório.
  - **Roteamento:** Declarativo com `go_router` (`mikiRouter` em `lib/ui/core/navigation/router.dart`), empregando `StatefulShellRoute` para persistência de abas na barra de navegação inferior (`Trilha`, `Estudos`, `Perfil`).

---

## 🌐 Localização (i18n)

O suporte a múltiplos idiomas está nativamente configurado com `flutter_localizations` e arquivos `.arb`.

* **Idiomas Suportados:** Português do Brasil (`pt-BR`) e Português (`pt`).
* **Configuração:** Gerada em tempo de compilação com a flag `generate: true` no `pubspec.yaml`, mapeando as chaves de tradução em `lib/generated/l10n/app_localizations.dart` a partir dos arquivos em `lib/l10n/`.

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
Certifique-se de ter o Flutter SDK configurado em sua máquina. Caso utilize o **FVM (Flutter Version Management)** para gerenciar a versão do SDK, adicione o prefixo `fvm` nos comandos abaixo.

1. **Clonar o Repositório:**
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd fonemas_app
   ```

2. **Obter as Dependências:**
   ```bash
   fvm flutter pub get
   ```

3. **Gerar Arquivos de Localização:**
   Os arquivos de tradução são gerados automaticamente pelo Flutter no build/run, mas você pode forçar a geração com:
   ```bash
   fvm flutter gen-l10n
   ```

4. **Executar o Aplicativo:**
   ```bash
   fvm flutter run
   ```

5. **Executar Testes:**
   ```bash
   fvm flutter test
   ```

---

## 🔥 Backend & Serviços em Nuvem (Firebase)

A arquitetura do backend do FonoKit está sendo estruturada para utilizar o ecossistema do **Firebase** e **Google Cloud**, proporcionando as seguintes vantagens:

* **Autenticação Segura (Firebase Auth):** Gerenciamento escalável de usuários (pacientes e fonoaudiólogos) com suporte nativo a múltiplos provedores e *Custom Claims* para controle de acesso (ex: perfil Admin vs Paciente).
* **Banco de Dados em Tempo Real (Firestore):** O armazenamento NoSQL perfeito para acompanhar o progresso das trilhas de aprendizado e sincronizar dados das terapias. Sua sincronização offline nativa garante que a criança continue utilizando o app mesmo sem conexão à internet.
* **Armazenamento de Mídia Otimizado (Cloud Storage):** Fundamental para hospedar áudios de pronúncia, ilustrações dos livros e vídeos explicativos de forma segura e com alta disponibilidade.
* **Regras de Negócio Serverless (Cloud Functions):** Execução de código no servidor para garantir segurança em validações de exercícios e processamentos em background, sem a necessidade de gerenciar servidores.
* **Monitoramento Clínico (Crashlytics & Analytics):** Ferramentas essenciais para garantir que o app não tenha interrupções (Crashlytics) e para entender quais partes do app os pacientes mais interagem, otimizando o fluxo de UX e gamificação.