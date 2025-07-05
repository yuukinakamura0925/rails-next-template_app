# 🖥️ ローカル開発プラン

## 🎯 現在のゴール
**ローカルで完璧に動くテンプレートを作成 → 将来的にGCP移行**

## 📋 開発順序（最適化版）

### 🚀 Phase 1: ローカル基盤構築 (週1-2)

#### 即座に着手可能なタスク
1. **Monorepo構成作成** (4h)
   - ディレクトリ構造
   - package.json設定
   - .gitignore設定

2. **Docker Compose環境** (8h) ⭐最重要
   - PostgreSQL含む完全ローカル環境
   - ホットリロード対応
   - ポート設定（3000,3001,3002,5432）

3. **Rails API基盤** (6h)
   - Rails --api 作成
   - 基本的なcontroller/routing
   - PostgreSQL接続確認

4. **1コマンドセットアップ** (6h)
   - setup_dev.sh作成
   - 環境変数自動設定
   - データベース初期化

### 🔐 Phase 2: 認証システム (週3-4)

5. **Firebase設定** (4h)
   - Firebase プロジェクト作成
   - 認証プロバイダー設定
   - 共通設定ファイル作成

6. **Rails-Firebase連携** (8h)
   - Firebase Admin SDK設定
   - トークン検証機能
   - 認証フィルター実装

### 🎨 Phase 3: フロントエンド (週5-8)

7. **Next.js 2画面構築** (12h)
   - user-web (ユーザー画面)
   - admin-web (管理画面)
   - TypeScript + Tailwind設定

8. **認証フロー実装** (8h)
   - ログイン/ログアウト
   - 認証状態管理
   - 権限制御

9. **基本CRUD機能** (16h)
   - ユーザー管理
   - 商品管理
   - 注文管理

## 💰 費用（現段階）

### 完全無料で開発可能
- **開発環境**: Docker Compose（無料）
- **リポジトリ**: GitHub（無料）
- **認証**: Firebase Auth（月10万認証まで無料）
- **CI**: GitHub Actions（月2000分まで無料）

### 任意の有料サービス（テスト公開用）
- **Vercel**: フロントエンド公開（無料）
- **Railway**: Rails API + DB（$5/月）

## 🛠️ 技術スタック（確定版）

### ローカル開発
```yaml
Backend:
  - Rails 7.1 (API mode)
  - PostgreSQL 15
  - Firebase Admin SDK

Frontend:
  - Next.js 14 (App Router)
  - TypeScript
  - Tailwind CSS
  - React Query

Development:
  - Docker Compose
  - Turbo (monorepo)
  - GitHub Actions (CI)
```

### 将来のGCP移行用
```yaml
Infrastructure:
  - Cloud Run (Rails API + Next.js)
  - Cloud SQL (PostgreSQL)
  - Cloud Storage
  - Cloud Build (CI/CD)
```

## 🗂️ ディレクトリ構成（最終版）

```
monorepo-template/
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

## 🚀 最初のタスク（今すぐ開始）

### 今日できること
1. **GitHubリポジトリ作成**
2. **基本ディレクトリ構造作成**
3. **Rails new --api 実行**
4. **基本的なdocker-compose.yml作成**

### 今週完了目標
- **Docker Compose で全サービス起動**
- **Rails API が PostgreSQL に接続**
- **基本的な /api/v1/health エンドポイント作成**

## 🎯 完成イメージ

### 開発者エクスペリエンス
```bash
# 新しい開発者の1日目
git clone [repo]
./scripts/setup_dev.sh
docker-compose up

# → すぐに開発開始可能！
# http://localhost:3000 (user-web)
# http://localhost:3002 (admin-web)  
# http://localhost:3001 (rails-api)
```

### 将来のGCP移行時
```bash
# 設定変更のみで移行可能
# ローカル開発 → GCP本番環境
./scripts/deploy_gcp.sh
```

## ✅ 次のアクション

どのタスクから始めますか？

1. **🏗️ 基本構成**: Monorepo + ディレクトリ作成
2. **🐳 Docker環境**: PostgreSQL含むローカル環境構築  
3. **🚀 Rails API**: 基本的なAPI構造作成
4. **📋 GitHub Issues**: 詳細タスク管理セットアップ

一緒に進めていきましょう！ 🚀