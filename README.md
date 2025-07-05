# Rails Next Template

Rails API + Next.js 2画面構成のテンプレートプロジェクト

## 🎯 概要

このプロジェクトは、Rails API + Next.js 2画面構成のWebアプリケーションテンプレートです。新規プロダクト開発時に即座に利用できるボイラープレートを提供します。

### 主要特徴

- **Rails API**: 管理側も含めて完全API化
- **Next.js 2画面構成**: ユーザー向け・管理者向けを完全分離
- **Firebase Auth**: 共通認証基盤
- **Docker Compose**: ローカル開発環境
- **Monorepo構成**: Turboによるワークスペース管理

## 🛠️ 技術スタック

### バックエンド
- Rails 7.1 (API mode)
- PostgreSQL 15
- Firebase Admin SDK

### フロントエンド
- Next.js 14 (App Router)
- TypeScript
- Tailwind CSS
- React Query

### 開発環境
- Docker Compose
- Turbo (monorepo)
- GitHub Actions (CI)

## 📁 プロジェクト構成

```
rails-next-template/
├── apps/
│   ├── user-web/              # Next.js（ユーザー画面）
│   ├── admin-web/             # Next.js（管理画面）
│   └── rails-api/             # Rails API
├── shared/                    # 共通設定・型定義
│   ├── types/                 # TypeScript型定義
│   └── config/                # 共通設定ファイル
├── scripts/                   # 開発スクリプト
├── .github/workflows/         # CI設定
├── docs/                      # ドキュメント
├── docker-compose.yml         # ローカル環境（準備中）
├── .env.sample               # 環境変数テンプレート（準備中）
└── README.md
```

## 🚀 クイックスタート

### 前提条件

- Node.js 18.0.0以上
- pnpm 8.0.0以上
- Docker & Docker Compose
- Git

### セットアップ

```bash
# リポジトリのクローン
git clone https://github.com/yuukinakamura0925/rails-next-template_app.git
cd rails-next-template_app

# 依存関係のインストール
pnpm install

# 開発環境セットアップ（準備中）
pnpm run setup

# 開発サーバー起動（準備中）
pnpm run dev
```

### アクセス先（準備中）

- **ユーザー画面**: http://localhost:3000
- **管理画面**: http://localhost:3002
- **Rails API**: http://localhost:3001

## 📋 開発コマンド

```bash
# 全アプリケーションの開発サーバー起動
pnpm run dev

# 全アプリケーションのビルド
pnpm run build

# 全アプリケーションのテスト実行
pnpm run test

# 全アプリケーションのLint実行
pnpm run lint

# TypeScript型チェック
pnpm run type-check

# キャッシュクリア
pnpm run clean
```

## 📊 開発状況

### ✅ 完了済み
- [x] Monorepo基本構成
- [x] GitHub Issues管理システム
- [x] プロジェクト設計・計画

### 🚧 進行中
- [ ] Rails API基本構成
- [ ] Docker Compose環境
- [ ] データベース設計

### 📋 予定
- [ ] Firebase Auth設定
- [ ] Next.js 2画面構築
- [ ] 認証フロー実装
- [ ] CRUD機能実装

## 🔗 関連リンク

- [GitHub Issues](https://github.com/yuukinakamura0925/rails-next-template_app/issues)
- [プロジェクト管理](https://github.com/yuukinakamura0925/rails-next-template_app/projects)
- [詳細ドキュメント](./docs/)

## 📝 ライセンス

MIT License

## 🤝 コントリビューション

プルリクエストやIssueの報告を歓迎します。詳細は[CONTRIBUTING.md](./CONTRIBUTING.md)をご覧ください。