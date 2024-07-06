# ひろん流アルゴ式チャレンジ環境

## 使い方

### Swift環境

1. [Genesis](https://github.com/yonaskolb/Genesis) を使って、以下のように解きたいタスクの番号を入力すると、Swift Packageのプロジェクトが作られます。
    ```
    % genesis generate template-swift.yml
    Task number? 492
    Generated files:
      Task492/.gitignore
      Task492/Package.swift
      Task492/README.md
      Task492/Sources/Task492/main.swift
      Task492/Sources/Task492/TestData.swift
    ```
2. プロジェクトを開いて、main.swift を編集してチャレンジします。
3. validation.swift の各 `TestData` に渡すtextが入力になります。expectedに期待する出力を入れると、実行時に一致するかどうかを比較してくれます。
4. 2つ以上のTestDataを使うときは、validationListのコメントアウトを外してください。
5. 実際にアルゴ式に提出するときはmain.swiftの内容だけをコピーして提出します。

### Kotlin環境

1. [Genesis](https://github.com/yonaskolb/Genesis) を使って、以下のように解きたいタスクの番号を入力すると、IntelliJ IDEA用のプロジェクトが作られます。
    ```
    % genesis generate template-kotlin.yml
    Task number? 729
    Generated files:
      Task729/.idea/inspectionProfiles/Project_Default.xml
      Task729/.idea/libraries/KotlinJavaRuntime.xml
      Task729/.idea/runConfigurations/ValidationKt.xml
      Task729/.idea/.gitignore
      Task729/.idea/kotlinc.xml
      Task729/.idea/misc.xml
      Task729/.idea/modules.xml
      Task729/.idea/vcs.xml
      Task729/src/Main.kt
      Task729/src/Validation.kt
      Task729/.gitignore
      Task729/README.md
      Task729/Task729.iml    
    ```
2. プロジェクトを開いて、Main.kt を編集してチャレンジします。
3. Validation.kt の各 `TestData` に渡す第2引数が入力になります。第3引数に期待する出力を入れると、実行時に一致するかどうかを比較してくれます。
4. 2つ以上のTestDataを使うときは、validationListのコメントアウトを外してください。
5. 実際にアルゴ式に提出するときはMain.ktの内容だけをコピーして提出します。
