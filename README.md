# scumizu

[![Build Status](https://travis-ci.org/mk2/scumizu.svg?branch=master)](https://travis-ci.org/mk2/scumizu)
[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)

a [Sails](https://sailsjs.com) application


## 始め方

### 利用する

#### 必要なもの
TBD

### 開発する

#### 必要なもの

- docker
- docker-compose
- Node.js (with NPM) > 8.0.0

#### 開発サーバーの開始方法

##### macOSの場合

1. Docker.appを立ち上げる
2. 次のコマンドを順に実行

```
npm run build
npm run up
npm run start-dev
```

##### 注意事項

- pm2でアプリケーションを開始しているので、ログファイルなどは`.pm2/logs`以下を参照してください。
- pm2のwatch機能を有効にしてあります。`api`以下を変更すると自動で再読み込みします。またその際にSailsのalter table処理が実行されDBが初期化されます。

### テストの開始方法
TBD

```
npm run build
npm run up
npm run start-test
```
