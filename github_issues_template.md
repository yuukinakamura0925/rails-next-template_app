# GitHub Issues管理テンプレート

## 🏷️ ラベル設定

### 優先度
- `priority/high` - 🔴 高優先度
- `priority/medium` - 🟡 中優先度  
- `priority/low` - 🟢 低優先度

### 種別
- `type/feature` - ✨ 新機能
- `type/bug` - 🐛 バグ
- `type/docs` - 📖 ドキュメント
- `type/refactor` - 🔧 リファクタリング
- `type/infrastructure` - 🏗️ インフラ
- `type/security` - 🔒 セキュリティ

### 対象
- `scope/user-web` - 👥 ユーザー画面
- `scope/admin-web` - 👨‍💼 管理画面
- `scope/rails-api` - 🚀 Rails API
- `scope/infra` - ☁️ インフラ
- `scope/shared` - 🔗 共通

### ステータス
- `status/todo` - 📝 未着手
- `status/in-progress` - 🔄 進行中
- `status/review` - 👀 レビュー中
- `status/done` - ✅ 完了

## 📋 Milestone設定（ローカル開発フォーカス）

### Phase 1: 基盤構築 (週1-2)
- Monorepo構成 + Docker Compose環境
- Rails API の基盤
- ローカルPostgreSQL設定

### Phase 2: 認証システム構築 (週3-4)
- Firebase Auth 設定
- Rails-Firebase連携

### Phase 3: フロントエンド・機能実装 (週5-8)
- Next.js 2画面の基本実装
- 認証フロー + CRUD機能実装
- ファイルアップロード（ローカルストレージ）

### Phase 4: GCP移行準備 (将来対応)
- Cloud Run対応Dockerfile
- Terraform設定
- CI/CD (本番デプロイ対応)

---

## 📝 Epic Issues（大分類）

### Epic 1: プロジェクト基盤構築
```markdown
# Epic: プロジェクト基盤構築

## 概要
Monorepoの基本構成とRails APIの基盤を構築する

## 完了条件
- [ ] Monorepo構成の完成
- [ ] Rails APIの基本構成完了
- [ ] 開発環境のセットアップ完了
- [ ] 基本的なCI設定完了

## 関連Issues
- #1, #2, #3, #4, #5, #6, #7, #8
```

### Epic 2: 認証システム構築
```markdown
# Epic: 認証システム構築

## 概要
Firebase AuthとRails APIの認証基盤を構築する

## 完了条件
- [ ] Firebase プロジェクト設定完了
- [ ] Rails での Firebase token検証実装
- [ ] ユーザー画面での認証フロー実装
- [ ] 管理画面での認証フロー実装

## 関連Issues
- #9, #10, #11, #12, #13, #14
```

### Epic 3: フロントエンド基盤構築
```markdown
# Epic: フロントエンド基盤構築

## 概要
Next.js 2画面の基本構成と共通機能を実装する

## 完了条件
- [ ] user-web の基本構成完了
- [ ] admin-web の基本構成完了
- [ ] 共通コンポーネント実装完了
- [ ] API連携基盤完了

## 関連Issues
- #15, #16, #17, #18, #19, #20, #21, #22
```

### Epic 4: 機能実装
```markdown
# Epic: 機能実装

## 概要
主要なCRUD機能とビジネスロジックを実装する

## 完了条件
- [ ] ユーザー管理機能完了
- [ ] 商品管理機能完了
- [ ] 注文管理機能完了
- [ ] ファイルアップロード機能完了
- [ ] 決済機能完了

## 関連Issues
- #23, #24, #25, #26, #27, #28, #29, #30, #31, #32
```

### Epic 5: インフラ・デプロイ
```markdown
# Epic: インフラ・デプロイ

## 概要
GCPインフラとCI/CDパイプラインを構築する

## 完了条件
- [ ] Terraform設定完了
- [ ] Cloud Run デプロイ完了
- [ ] Cloud SQL セットアップ完了
- [ ] Cloud Storage セットアップ完了
- [ ] CI/CDパイプライン完了

## 関連Issues
- #33, #34, #35, #36, #37, #38, #39, #40
```

---

## 🎯 個別Issues（詳細タスク）

### Phase 1: 基盤構築

#### Issue #1: Monorepo基本構成作成
```markdown
# Monorepo基本構成作成

## 概要
プロジェクトのMonorepo基本構成を作成する

## 作業内容
- [ ] ディレクトリ構造作成
- [ ] package.json（root）作成
- [ ] .gitignore 設定
- [ ] README.md 作成
- [ ] Turbo設定

## 完了条件
- [ ] 定義されたディレクトリ構造が作成されている
- [ ] 各アプリケーションが独立して動作する
- [ ] Turbo でworkspace管理ができる

**Labels**: `type/infrastructure`, `priority/high`, `scope/shared`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 4h
```

#### Issue #2: Rails API基本構成
```markdown
# Rails API基本構成

## 概要
Rails APIモードの基本構成を作成する

## 作業内容
- [ ] Rails new --api 実行
- [ ] Gemfile設定（必要なGem追加）
- [ ] config/application.rb 設定
- [ ] CORS設定
- [ ] 基本的なcontroller作成

## 完了条件
- [ ] Rails API が起動する
- [ ] CORSが正しく設定されている
- [ ] 基本的なヘルスチェックエンドポイントが動作する

**Labels**: `type/infrastructure`, `priority/high`, `scope/rails-api`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 6h
```

#### Issue #3: Docker Compose開発環境
```markdown
# Docker Compose開発環境

## 概要
ローカル開発用のDocker Compose環境を構築する

## 作業内容
- [ ] Rails API Dockerfile作成
- [ ] user-web Dockerfile作成  
- [ ] admin-web Dockerfile作成
- [ ] docker-compose.yml作成（PostgreSQL含む）
- [ ] ホットリロード設定
- [ ] 環境変数設定
- [ ] ボリューム設定

## 完了条件
- [ ] `docker-compose up` で全サービスが起動する
- [ ] ホットリロードが動作する
- [ ] PostgreSQLが正しく接続される
- [ ] 各ポートが正しく公開される（3000,3001,3002）

**Labels**: `type/infrastructure`, `priority/high`, `scope/shared`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 8h
```

#### Issue #4: データベース設計・マイグレーション
```markdown
# データベース設計・マイグレーション

## 概要
基本的なデータベース設計とマイグレーションを作成する

## 作業内容
- [ ] ER図作成
- [ ] User model作成
- [ ] Item model作成
- [ ] Order model作成
- [ ] 初期マイグレーション実行

## 完了条件
- [ ] データベース設計が完了している
- [ ] 基本的なモデルが作成されている
- [ ] マイグレーションが正常に実行される

**Labels**: `type/infrastructure`, `priority/high`, `scope/rails-api`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 6h
```

#### Issue #5: 基本的なAPI構造作成
```markdown
# 基本的なAPI構造作成

## 概要
Rails APIの基本的な構造とルーティングを作成する

## 作業内容
- [ ] config/routes.rb 設定
- [ ] Api::V1 namespace作成
- [ ] Admin::V1 namespace作成
- [ ] 基本的なcontroller作成
- [ ] レスポンス形式統一

## 完了条件
- [ ] API のルーティングが正しく設定されている
- [ ] 基本的なendpointが応答する
- [ ] JSON レスポンス形式が統一されている

**Labels**: `type/infrastructure`, `priority/high`, `scope/rails-api`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 4h
```

#### Issue #6: 開発環境1コマンドセットアップ
```markdown
# 開発環境1コマンドセットアップ

## 概要
新規開発者が1コマンドで開発環境を構築できるようにする

## 作業内容
- [ ] setup_dev.sh 作成
- [ ] Docker/Docker Compose インストール確認
- [ ] 環境変数テンプレート(.env.sample)作成
- [ ] データベース初期化スクリプト
- [ ] 依存関係インストール自動化
- [ ] Firebase設定確認

## 完了条件
- [ ] `./scripts/setup_dev.sh` で環境構築完了
- [ ] 必要な環境変数が自動設定される
- [ ] データベースが初期化される
- [ ] すぐに開発開始できる状態になる

**Labels**: `type/infrastructure`, `priority/high`, `scope/shared`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 6h
```

#### Issue #7: 基本的なCI設定（ローカル開発向け）
```markdown
# 基本的なCI設定（ローカル開発向け）

## 概要
GitHub ActionsでローカルDocker環境用のCI設定を作成する

## 作業内容
- [ ] .github/workflows/ci.yml 作成
- [ ] Docker Compose でテスト実行
- [ ] Rails RSpec実行設定
- [ ] Next.js テスト実行設定
- [ ] TypeScript型チェック設定
- [ ] Lint実行設定（ESLint + Rubocop）

## 完了条件
- [ ] PRでCI が自動実行される
- [ ] Docker環境でテストが正常実行される
- [ ] 全アプリのLintが実行される
- [ ] TypeScript型チェックが実行される

**Labels**: `type/infrastructure`, `priority/medium`, `scope/shared`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 6h
```

#### Issue #8: 環境変数・設定ファイル管理
```markdown
# 環境変数・設定ファイル管理

## 概要
各環境の設定ファイルと環境変数管理を整備する

## 作業内容
- [ ] .env.sample 作成
- [ ] 各アプリケーションの環境変数設定
- [ ] 設定ファイルのvalidation
- [ ] 開発/ステージング/本番の設定分離

## 完了条件
- [ ] 環境変数が適切に管理されている
- [ ] 設定ファイルが適切に分離されている
- [ ] セキュリティが確保されている

**Labels**: `type/infrastructure`, `priority/medium`, `scope/shared`
**Milestone**: Phase 1: 基盤構築
**Assignee**: TBD
**Estimate**: 4h
```

### Phase 2: 認証システム構築

#### Issue #9: Firebase プロジェクト設定
```markdown
# Firebase プロジェクト設定

## 概要
Firebase プロジェクトの作成と基本設定を行う

## 作業内容
- [ ] Firebase プロジェクト作成
- [ ] Authentication 設定
- [ ] サービスアカウント作成
- [ ] 認証プロバイダー設定
- [ ] セキュリティルール設定

## 完了条件
- [ ] Firebase プロジェクトが作成されている
- [ ] 必要な認証プロバイダーが設定されている
- [ ] セキュリティルールが適切に設定されている

**Labels**: `type/infrastructure`, `priority/high`, `scope/shared`
**Milestone**: Phase 2: 認証システム構築
**Assignee**: TBD
**Estimate**: 4h
```

#### Issue #10: Rails Firebase Auth連携
```markdown
# Rails Firebase Auth連携

## 概要
Rails APIでFirebase ID tokenの検証機能を実装する

## 作業内容
- [ ] Firebase Admin SDK 設定
- [ ] ID token 検証機能実装
- [ ] 認証フィルター実装
- [ ] ユーザー情報取得機能実装
- [ ] 権限チェック機能実装

## 完了条件
- [ ] Firebase ID token が正しく検証される
- [ ] 認証が必要なAPI に認証フィルターが適用される
- [ ] ユーザー情報が正しく取得される

**Labels**: `type/feature`, `priority/high`, `scope/rails-api`
**Milestone**: Phase 2: 認証システム構築
**Assignee**: TBD
**Estimate**: 8h
```

#### Issue #11: 共通Firebase設定
```markdown
# 共通Firebase設定

## 概要
フロントエンド用の共通Firebase設定を作成する

## 作業内容
- [ ] Firebase config 設定
- [ ] 共通認証ヘルパー作成
- [ ] 認証状態管理実装
- [ ] Token リフレッシュ機能実装
- [ ] 認証エラーハンドリング実装

## 完了条件
- [ ] 共通Firebase設定が完了している
- [ ] 認証状態が適切に管理される
- [ ] Token が適切にリフレッシュされる

**Labels**: `type/infrastructure`, `priority/high`, `scope/shared`
**Milestone**: Phase 2: 認証システム構築
**Assignee**: TBD
**Estimate**: 6h
```

### Phase 3: フロントエンド基盤構築

#### Issue #15: user-web 基本構成
```markdown
# user-web 基本構成

## 概要
ユーザー向けNext.jsアプリケーションの基本構成を作成する

## 作業内容
- [ ] Next.js プロジェクト作成
- [ ] TypeScript 設定
- [ ] Tailwind CSS 設定
- [ ] 基本的なページ構成
- [ ] 共通レイアウト作成

## 完了条件
- [ ] Next.js アプリケーションが起動する
- [ ] TypeScript が正しく設定されている
- [ ] Tailwind CSS が動作する

**Labels**: `type/infrastructure`, `priority/high`, `scope/user-web`
**Milestone**: Phase 3: フロントエンド基盤構築
**Assignee**: TBD
**Estimate**: 6h
```

#### Issue #16: admin-web 基本構成
```markdown
# admin-web 基本構成

## 概要
管理者向けNext.jsアプリケーションの基本構成を作成する

## 作業内容
- [ ] Next.js プロジェクト作成
- [ ] TypeScript 設定
- [ ] Tailwind CSS 設定
- [ ] 管理画面用レイアウト作成
- [ ] ナビゲーション実装

## 完了条件
- [ ] Next.js アプリケーションが起動する
- [ ] 管理画面用のレイアウトが実装されている
- [ ] 基本的なナビゲーションが動作する

**Labels**: `type/infrastructure`, `priority/high`, `scope/admin-web`
**Milestone**: Phase 3: フロントエンド基盤構築
**Assignee**: TBD
**Estimate**: 6h
```

### Phase 4: インフラ・デプロイ

#### Issue #33: Terraform基本設定
```markdown
# Terraform基本設定