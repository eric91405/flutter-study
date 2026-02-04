// 로또 번호 생성기
import 'dart:math' as math; //as math는 dart:math 라이브러리를 math라는 별칭으로 호출하겠다는 뜻

void main() {
  var rand = math.Random();
  Set<int> lotteryNumber = Set(); // Set은 중복을 허용하지 않는 리스트(중복되면 데이터를 더 추가 X)

  while (lotteryNumber.length < 6) {
    lotteryNumber.add(rand.nextInt(45)); // rand.nextInt는 0~45중 숫자하나 생성
  }

  print(lotteryNumber);
}