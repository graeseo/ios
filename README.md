# graeseo-ios

> 그래서 — iOS 네이티브 앱 (SwiftUI)

바텀 탭 등 네이티브 쉘 + 메인피드는 WKWebView(graeseo-web)로 로드.

## 기술 스택

- Swift + SwiftUI
- XCTest (테스트)

## 브랜치 전략 (Git Flow)

```
main      ← 프로덕션 배포
develop   ← 통합 브랜치
feature/* ← 기능 개발
release/* ← 릴리즈 준비
hotfix/*  ← 긴급 수정
```

## 시작하기

Xcode에서 `Graeseo.xcodeproj` 열고 실행.

## 테스트

```bash
xcodebuild test -project Graeseo.xcodeproj -scheme Graeseo -destination 'platform=iOS Simulator,name=iPhone 16'
```
