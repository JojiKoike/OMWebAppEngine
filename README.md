# OMWebAppEngine

## 本ドキュメントの目的
動作環境、開発環境構築手順、アプリケーション起動手順を示す。

## 概要
モデル記述言語Modelicaで構築した工学シミュレーションモデルを動かすWebアプリケーションの<br/>
バックエンドアプリケーションです。<br/>
現在は予め構築済みの工学モデルに対して、パラメータを変えて計算を行う機能のみに対応しています。<br/>
現在、以下のモデルを用意しております。

* １次元バネマスダンパモデル（自動車のサスペンションのようなモデル）
* 密閉筐体温度計算モデル（スマートフォンのように、密閉筐体内に発熱体が存在するようなモデル）

構成管理、構築を効率化する為、Vagrant及びAnsibleによる、Infrastracture As Codeを実践し<br/>
サーバー構成のコード化、構築の自動化を実現しています。

## 前提条件
* Windowsの場合、Hyper-Vが無効になっていること
* Intel VtまたはAMD-Vが有効になっていること
* Vagrant及びVirtual Boxがインストール済みであること
* 開発作業を行うには、Python3.7系最新とOpenModelicaがインストール済みであること

## 環境
* OS : Ubuntu 16.04 LTS
* HTTP Server : Apache 2.4.18
* サーバーアプリ実装言語 : Python 3.7系最新
* モデル記述言語：Modelica v3.2.2
* WSGI Server : uWSGI 2.0.17
* Web Application Framework : Flask 1.0.2 + Flask-RESTful 0.3.7
* MBD Platform : OpenModelica v.1.12.0
* OpenModelica-Python Interface : OMPython 3.1.2

## 使用方法
1. ソースコードクローン<br/>
`git clone https://github.com/JojiKoike/OMWebAppEngine.git`

2. セットアップ<br/>
`vagrant up develop` <br/>
注：ネットワーク状況にもよりますが、約３０分程かかります。

3. 動作確認<br/>
`curl -I "http://192.168.33.10/simplemsd`<br/>
以下のように出力されていれば、正常に動作しています。<br/>
`HTTP/1.1 200 OK`<br/>
`Date: Tue, 24 Mar 2020 05:01:22 GMT`<br/>
`Server: Apache/2.4.18 (Ubuntu)`<br/>
`Content-Type: application/json`<br/>
`Content-Length: 22769`<br/>
`Access-Control-Allow-Origin: *`<br/>

## 各コマンド
*　起動

`vagrant up develop --provision`

*　停止

`vagrant halt develop`

*　再起動

`vagrant reload develop --provision`

*  仮想サーバーへSSHログイン

`vagrant ssh develop`

## ディレクトリ構成

OMWebAppEngine <br/>
　　├── app: アプリケーション群ルートディレクトリ<br/>
　　│　　└── omwebapp 本アプリケーションルートディレクトリ<br/>
　　│　　　　　├── ModelicaModels: モデル記述言語Modelicaで記述された工学シミュレーションモデルコード <br/>
　　│　　　　　├── config:  ルーティング等のアプリケーション設定<br/>
　　│　　　　　├── entity: POSTリクエストパラメータ値、出力値を格納するエンティティクラス群 <br/>
　　│　　　　　├── tests: テストコード群 <br/>
　　│　　　　　├── util: ユーティリティーモジュール群 <br/>
　　│　　　　　└── view: REST API定義 <br/>
　　└── provisioning: Andible プロビジョニングコード群 <br/>
　　　　　　　　└── roles <br/>
　　　　　　　　　　　　├── apache2: Apache2セットアップ用プロビジョニングコード群 <br/> 
　　　　　　　　　　　　├── common: OSの設定等、全体共通のPlaybook <br/>
　　　　　　　　　　　　├── openmodelica: OpenModelicaセットアップ用プロビジョニングコード群 <br/>
　　　　　　　　　　　　├── pyenv: pyenvセットアップ用プロビジョニングコード群 <br/>
　　　　　　　　　　　　└── uwsgi: uWSGIセットアップ用プロビジョニングコード群 <br/>

## 作者

 Joji KOIKE

## ライセンス

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
