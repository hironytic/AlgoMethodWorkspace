# ひろん流アルゴ式チャレンジ環境

## 使い方

1. [Genesis](https://github.com/yonaskolb/Genesis) を使って、以下のように解きたいタスクの番号を入力すると、Swift Package のプロジェクトが作られます。

    ```
    % genesis generate template.yml
    Task number? 492
    Generated files:
    Task492/.gitignore
    Task492/Package.swift
    Task492/README.md
    Task492/Sources/Task492/main.swift
    Task492/Sources/Task492/TestData.swift
    ```
2. Swift Package のプロジェクトを開いて、main.swift を編集してチャレンジします。
3. main.swift の下の方にある `TestData` に渡す文字列が入力になります。
4. 実際にアルゴ式に提出するときは最初の `func read()` のコメントアウトを戻して、最後の `TestData` の部分は削除します。
