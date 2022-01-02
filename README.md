# iOS Study Repo

IOS 개발 및 웹, 자료구조, 알고리즘 등 원하는 공부를 하며 기록하는 저장소입니다.

## RxSwift / Combine

### [RxSwift vs Combine - 스펙 / 성능 / 개념 비교](https://eunjin3786.tistory.com/67)
- iOS13 이후부터 사용 가능한 Combine과 RxSwift를 비교하고 있는 아티클

### [[RxSwift]Observable과 Driver](http://minsone.github.io/programming/reactive-swift-observable-vs-driver)

### [[RxSwift] Share(replay:)](https://jusung.github.io/shareReplay/)

## UnitTest

### [힐페TV - ViewModel을 무조건 믿을 수 있는 방법이 있다???(삐슝빠슝)](https://blog.gangnamunni.com/post/HealingPaperTV-ViewModel-Test/)
- MVVM 아키텍쳐 위주로 공부를 진행하고, Test에 대해서는 다른 곳 이야기라고 생각했지만 최근 테스트에 대해 관심이 생겨서 공부한 예제였다.
- Input과 Output을 정의해서 RxTest/Nimble을 활용해서 테스트 하는 방법을 터득할 수 있었다.

## CI/CD

### [[CI/CD] Jenkins vs GitLabCI vs Travis](https://owin2828.github.io/devlog/2020/01/09/cicd-1.html)
- 사이드 프로젝트에 CI/CD를 도입하는데 장단점을 비교하기 쉽지 않았는데 적절한 선택을 할 수 있도록 도와준 포스팅입니다.

### [CI/CD란 무엇이고 어떻게 활용할 수 있을까?](https://ji5485.github.io/post/2021-05-15/what-is-ci-cd/)
- CI/CD에 대해서 개념 정리가 필요할때 읽어보면 좋은 포스팅입니다.

### [iOS 플랫폼의 Jenkins CI 환경 구축하기](http://blog.hwahae.co.kr/all/tech/tech-tech/5706/)
- 화해에서 왜 Travis에서 Jenkins로 변경했는지 의사결정 과정이 나타난 포스팅입니다.
- 어떻게 구축했는지 자세하게 작성 해놓은 것이 특징입니다.

### [Fastlane 으로 iOS 배포를 쉽게 하자! - Fastlane 이란?](https://hyesunzzang.tistory.com/160)
### [Fastlane 으로 iOS 배포를 쉽게 하자! - Screenshots](https://hyesunzzang.tistory.com/161)
### [FastLane Snapshot으로 배포용 스크린샷 자동으로 만들기 - iOS Tech Talk](https://academy.realm.io/kr/posts/automate-ios-screenshots-with-fastlane-snapshot/)
- 처음 앱을 출시할 때, XCode에서 단계별로 하나하나 기다리면서 졸았던 적이 있습니다. 원하는 날짜에 출시하기 위해서 1분 1초가 중요한 상황이었는데 큰일날 뻔 했었죠. 다음 프로젝트에서는 Fastlane을 적용해서 배포까지의 경험을 대폭 개선하고 싶다는 생각이 들었습니다.

## Design System

### [Banksalad Product Language를 소개합니다](https://blog.banksalad.com/tech/banksalad-product-language-ios/)
- 개인적으로 서비스별 디자인 시스템을 어떻게 구축했는지 관심이 굉장히 많은 편인데, 구축하고자 했던 히스토리부터 실제 아웃풋까지 확인할 수 있어서 인상 깊었던 포스팅입니다.
- 사이드 프로젝트에서 적용해보고 싶은 욕구가 굉장히 많이 생기네요!  

### [LINE Design System](https://designsystem.line.me)
- 너무 멋있는 회사.. 이렇게 디자인 해주시는 디자이너분들 사이에서 개발하면 입꼬리가 올라갈 것 같습니다.
- 디자인 시스템을 어떻게 하면 디자이너와 커뮤니케이션 코스트를 줄이면서 코드화 할 수 있을지 더욱 고민해야 할 것 같습니다.

### [Building a Design System for iOS - Part 2 - Typography](https://www.ramshandilya.com/blog/design-system-typography/)
### [Building a Design System for iOS - Part 3 - Colors](https://www.ramshandilya.com/blog/design-system-colors/)

## Design Pattern / Arch

### [MVC 디자인 패턴 in iOS](https://velog.io/@ictechgy/MVC-디자인-패턴)
- 실제로 앱 개발을 하면서 MVC를 적용한 적은 없지만, MVC가 가지고 있는 장단점을 공부해야 이후의 디자인 패턴 등장 이유에 대해 더욱 깊게 이해할 수 있다고 생각합니다.

### [[iOS][RxSwift] Input과 Output을 사용한 MVVM 아키텍처](https://mildwhale.github.io/2020-04-16-mvvm-with-input-output/)
- Input/Output을 정의하지 않고 NVVM을 사용했는데 시간이 지날수록 ViewModel에 정의된 변수들이 어떤것이 Input이고 Output인지 혼동되는 경우가 많았는데, 이를 통해서 어느정도(?) 해결할 수 있다는 생각이 들었다.

## UI

### [SwiftUI의 방식으로 UIKit코드를 짜는 방법: Layout Driven UI](https://www.sungdoo.dev/programming/layout-driven-ui)
- 디자인 시스템 코드 작성을 시작하면서 몇가지 고민을 단번에 해결해주었던 포스팅입니다.
- 아직 iOS13 이상을 지원하기는 힘든 경우 SwiftUI 쓰기가 힘든 상황에, UIKit을 사용하면서 데이터를 더욱 효과적으로 컨트롤할 수 있는 방법을 제시해주고 있습니다. 
- 새로운 사이드 프로젝트에 직접 적용하고 후기를 작성할 예정입니다.


## CoreGraphics

## Network
