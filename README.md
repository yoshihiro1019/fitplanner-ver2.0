# 筋トレアプリ 概要

##  サービス概要  
**筋トレアプリ**  
- トレーニング内容を**自動で提案**  
- **ジム探し機能**を搭載（一般的なトレーニングアプリにはない）  
- **トレーニング記録機能**や**鍛えたい部位ごとのおすすめトレーニング**を提供  

---

##  このサービスへの思い・作りたい理由  
**筋トレを挫折せず継続できる環境を提供するために開発**  

---

##  ユーザー層  
- 筋トレに興味はあるが、**モチベーション維持が難しい人**  

---

##  サービスの利用イメージ  
- **目的に応じた無理のないトレーニングを提案**  
- **継続できる仕組み**を作る（例：BGM機能、トレーニング記録）

---

##  ユーザー獲得の戦略  
- **理想の体型をイメージできる仕組み**  
- **テンションが上がるBGM機能**を導入  

---

##  サービスの差別化ポイント
  
 **ジム検索機能**を提供  
 **本人の運動能力や習慣に応じたトレーニング提案**
 **BGM機能**を実装（テンションUP)

---

##  機能候補  
 **MVP（Minimum Viable Product = 最小機能）**  
- ユーザー登録・ログイン  
- トークンのリフレッシュ・検証  
- パスワードリセット  
- ログアウト機能  
- ユーザー情報取得  
- トレーニング提案機能  
- 周辺のジム検索機能  
- 記録帳機能  
- 部位別トレーニング検索  

**本リリース** 
- **BGM機能**
- **AIを用いたトレーニング提案機能**(企画当初は、AIを活用したアプリの開発事例がほとんどなく、実現可能性が不透明だったため、実装予定として検討していた)
---

##  機能の実装方針  

###  トレーニング提案機能（本リリース）  
 **OPEN AI API**  
- 過去のトレーニングデータ（種類、強度、時間、頻度）を収集  
- **目標**（筋力UP・ダイエット・持久力UPなど）に応じてトレーニングを提案  

###  BGM機能（本リリース）  
 **Spotify API **  
- **ユーザーが選んだプレイリストをアプリ内で再生**  

### 周辺のジム検索機能（MVP）  
 **Google Maps API**  
- **現在地から近くのジムを検索**  

###  記録帳機能（MVP）  
 **データベースにトレーニング記録を保存**  
- ユーザーごとの記録を管理  

###  部位別トレーニング検索機能（MVP）  
 **部位ごとのトレーニングデータをDBに分類**  
- ユーザーが選んだ部位に応じて**おすすめのトレーニングを提案**  

---

## ■ 使用技術

| **カテゴリー** | **使用技術** |
|--------------|------------------------------------------|
| **フロントエンド** | Rails 7.2.1.2 / TailwindCSS / JavaScript |
| **バックエンド** | Rails 7.2.1.2 (Ruby 3.2.3) |
| **インフラ** | Render |
| **DB** | MySQL |
| **開発環境** | Docker |
| **認証** | Devise / Google認証 |
| **CI/CD** | GitHub Actions |
| **Web API** | OpenAI API / Google Maps API / Spotify API |

## ■ 画面遷移図（MVPリリース時）
https://www.figma.com/design/vqTq1B2O0XlxwSRiCJvNeP/Untitled?node-id=0-1&p=f
![image](https://github.com/user-attachments/assets/56813032-2a49-4552-a5f2-b39bca91ce8a)


---

## ■ ER図

https://app.diagrams.net/#Hyoshihiro1019%2FyoshihiroGraduationwork%2F%25E7%258A%25B6%25E6%2585%258B%25E9%2581%25B7%25E7%25A7%25BB%25E5%259B%25B3%2F%E5%90%8D%E7%A7%B0%E6%9C%AA%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB.drawio#%7B%22pageId%22%3A%22R2lEEEUBdFMjLlhIrx00%22%7D

![image](https://github.com/user-attachments/assets/f46d6c8e-e424-4c87-9b58-11de39119fd3)

