# Monorepo Template プロジェクト設計書

## 🎯 プロジェクト概要

### 目的
GCP上で動作する汎用的なWebアプリケーションテンプレートを構築し、新規プロダクト開発時に即座に利用できるボイラープレートを提供する。

### 主要特徴
- **Rails API**: 管理側も含めて完全API化
- **Next.js 2画面構成**: ユーザー向け・管理者向けを完全分離
- **Firebase Auth**: 共通認証基盤
- **GCP フル活用**: Cloud Run + Cloud SQL + Cloud Storage
- **CI/CD完備**: GitHub Actions による自動デプロイ

## 📁 アーキテクチャ設計

### システム構成図
```
┌─────────────────────────────────────────────────────────────┐
│                        GCP Cloud                            │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │   Cloud Run     │  │   Cloud SQL     │  │   Cloud     │ │
│  │                 │  │  (PostgreSQL)   │  │  Storage    │ │
│  │  ┌───────────┐  │  └─────────────────┘  └─────────────┘ │
│  │  │Rails API  │  │           │                    │      │
│  │  │(API Mode) │  │           └────────────────────┼──────┤
│  │  └───────────┘  │                                │      │
│  └─────────────────┘                                │      │
│           │                                          │      │
│           │ API calls                                │      │
│  ┌─────────────────┐  ┌─────────────────┐          │      │
│  │   Cloud Run     │  │   Cloud Run     │          │      │
│  │ ┌─────────────┐ │  │ ┌─────────────┐ │          │      │
│  │ │ user-web    │ │  │ │ admin-web   │ │          │      │
│  │ │ (Next.js)   │ │  │ │ (Next.js)   │ │          │      │
│  │ └─────────────┘ │  │ └─────────────┘ │          │      │
│  └─────────────────┘  └─────────────────┘          │      │
└─────────────────────────────────────────────────────┼──────┘
                                                      │
┌─────────────────────────────────────────────────────┼──────┐
│                 Firebase Auth                       │      │
│  ┌─────────────────────────────────────────────────┐│      │
│  │         JWT Token Management                    ││      │
│  │  ┌─────────────┐  ┌─────────────┐  ┌──────────┐ ││      │
│  │  │   User      │  │   Admin     │  │   API    │ ││      │
│  │  │    Auth     │  │    Auth     │  │  Verify  │ ││      │
│  │  └─────────────┘  └─────────────┘  └──────────┘ ││      │
│  └─────────────────────────────────────────────────┘│      │
└─────────────────────────────────────────────────────┘      │
                                                              │
┌─────────────────────────────────────────────────────────────┤
│                     Stripe API                              │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              Payment Processing                         ││
│  └─────────────────────────────────────────────────────────┘│
└──────────────────────────────────────────────────────────────┘
```

### ディレクトリ構成
```
monorepo-template/
├── apps/
│   ├── user-web/                # Next.js（エンドユーザー向け）
│   │   ├── src/
│   │   │   ├── app/
│   │   │   ├── components/
│   │   │   ├── lib/
│   │   │   │   ├── firebase.ts
│   │   │   │   ├── api.ts
│   │   │   │   └── auth.ts
│   │   │   └── types/
│   │   ├── public/
│   │   ├── package.json
│   │   ├── next.config.js
│   │   ├── tailwind.config.js
│   │   └── Dockerfile
│   ├── admin-web/               # Next.js（管理画面）
│   │   ├── src/
│   │   │   ├── app/
│   │   │   ├── components/
│   │   │   ├── lib/
│   │   │   │   ├── firebase.ts
│   │   │   │   ├── api.ts
│   │   │   │   └── auth.ts
│   │   │   └── types/
│   │   ├── public/
│   │   ├── package.json
│   │   ├── next.config.js
│   │   ├── tailwind.config.js
│   │   └── Dockerfile
│   └── rails-api/               # Rails API（--apiモード）
│       ├── app/
│       │   ├── controllers/
│       │   │   ├── api/
│       │   │   │   ├── v1/
│       │   │   │   │   ├── users_controller.rb
│       │   │   │   │   ├── items_controller.rb
│       │   │   │   │   ├── orders_controller.rb
│       │   │   │   │   └── payments_controller.rb
│       │   │   │   └── admin/
│       │   │   │       └── v1/
│       │   │   └── application_controller.rb
│       │   ├── models/
│       │   ├── services/
│       │   └── lib/
│       │       └── firebase_auth.rb
│       ├── config/
│       ├── db/
│       ├── Gemfile
│       ├── Dockerfile
│       └── docker-compose.yml
├── shared/                      # 共通設定・型定義
│   ├── types/
│   │   ├── user.ts
│   │   ├── item.ts
│   │   └── order.ts
│   └── config/
│       └── firebase.json
├── infra/                       # インフラ構成
│   ├── terraform/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── modules/
│   │   │   ├── cloud_run/
│   │   │   ├── cloud_sql/
│   │   │   └── cloud_storage/
│   │   └── environments/
│   │       ├── dev/
│   │       ├── staging/
│   │       └── prod/
│   └── scripts/
│       ├── setup.sh
│       ├── deploy.sh
│       └── db_migrate.sh
├── scripts/                     # 開発・CI用スクリプト
│   ├── setup_dev.sh
│   ├── build_all.sh
│   ├── test_all.sh
│   └── deploy_all.sh
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── deploy_user_web.yml
│       ├── deploy_admin_web.yml
│       └── deploy_rails_api.yml
├── docs/                        # プロジェクトドキュメント
│   ├── setup.md
│   ├── api_design.md
│   ├── deployment.md
│   └── troubleshooting.md
├── .env.sample
├── .gitignore
├── README.md
└── package.json                 # Workspace設定
```

## 🔧 技術仕様

### フロントエンド
- **Framework**: Next.js 14 (App Router)
- **Styling**: Tailwind CSS
- **State Management**: React Query + Zustand
- **Authentication**: Firebase Auth
- **Build Tool**: Turbo (Monorepo管理)

### バックエンド
- **Framework**: Rails 7.1 (API Mode)
- **Database**: PostgreSQL (Cloud SQL)
- **Authentication**: Firebase Admin SDK
- **File Storage**: Cloud Storage
- **Payment**: Stripe API

### インフラ
- **Platform**: Google Cloud Platform
- **Deployment**: Cloud Run
- **Database**: Cloud SQL (PostgreSQL)
- **Storage**: Cloud Storage
- **CI/CD**: GitHub Actions

## 🌐 API設計

### エンドポイント構成
```
# User API
GET    /api/v1/users/me
PUT    /api/v1/users/me
POST   /api/v1/users/upload_avatar

# Items API
GET    /api/v1/items
GET    /api/v1/items/:id
POST   /api/v1/items
PUT    /api/v1/items/:id
DELETE /api/v1/items/:id

# Orders API
GET    /api/v1/orders
GET    /api/v1/orders/:id
POST   /api/v1/orders
PUT    /api/v1/orders/:id

# Payments API
POST   /api/v1/payments/create_intent
POST   /api/v1/payments/confirm
GET    /api/v1/payments/:id

# Admin API
GET    /api/admin/v1/users
GET    /api/admin/v1/users/:id
PUT    /api/admin/v1/users/:id
DELETE /api/admin/v1/users/:id

GET    /api/admin/v1/orders
PUT    /api/admin/v1/orders/:id/status
```

### 認証フロー
1. フロントエンドで Firebase Auth により認証
2. 取得したIDトークンをAPIリクエストヘッダーに含める
3. Rails API で Firebase Admin SDK を使用してトークンを検証
4. ユーザー情報を取得して権限チェック

## 🚀 デプロイメント戦略

### 環境構成
- **Development**: ローカル開発環境
- **Staging**: テスト環境（Cloud Run）
- **Production**: 本番環境（Cloud Run）

### CI/CD パイプライン
1. **Push to feature branch**: テスト実行
2. **PR to develop**: ステージング環境デプロイ
3. **PR to main**: 本番環境デプロイ

## 📊 モニタリング・ログ

### 監視項目
- **Performance**: レスポンス時間、スループット
- **Error**: エラー率、エラーログ
- **Business**: ユーザー数、売上、コンバージョン率

### ログ管理
- **Application Log**: Cloud Logging
- **Error Tracking**: Error Reporting
- **Performance**: Cloud Monitoring

## 🔒 セキュリティ

### 認証・認可
- Firebase Auth による認証
- JWT トークンベースの認可
- ロールベースアクセス制御（RBAC）

### データ保護
- HTTPS通信の強制
- 機密データの暗号化
- Cloud SQL の暗号化

## 🧪 テスト戦略

### フロントエンド
- **Unit Test**: Jest + React Testing Library
- **Integration Test**: Cypress
- **E2E Test**: Playwright

### バックエンド
- **Unit Test**: RSpec
- **Integration Test**: RSpec + FactoryBot
- **API Test**: RSpec + Request specs

## 📝 開発フロー

### ブランチ戦略
- **main**: 本番環境
- **develop**: 開発環境
- **feature/***: 機能開発
- **hotfix/***: 緊急修正

### コミット規約
- `feat:` 新機能
- `fix:` バグ修正
- `docs:` ドキュメント
- `style:` スタイル修正
- `refactor:` リファクタリング
- `test:` テスト追加・修正

## 🎯 成果物

### 最終的な成果物
1. **完全動作するテンプレートリポジトリ**
2. **1コマンドでの環境構築**
3. **包括的なドキュメント**
4. **CI/CD パイプライン**
5. **セキュリティ設定**