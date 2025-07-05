# Rails Next Template

Rails API + Next.js 2画面構成のテンプレートプロジェクト

## 🎯 プロジェクト概要

このプロジェクトは、Rails API + Next.js 2画面構成のWebアプリケーションテンプレートです。
新規プロダクト開発時に即座に利用できるボイラープレートを提供します。

### 主要特徴

- **Rails API**: 管理側も含めて完全API化
- **Next.js 2画面構成**: ユーザー向け・管理者向けを完全分離
- **Firebase Auth**: 共通認証基盤
- **Docker Compose**: ローカル開発環境
- **将来的にGCP対応**: Cloud Run + Cloud SQL + Cloud Storage

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

## 📁 ディレクトリ構成

```
rails-next-template/
├── apps/
│   ├── user-web/              # Next.js（ユーザー画面）
│   ├── admin-web/             # Next.js（管理画面）
│   └── rails-api/             # Rails API
├── shared/                    # 共通設定・型定義
│   ├── types/
│   └── config/
├── scripts/                   # 開発スクリプト
│   ├── setup_dev.sh          # 1コマンドセットアップ
│   ├── build_all.sh
│   └── test_all.sh
├── .github/workflows/         # CI設定
├── docs/                      # ドキュメント
├── docker-compose.yml         # ローカル環境
├── .env.sample               # 環境変数テンプレート
└── README.md
```

## 🚀 クイックスタート

### 1. リポジトリのクローン

```bash
git clone https://github.com/yuukinakamura0925/rails-next-template_app.git
cd rails-next-template_app
```

### 2. 環境構築

```bash
# 1コマンドセットアップ（準備中）
./scripts/setup_dev.sh

# または手動セットアップ
docker-compose up
```

### 3. アクセス

- **ユーザー画面**: http://localhost:3000
- **管理画面**: http://localhost:3002
- **Rails API**: http://localhost:3001

## 📋 開発進捗

### Phase 1: 基盤構築 (週1-2)
- [ ] Monorepo構成作成
- [ ] Rails API基本構成
- [ ] Docker Compose環境
- [ ] データベース設計・マイグレーション
- [ ] 基本的なAPI構造作成
- [ ] 開発環境1コマンドセットアップ
- [ ] 基本的なCI設定
- [ ] 環境変数・設定ファイル管理

### Phase 2: 認証システム (週3-4)
- [ ] Firebase プロジェクト設定
- [ ] Rails Firebase Auth連携
- [ ] 共通Firebase設定
- [ ] 認証フロー実装

### Phase 3: フロントエンド (週5-8)
- [ ] Next.js 2画面構築
- [ ] 共通コンポーネント実装
- [ ] API連携基盤

### Phase 4: 機能実装
- [ ] CRUD機能実装
- [ ] ファイルアップロード
- [ ] 決済機能

### Phase 5: インフラ・デプロイ（将来対応）
- [ ] GCP Terraform設定
- [ ] Cloud Run デプロイ
- [ ] CI/CDパイプライン

## 🔗 関連リンク

- [GitHub Issues](https://github.com/yuukinakamura0925/rails-next-template_app/issues)
- [プロジェクト管理](https://github.com/yuukinakamura0925/rails-next-template_app/projects)
- [ドキュメント](./docs/)

## 📝 ライセンス

MIT License