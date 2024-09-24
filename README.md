Itunes API를 이용한 앱스토어 검색 기능을 구현하였습니다.
---
1. RxSwift와 MVVM-C 아키텍처 패턴을 이용해 앱을 설계하였습니다.
2. Coordinator는 RxSwift와 함께 Reactive하게 사용할 수 있도록 구현하였습니다.
3. CollectionViewDiffableHandler를 이용하여 VC에서의 DataSource 로직을 분리하였습니다.
   1. CellModelProtocol를 사용해 API로부터 받은 데이터모델을 CollectionViewCell로 컨버팅하여 UI에 노출할 수 있도록 구현하였습니다.
5. UserDefaults를 이용해 최근 검색어를 저장할 수 있도록 구현하였습니다.
6. Protocol-Oriented Programming(PoP) 원칙에 맞춰 세부적으로 프로토콜을 정의하고 구현하여, 코드의 유연성과 재사용성을 극대화했습니다.
