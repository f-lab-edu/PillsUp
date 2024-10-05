# 💊 Pills Up
사용자의 위치 기반으로 근처의 약국을 한눈에 볼 수 있는 서비스입니다.

<br>

# 📚 프로젝트 구조
![PillsUp_Package drawio](https://github.com/user-attachments/assets/fec34211-b994-42f3-9987-08383ba68746)

- **Feature:** 앱의 특정 기능 또는 화면을 독립적으로 구현한 모듈입니다.
- **Data:** Remote, Local에서 데이터를 가져오거나 저장하는 모듈입니다.
- **Network:** Network 통신을 위한 모듈입니다.
- **Domain:** 핵심 비지니스 규칙을 담당하는 모듈입니다.
- **Shared:** 앱 전반에 걸쳐 모든 계층에서 공통적으로 사용하는 코드를 포함한 모듈입니다.

<br>

# 📚 RIBs 구조
![PillsUp_RIBs](https://github.com/user-attachments/assets/34590925-97cb-434a-9a31-edcf5cb1e150)

- **RootRIB:** 앱의 진입, 로그인 정보를 체크하고 로그인 여부에 따라 LoginRIB 혹은 MainRIB을 Attach합니다.
- **LoginRIB:** 로그인을 시도하고 인증 정보를 저장하는 RIB입니다.
- **MainRIB:** 지도에 약국 정보를 표현해주는 RIB입니다.
- **DetailRIB:** 약국 상세 정보를 볼 수 있는 RIB입니다.

<br>

# 🎯 프로젝트 목표
1. 객체지향의 원리를 적용하여 코드 작성
   - 역할과 책임을 명확하게 분리하여 결합은 낮고 응집도는 높은 코드를 작성합니다.
   - SOLID 원칙과 디자인패턴을 이해하고 활용합니다.
     
3. 테스트 코드를 통한 코드 품질 향상
   - 테스트 코드를 작성하며 코드의 품질을 향상 시킵니다.

<br>

# 🛠️ 사용 기술
- UIKit
- RIBs

<br>

# 🐱 Git 브랜치 전략
프로젝트 관리를 위해서 GitHub Flow 전략을 채택했습니다.

GitHub Flow 전략을 채택한 이유는 간단한 브랜치 구조로 기능을 빠르게 개발하고 배포하기 위함입니다.

![image](https://github.com/user-attachments/assets/6fd39f71-cadf-4ab2-bae1-4c6315d788b8)

- **master**: 제품으로 출시될 수 있는 브랜치입니다.
- **feature branch**: 새로운 기능 개발을 위한 브랜치입니다. 개발이 완료되면 master 브랜치로 병합됩니다.

<br>

# 🏙️ 와이어프레임
<img width="805" alt="스크린샷 2024-08-28 오후 9 50 59" src="https://github.com/user-attachments/assets/ef8d6cfc-fe83-4c62-a2b8-985a89b0870a">
