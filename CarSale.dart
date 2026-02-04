//자동차 할인가 계산기 만들기

void main() {
  Car bmw = Car(320, 100000, 'BMW');
  Car toyota = Car(250, 7000, 'TOYOTA');
  Car ford = Car(200, 8000, 'FORD');
  print(bmw.price);
  bmw.saleCar(); 
  bmw.saleCar();
  print(bmw.saleCar());
}

class Car {
  int maxSpeed;
  double price;
  String name;

  Car(this.maxSpeed, this.price, this.name);

  double saleCar() {
    price = price * 0.9; //price를 직접 수정하지 않고 할인 가격을 계산하여 반환
    return price;
  }
}