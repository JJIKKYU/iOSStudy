import UIKit

// 값이 있을 수도 있고 없을 수도 있다
var carName : String?

carName = nil
carName = "Tesla"

// 예시
let num = Int("10") // Type : Optional int
// 변환이 될 수도 있고 안 될수도 있으니까 Optional Data Type이다


/*
 고급 기능 4가지
 
 1. Forced Unwrapping
    (억지로 박스를 까보기)
 2. Optional Binding (if let)
    (부드럽게 박스를 까보자 1)
 3. Optional Binding (guard)
    (부드럽게 박스를 까보자 2)
 4. Nil Coalescing
    (박스를 까봤더니, 값이 없으면 디폴트 값을 줘보자
*/

print(carName!)

if let unWrappedCarName = carName {
    print(unWrappedCarName)
} else {
    print("carName 없음")
}
