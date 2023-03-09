# Wanted-FreeOnBoarding-iOS
원티드 프리온보딩 챌린지 iOS 파트
## 1차 스터디 GCD - **Dispatch Queues**

dispatch queues를 사용하면 호출자(caller)와 관련하여 비동기/동기식으로 임의의 코드 블록을 수행 할 수 있습니다. dispatch queues를 사용하여 별도의 쓰레드에서 수행하는 거의 모든 task를 수행 할 수 있습니다. 

### What is dispatch queues?

dispatch queues은 앱에서 task를 비동기적으로 동시에 수행 할 수 있는 손쉬운 방법입니다. 함수 또는 블록 객체 내에 해당 코드를 배치하고 dispatch queues에 추가하여 task를 정의합니다. 

모든 dispatch queues은 FIFO데이터 구조입니다. 
따라서 queues에 추가하는 task는 항상 추가된 순서대로 시작됩니다. queue는 선입선출! 즉 FIFO가 특징이죠? 먼저 온 사람이 먼저 서비스를 받는 그런 자료구조에요.

### dispatch queuse의 타입과 사용방법은? - **Serial, Concurrent, Main dispatch queue**

1. Serial queues (private dispatch queues)
    
    하나의 작업이 끝나고 그 작업이 끝나야만! 다음 작업을 시작하는 큐입니다.
    Serial queues(private dispatch queues라고 알려진)은 큐에 추가된 순서대로 한번에 하나의 task를 실행합니다. 필요한 만큼 Serial queues를 작성 할 수 있으며, 각 큐는 다른 모든 큐와 관련하여 동시에 작동합니다. 
    Serial queues을 4개 작성하면 각 큐는 한번에 하나의 task만 실행하지만, 최대 4개의 task가 각 큐에서 동시에 실행될 수 있습니다.
    
2. **Concurrent queues (global dispatch queue)**
    
    한번에 하나의 작업만 하고 그런게 아니라!!!!! 동시에!!!동시에!!!! 여러 작업들을 시작하는 큐입니다. 동시에 여러작업을 한다고 해서 막 니가먼저 내가먼저 이런게 아니라, 일단은 queue이기 때문에 먼저 들어온 작업이 먼저 서비스를 받는 것입니다. 근데 그걸 동시에 하는것 뿐입니다.
    동시에 하나 이상의 task를 실행하며 task는 큐에 추가된 순서대로 계속 시작됩니다. 현재 실행중인 task는 dispatch queue에서 관리하는 고유한 쓰레드에서 실행됩니다. 특정 시점에서 실행되는 정확한 task의 수는 가변적이며 시스템 조건에 따라 다릅니다.
    
3. **Main dispatch queue** 
    
    main dispatch queue는 앱의 main 쓰레드에서 task를 실행하는, 전역적으로 사용 가능한 serial queue입니다. 이 큐는 앱의 실행루프와 함께 작동하여 큐에 있는 task의 실행을 실행루프에 연결된 다른 이벤트 소스의 실행과 얽힙니다. 앱의 main 쓰레드에서 실행되므로, main queue는 종종 앱의 주요 동기화 지점으로 사용됩니다. main dispatch queue를 만들 필요는 없지만, 앱이 적절하게 배수(drains)되도록 해야합니다.
    

### dispatch queuse 코드 작성 방법은?

독립적이고, 비동기적으로 실행되는 task를 설계하는 것입니다.(이는 실제로 쓰레드 및 dispatch queues에 모두에 대해 해당됩니다.)

하지만 dispatch queues의 장점은 예측가능성(predictability)입니다. 동일한 공유 리소스에 액세스 하지만, 다른 쓰레드에서 실행되는 두가지 task가 있는 경우, 쓰레드가 먼저 리소스를 수정 할 수 있으므로, 두 task가 동시에 해당 리소스를 수정하지 못하도록 lock을 사용해야합니다. dispatch queues을 사용하면 한번에 하나의 task만 자원을 수정하도록 할 수 있습니다.

### Serial과 Concurrent의 특징이 Operation queue에 들어갔던 것처럼 Dispatch Queue에도 들어간다면?

Serial과 Concurrnet의 특징이 Dispatch Queue에 들어가면, Serial Dispatch Queue 그리고 Concurrnet Dispatch Queue가 있게 됩니다. 자연스럽게 
Serial Dispatch Queue에 task들을 넣으면 한 task가 끝나야지 다음 task를 하겠고, Concurrent Dispatch Queue에 task들을 넣으면 앞 task의 완료 여부에 상관없이 동시에 task를 실행하겠네요.

### Cocoa Application은 미리 만들어진 queue 2가지를 제공 - main & global

main dispatch queue는 위에서 언급한 것과 같이 앱의 main 쓰레드에서 task를 실행하는, 전역적으로 사용 가능한 **serial queue** 입니다.

그럼 당연히 main dispatch queue는 serial한 큐니까 한 task가 끝나야지 다음 task를 할 수 있습니다.

**그리고 보통 찾아보면 반드시 이 main queue에 UI와 관련된 task를 넣어야 한다고 그러죠. 왜 그럴까요?**

[https://zeddios.tistory.com/519](https://zeddios.tistory.com/519)

global queue도 위에서 업근했다! Concurrent queues(일종의 global dispatch queue라고도 알려진)은 동시에 하나 이상의 task를 실행하지만 task는 큐에 추가된 순서대로 계속 시작됩니다. 현재 실행중인 task는 dispatch queue에서 관리하는 고유한 쓰레드에서 실행됩니다.

### sync와 async는 무엇일까?

sync, async는 말그대로 동기적으로 처리할거냐 비동기적으로 처리할거냐 입니다. main이든 global이든 sync, async둘 다 가지고 있어요.

### DispatchQueue.main.sync와 DispatchQueue.global().async는 어떻게 사용할까?

DispatchQueue.main은 그냥 main이라 적어줬는데, global은 아니네요. main은 타입프로퍼티라서 그러네요.

하지만 global은 사실 파라미터로 무언가를 받네요!

![스크린샷 2023-03-07 오후 5.21.17.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5824885e-b9c8-46f3-9ed7-c22adf4d6aa0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-03-07_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.21.17.png)

global 이 파라미터로 받고 있는 qos는 … quality of service의 줄임말로 “중요도”라고 생각하면 됩니다.

DispatchQoS의 overview를 잠깐 볼까요?

> **QoS (Quality of Service) class는 DispatchQueue에서 수행 할 작업을 분류합니다.** 
DispatchQoS가 “클래스”라는게 아니라, (구조체입니다.) DispatchQoS에 qosClass라는게 있어요. 저 qos 파라미터로 들어간건 DispatchQoS.QoSClass라는 enum입니다.
> 

작동시킬 QoS를 지정함으로써 중요도를 표시합니다! 시스템이 우선순위를 정하고 이에따라 스케쥴링을 정할 수 있도록 합니다. 우선순위가 높은 작업은 우선순위가 낮은 작업보다 더 빨리 수행되고, 리소스가 많으므로 일반적으로 우선순위가 낮은 작업보다 더 많은 에너지가 필요합니다. 앱이 수행하는 작업에 적합한 QoS클래스를 정확하게 지정하면, 앱이 반응적?(responsive)이고 에너지 효율이 좋다는 것을 보장 할 수 있습니다.

QoS를 자세하게 정리한 글은 → **[http://zeddios.tistory.com/521](http://zeddios.tistory.com/521)**

```swift
DispatchQueue.global(qos: .background).async {
    //code
}
```

아무튼 이렇게 쓸 수 있으며, 적절하게 QoS를 지정해주면 앱의 에너지 효율이 좋아진다는 것!!!!! 아무것도 안적고 그냥 global()로 하면 default입니다!

### main, global 큐 외에도 개발자가 큐를 만들 수 있어요!

```swift
convenience init(label: String, qos: DispatchQoS = default, attributes: DispatchQueue.Attributes = default, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = default, target: DispatchQueue? = default)
```

위의 생성자는 DispatchQueue의 생성자입니다. 여기서 세번째 파라미터인 **attribute**가 중요해요!!

label을 제외한 나머지 값들이 default로 지정되어있으니, 따로 추가를 안해줘도 됩니다. 

```swift
let hongQueue = DispatchQueue(label: "hong")
```

 따라서 이렇게 큐를 만들면, 나머지 파타미터는 default가 됩니다.

```swift
let hongQueue = DispatchQueue(label: "hong", attributes: .concurrent)
```

이렇게 명시적으로 지정을 해줘야!!!!! 비로소 concurrent queue가 됩니다.

### 그럼 다시 sync, async 이야기 해보죠!

sync는 자, 제가 큐에 작업을 추가했어요 그럼 그게 끝날때까지 “기다리는” 겁니다.

async는 일단 그냥 큐에 작업을 추가하고, 나는 그냥 뭐 기다리는것도 없고 그냥 나는 다른 작업 할 수 있는 거에요. 내가 세탁기 돌려놓고 책읽는 것처럼.. 이게 바로 async입니다.

그럼!!! 일단 queue는 sync, async 둘 중에 하나로 작업을 돌릴 수 있겠네요. 중첩도 가능하지만 일단 하나만 있는걸 봅시다.

1. sync

일단 편하게 sync부터 봅시다. global로 만들고 sync로 만들었으니, 이 global큐가 끝날때 까지는 다른 작업을 하지 않겠네요. 이것은 global 큐

```swift
DispatchQueue.global().sync {
    for i in 1...5 {
        print(i)
    }
    print("==================")
}
for i in 100...105 {
    print(i)
}
```

![스크린샷 2023-03-07 오후 6.35.54.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/20af888e-7966-414e-910b-caabf8fc5682/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-03-07_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_6.35.54.png)

1. async

global에서 async의 경우

```swift
DispatchQueue.global().async {
    for i in 1...5 {
        print("\(i)🐶")
    }
    print("==================")
}
DispatchQueue.global().async {
    for i in 200...205 {
        print("\(i)😍")
    }
    print("==================")
}
for i in 100...105 {
    print("\(i)👻")
}
```

![스크린샷 2023-03-07 오후 7.13.47.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9deb6a9a-468a-4128-ba93-132ecd6b9236/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-03-07_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7.13.47.png)

결과는 매번 실행때 마다 다릅니다. 왜냐면 async는 완료 여부에 상관없이 다음 코드를 실행하니까..하지만 global. 즉 concurrent기 때문에 개(🐶)가 끝나지 않아도 😍가 실행될 수 있죠. 왜냐? concurrent니까..동시에...실행하니까...

하지만 Serial에 async를 해보겠습니다.

```swift
let hongQueue = DispatchQueue(label: "hong")
hongQueue.async {
    for i in 1...5 {
        print("\(i)🐶")
    }
    print("==================")
}
hongQueue.async {
    for i in 200...205 {
        print("\(i)😍")
    }
    print("==================")
}
for i in 100...105 {
    print("\(i)👻")
}
```

![스크린샷 2023-03-07 오후 7.22.12.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9bc6823a-e757-4d26-92bd-1a8b447328b4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-03-07_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7.22.12.png)

한가지는 확실하죠. 개🐶가 끝나야만 😍가 실행됩니다. 왜냐????? Serial이니까.......한 task가 끝나야 다음 task가 실행되니까...

유령👻은 큐안에 들어가 있지 않으니 언제 실행될지 모릅니다!!!!!

## **Dispatch WorkItem**

WorkItem은 별거 아니고, 수행 할 수 있는 task를 캡슐화 한거에요. 이 WorkItem은 Dispatch queue 및 Dispatch Group에 dispatch 할 수 있어요.

Dispatch WorkItem은 DispatchSource이벤트, 등록 또는 취소 handler로 설정 할 수도 있습니다.

어렵게 생각하지말거

```swift
let WorkItem = DispatchWorkItem {
    for i in 1...5 {
        print("Dispatch WorkItem \(i)")
    }
}
DispatchQueue.global().async(execute: WorkItem)
```

이렇게..말 그대로 정말 캡슐화.…

** 제드님 블로그와 naljin님 블로그 참고하며 정리하였습니다.
