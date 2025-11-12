
###################################################################
##########################     CODE     ###########################
###################################################################

// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Hello {
    uint public number;
    uint private secret;

    function setSecret(uint newSecret) public {
        secret = newSecret;
    }
}

###################################################################
#######################    Description    #########################
###################################################################

# contract
    contract는 일종의 class라 생각하면 됨.
    contract에 필요한 건 크게 2가지: data와 action - State Variable & Function (python이라면 인자 & method)

## State Variable(상태 변수)
    컨트랙트의 '영구 저장소(Storage)'에 기록되는 변수
    Python이라면 클래스(Class)의 인스턴스 변수(Instance Variable)

    [선언 예시]
    uint private secret;
    uint public numbers;
    
    Visibility
        [public]
        public으로 변수를 선언하면, 솔리디티 컴파일러는 이 변수의 값을 자동으로 읽어올 수 있는 
        number()라는 이름의 함수(getter function)를 무료로 생성해줌.
        
        [private]
        private으로 선언된 변수는 오직 이 컨트랙트 내부에서만 접근(읽기 또는 쓰기)이 가능
        
        다만 private 키워드는 다른 '컨트랙트'가 이 변수에 직접 접근하는 것을 '문법적으로' 차단할 뿐. 
        
        블록체인은 기본적으로 공개 장부(Public Ledger)임.
        
        즉, setSecret 함수를 호출한 트랜잭션 기록을 살펴보거나, 이더리움 노드에 특정 명령
        (예: web3.eth.getStorageAt)을 보내면 private 변수인 secret에 저장된 값을 누구나 알아낼 수 있음.

        절대로!! 스마트 컨트랙트의 private 변수에 실제 비밀번호, 개인 키(Private Key), 
        API 키 등 민감한 정보를 저장해서는 안 됨.

        [internal]
        internal로 선언하면, 이 contract + 상속받은 contract에서만 호출 가능.

        [external]
        external로 선언하면, 이 contract는 호출하지 못하고, 외부 컨트랙트에서만 호출 가능.


    자료형
        uint: "Unsigned Integer"의 약자로, 0과 양의 정수(최대 $2^{256}-1)




## function
    함수의 action/기능 : python이라면 class의 method.


    [작성 예시]
    function setSecret(uint newSecret) public {
        //함수 내용
    }

### 함수의 기본 구조

function <함수이름>(<입력값>) <가시성> <상태 변경성> returns (<반환값>) {
    // ... 함수 내용 ...
}
    <가시성> - State Variable과 동일
    이 함수를 '누가' 호출할 수 있는지 정함. public이 가장 흔하다.

        public: "누구나." (외부 사용자, 다른 컨트랙트 모두 가능)

        private: "오직 이 컨트랙트 내부에서만."

        external: "오직 외부에서만." (컨트랙트 내부에서는 호출 불가. public보다 가스비가 저렴)

        internal: "이 컨트랙트 + 이 컨트랙트를 상속받은 자식 컨트랙트 내부에서만."

    <상태 변경성>
    이 함수가 블록체인의 데이터를 변경하는가? 아니면 돈(ETH)을 받는가?
    가스비(수수료)와 보안에 직결

        view: 이 함수는 블록체인의 데이터를 절대로 변경하지 않고, 오직 읽기만(view) 합니다.(return number 등으로)
            외부에서 이 함수를 '단순 조회' 목적으로 호출(call)하면 가스비(수수료)가 0원
         
        payable: 이 함수는 ETH(돈)를 받을 수 있도록 입금 구멍이 열려 있습니다.
            solidity는 보안을 위해 기본적으로 모든 함수가 ETH를 받는 것을 막아놓음.
            오직 payable 꼬리표가 붙은 함수만이 ETH를 받아서 컨트랙트의 잔고로 쌓을 수 있음.
        
        pure: 스토리지를 아예 읽지도 않음. 순수한 내부 연산 등.
        
        (아무것도 안 붙음): 이 함수는 데이터를 변경(write)합니다. 하지만 ETH(돈)는 받지 않습니다.
            블록체인에 데이터를 쓰기 때문에 가스비가 발생.






###################################################################
##########################     CODE     ###########################
###################################################################

// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Counter {
    // 누구나 1ETH를 내고 카운터 숫자를 1 올릴 수 있음.
    // 계정주는 이를 초기화(reset)하거나 모인 ETH를 출금(withdraw)할 수 있음.
    
    uint private value = 0;


    function getvalue() public view returns (uint) {
        return value;
    }

    //1 ETH를 전송해야 Value가 1 올라가는 func
    function increment() public payable{  
        

        value = value + 1;        

    }

}



###################################################################
#######################    Description    #########################
###################################################################


### adress 자료형
0x...와 같은 이더리움 지갑 주소를 저장하는 자료형

### constructor()
contract가 맨 처음 블록체인에 배포될 때, 단 한 번만 실행되는 초기화 함수.

## msg
message. solidity의 전역변수.
solidity에서 EOA가 CA를 호출하거나 CA가 CA를 호출하거나 하는 TX 연관된 전역변수들.

    ### msg.sender
    이 contract를 배포한 지갑주소.

    ### msg.value
    현재 이 함수를 호출(실행)하면서 함께 보낸 이더(ETH)의 양. 전역 변수.
        payable 키워드가 붙은 함수에서만 0이 아닌 값을 가질 수 있음.
        msg.value의 기본 단위는 ETH가 아니라 Wei.
            1 ETH = 10^18 Wei = 10^9 Gwei
        '1 ether'는 solidity가 제공하는 단위 키워드임. 1 gwei도 됨.

## Error Handling statement
에러 조건을 내기 위한 함수들.
assert, revert, require

    ### require( ... )
    조건문.
    require(<검사할 조건>, "실패할 시 error message")    
        <검사할 조건>이 true이면 코드 실행, false면 함수 즉시 중단 및 모든 변경 사항 revert(가스비는 소모)
    
    require(msg.value == 1 ether, "You must send 1 ETH to count.");
    이 코드는 if문으로 바꾸자면
    if(msg.value == 1 ether) {

    } else {
        revert("You must send 1 ETH to count.");
    }
    와 같음.

    ### revert

    ### require



### address(this): 이 CA의 adress

### <adress>.balance : adress가 보유한 eth 잔액 호출


## ETH transfer
대표적으로 3가지 방법이 있음. .transfer / .send / .call
현대 solidity 개발에서는 .call을 주로 이용함.
    address.transfer : 기본적으로 이더 전송만 할 때 사용. 오류 생기면 tx 자체가 revert됨.
        기본적으로 이더를 전송만 할 때 가장 많이 사용. -> 신경쓸 게 제일 적어서.
    address.send : 전송이 실패했을 때 해당 결과만 false를 하고 아래는 그대로 실행됨.
        전송이 실패했을 때, 이후 코드가 취소되지 않고 싶을 때.
    address.call : 전송할 때 좀 더 세밀하게 전송할 수 있음. .call(gas:, value: )
        함수를 실행시키는 것. .call(gas:, value:) 이런 식으로 원하는 gas와 value 지정 가능.


### 왜 .call을 이용하나?
    gas fee 변경
        Istanbul 하드포크 (EIP 1884) 이후, 특정 operation의 gas fee가 증가
        -> .transfer() 및 .send()의 2300 gas limit에 의존하던 contract들이 작동 멈춤.
    유연성 부족
        2300 gas 제한은 .transfer() 메서드를 덜 안전하게 만듦.
        ETH를 수신하는 contract의 fallback 함수가 2300 gas보다 많이 쓸 경우, 
        예기치 않은 동작 발생 가능하기 떄문.
    
    다만 .call() 은 기본적으로 사용 가능한 모든 가스를 전달하기에, 재진입 공격(reentrancy attacks)에
    취약함. 개발자들은 Checks-Effects-Interactions 패턴과 같은 보안 모범 사례로 위험 완화.

### 일반적인 안전한 패턴 예시
    
    function safeWithdraw(uint256 _amount) external {
    // Check (검사)
    require(balances[msg.sender] >= _amount, "Insufficient balance");
    
    // Effects (효과 - 외부 호출 *전에* 상태를 업데이트)
    // CA 내부 sender몫의 balances에서 출금할 _amount만큼 미리 감소시킴
    balances[msg.sender] -= _amount;
    
    // Interactions (상호작용)
    // sender에게 _amount만큼 전송
    (bool success, ) = msg.sender.call{value: _amount}("");
    require(success, "Transfer failed");
    }
    
    // 이 코드는 처음보면 씨발 이해가 안 갈 것이기에 아래에 추가 설명

### balances[msg.sender]
'CA 내부에 저장된, sender 몫의 예치금'을 의미하는 Contract 내부의 mapping 변수
mapping은 dictionary 비슷한 구조라 보면 됨. 자세한 건 아래쪽에..
    
    CA의 총 잔액: address(this).balanace
    A고객 몫의 돈 : balances[A 고객 주소]
    B고객 몫의 돈 : balances[B 고객 주소]

    아래와 같은 표준으로 선언함.
    mapping(address => uint) public balances;
        address를 key로, uint를 value로 하는 mapping 자료형의 balances 변수를 선언한 것.


### Checks-Effects-Interactions패턴이 왜 중요한가?
1/ Checks   2/ Effects  3/ Interactions
2번과 3번의 순서가 바뀌면 재진입 공격(Re-entrancy Attack)에 당해 모든 돈을 drain당할 수 있음.

    [공격 시나리오]
    등장 Address: 
    adversary(해커 EOA가 만들고 실핸하는 악성CA)
    Vault(돈을 맡아두는 CA. withdraw 구조가 Checks-Interactions-Effects 순서로 취약함.)
    
    1/ adversary가 Vault CA에 10 ETH를 deposit
    2/ adversary가 withdraw 호출
    3/ balances[msg.adversary] >= 10ETH이므로 Checks 통과
    4/ Vault의 contract가 Adversary에게 10ETH를 .call로 전송
    5/ (공격 발생!!)
        adversary에게는 ETH를 받으면 receive()함수가 작동하여 withdraw를 호출하는 악성코드가 있음.
        4/에서 ETH를 받은 순간 receive() 작동, withdraw 재호출.
    6/ Effects 단계를 거치지 않았음으로 balances[msg.adversary]는 여전히 10 ETH
        따라서 Checks 단계를 통과하고 Interactions 단계에서 adversary에게 10 ETH 전송
    7/ Vault의 balance가 0이 될 때까지 5-6번 무한반복





### (bool success, ) = owner.call{value: balance}("");
솔리디티의 표준 출금 코드
    (bool success, ) : 이 call 명령이 성공했는지, 실패했는지 그 결과를 success 변수에 담는다.
        이런 방식을 Tuple Assignment (튜플 할당)이라 부름
        솔리디티의 call과 같은 특정 low-level 함수들은 항상 두 개의 값을 반환하도록 설계되어있음
        예를 들어 owner.call{value: balance}("") 함수는 (A, B)를 반환하는데,
        A는 bool타입으로 함수 호출의 성공/실패 여부
        B는 bytes memory로 호출된 함수가 어떤 데이터를 반환했다면, 그 데이터값(여기서는 data 없어서 공백)
    owner.call : owner의 주소로 eth를 전송하라는 명령
    {value: balanace} : 전송할 금액은 방금 계산한 balance
    (""): 데이터를 함께 보내지 않음을 명시



# Event

[선언 및 사용]
event <이벤트명> (자료형 <이름>, 자료형 <이름>, ...)
emit <이벤트명> (데이터, 데이터, ...)

frontend 개발자나 외부에서 읽을 수 있도록 최대한 정보를 log에 제공해줘야 함.


# 리팩토링

## modifier : function은 아닌데 function이랑 똑같이 작동함.
함수 선언 때 추가 속성을 붙여서 사용.

[선언]
    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can call this function.");
        _; //이렇게 만들면 onlyOwner를 실행한 뒤에 함수 본문을 실행하게 됨
        // -; 아래에 넣은 코드는 함수 본문이 실행된 이후에 실행하게 됨
    }

[사용]
    function withdraw_all() public payable onlyOwner { 
        ... //modifier은 한 function에 여러 개 붙일 수 있다. 순서대로 실행된다.
    }

## constract 상속
한 contract는 하나의 logic에 집중하는 게 깔끔함.
따라서 contact별로 역할을 분리.
아래와 같이 짜면 <부모 contract>의 모든 내용을 해당 ocntract에서 쓸 수 있음.
[사용]
    contract is <부모 contract> {
        ...
    }
[C3 선형화(C3 Linearization) & 다이아몬드 problem]
C3 Linearization : is 키워드 뒤에 나열된 부모 contract 중 가장 오른쪽에(가장 마지막에) 있는 
    contract가 가장 우선순위가 높음.(가장 나중에 파생된 것으로 간주)
다이아몬드 문제(충돌): 만약 여러 부모가 동일한 이름의 함수를 가지고 있다면(다이아몬드 문제), 
    Solidity는 위에 만들어둔 우선순위를 기반으로 어떤 함수를 상속할지 결정합니다.




###################################################################
###########################    고급    #############################
###################################################################


## mapping
EVM의 자료형 중 하나. key->value 묶음 방식.

    [선언 예시 1]
        mapping(address => boll) public blacklist;
        // 주소값의 blacklist 여부를 저장하는 mapping  -> 특정 계좌를 frozen 시킨다던가.
        // 혹은 한 명 뺴고 전송이 안되게 한다던가(honnypot 러그)

    [선언 예시 2]
        mapping(address => uint) public balances;
    
    [선언 예시 3]
        mapping(address => mapping(address => uint)) public allowance;
        // Uniswap 등의 exchange의 allowance 기능 설계 방식. EIP-20인 ERC-20 CA안에 저장됨.
        // EOA => CA => allowance 수량
        // 누가(지갑) -> 누구에게(DEX 등) -> 얼마만큼 허용해줬나
 
    dictionary와 다른 점은 key를 저장하지 않고, 값만 저장하는 방식이라는 것.
    (why? key까지 저장하면 비싸니까...)

    값 데이터는 
    {키(balances의 경우에는 adress) + Mapping slot} -> keccak256 해시 -> '해시결괏값 = 스토리지 슬롯'
    이 되어 해당 슬롯에 sstore됨.
        * mapping_slot: base slot. 해당 mapping type 변수가 선언된 스토리지 슬롯 번호
            (보통 0, 1, 2...)
    
    이후 찾을 때 address, mapping slot을 알고 있으므로 이를 다시 
    keccak256 해시에 집어넣어서 storage slot을 찾아감

    (실무 - 맞나?)
    따라서 온체인에서 data를 검색-서칭하는 건 사실상 불가능.
    따라서 오프체인에서 이벤트 log를 수집해 키-값 인덱싱을 해놓아야 함.


## address
이것도 자료형. EVM에 존재할 수 있는 모든 주소값
    총 2^160개. (우주의 원자 수보다 많다나..?)





###################################################################
###########################    EVM    #############################
###################################################################

# Trie 구조
EVM은 총 4개의 Trie로 구성됨. 각각의 Trie는 key->Value 묶음 구조로 저장.
    World State Trie : address → Account
        최상위 루트임.

    Storage Trie : (각 CA별) slot (256비트) → value (256비트)
    
    Transaction Trie : 트랜잭션 해시 → 트랜잭션
    
    Receipt Trie : 트랜잭션 해시 → 영수증


# ethereum의 world-State
기본적으로 address - account의 거대한 key-value Mapping
    address는 주소(0x...)
    account에 정보 : nonce, balance, storageRoot, codeHash

    address만 가지고 EOA인지 CA인지 구분 못한다
        * EOA: Externally Owned Account : 외부 소유 account, 일반 지갑
        * CA: contract Account : 컨트랙
    EOA랑 CA의 구분기준: CodeHash가 비어있으면 EOA, 내용이 있으면 CA라고 부른다.

    EOA만이 서명한 transaction으로 이더리움의 state를 바꿀 수 있다. 
    (account의 4가지 상태 변경, 새로운 CA 생성 등)


    [EVM World State (전역 상태) - 가시화]
    ┌────────────────────────────────────────────────────┐
    │ address: 0x111...111 (EOA)                         │
    │   balance: 10 ETH                                  │
    │   nonce: 5                                         │
    │   storage: 없음                                    │
    ├────────────────────────────────────────────────────┤
    │ address: 0x222...222 (Contract)                    │
    │   code: 0x60806040... (바이트코드)                 │
    │   balance: 1 ETH                                   │
    │   storage:                                         │
    │     slot 0: 100                                    │
    │     slot 0xf18e...: 50 (mapping)                   │
    │     ...                                            │
    │     slot 2²⁵⁶-1: 가능 (비어 있음)                  │
    ├────────────────────────────────────────────────────┤
    │ address: 0x333...333 (Contract)                    │
    │   ...                                              │
    └────────────────────────────────────────────────────┘

## Address
총 2^160(160비트)의 adress가 존재할 수 있음.
    * 생성된 주소만 존재. 미생성 주소는 존재하지 않음.
모든 address는 두 가지로 분류.
    [EOA]
    Externally Owned Account, 외부 소유 account, 일반 지갑
    nonce, balance만 보유함.

    [CA]
    contract Account, 컨트랙
    nonce, balance, storageRoot, codeHash를 보유할 수 있음.
        * 기본적으로 codeHash의 존재 여부에 따라 EOA와 CA를 구분

## Account State
총 4개의 field가 있음.
nonce, balance, storageRoot, codeHash.


### nonce
EOA의 트랜잭션 수 또는 CA의 컨트랙트 생성 수

### balance
해당 Address의 ETH 잔액

### storageRoot
Merkle Patrica 방식으로 저장된 물리적인 storage trie를 찾아갈 수 있게 해주는 포인터(라고 이해하면 됨)
    
모든 state variables를 Merkle Patricia Trie (MPT) 구조로 만들 때, 그 트리의 최상단 Root Node의 Hash.
    
    [왜 쓰나?]
    실제 data는 storage trie에 저장되지만, data가 바뀌면 storageRoot이 바뀌므로 데이터 위변조를 
    World State trie의 storageRoot만 보고도 검증할 수 있음.

    [Sotrage Slot]
    storage slot은 EVM 논리적 슬롯임.
    EVM은 컨트랙트 별로 최대 256비트(2^256)의 storage slot을 제공함.
    각 Slot당 저장공간은 256bit == 32byte
    이는 각 contract별로 가상 할당된 최대 할당량임.
    또한 가상 할당이기에 contract에서 사용되지 않은 slot은 evm에 저장되지 않음.
    
    모든 CA는 기본적으로 데이터를 storage slot에 저장함.(log에 저장하는 경우 제외)
    데이터 저장 방식은 각 slot마다 key-value 방식.

        [storage slot 배분방식]

        contract 내에서 선언된 정적 변수들은 0, 1, 2, ... 여기에 저장됨.
        예를 들어 slot 0 : 0x00000000000000000000000000... (0x + 64자리 16진수)
        (변수 크기가 작으면 컴파일러가 같은 slot에 여러 변수를 저장해서 용량 압축하기도 함.)
        
        mapping한 데이터는 keccak256(key, base slot)에 저장됨.
            예를 들어 mapping(address => uint) public balances; 이면
            keccak256(address, <balances의 slot>)의 결괏값인 storage slot에 uint가 저장되는 식.
        
        이외에도 동적 변수, array 등등...이 다른 방식으로 storage slot을 할당받아 저장됨.
        자세한(복잡한) 규칙은 아래 참조
            contract FullExample {
            // --- Slot 0: Packing (압축) ---
            address public owner;     // 20 바이트 (슬롯 0의 0~19 바이트)
            bool public isEnabled;    // 1 바이트 (슬롯 0의 20번째 바이트)
            uint32 public counter;    // 4 바이트 (슬롯 0의 21~24 바이트)
            // (총 25바이트 사용, 슬롯 0에 7바이트 남음)

            // --- Slot 1: Full Size ---
            uint256 public totalValue; // 32 바이트 (슬롯 1 전체 사용)
            // (앞의 'counter'와 합칠 수 없으므로(25+32 > 32), 새 슬롯 1로 이동)

            // --- Slot 2: Mapping ---
            mapping(address => uint) public balances;
            // (슬롯 2는 비어있음. 실제 데이터는 keccak256(key, 2)에 저장)

            // --- Slot 3: Dynamic Array: (bytes, string, uint[] 등) ---
            uint[] public values;
            // (슬롯 3에는 배열의 '길이'가 저장됨)
            // 실제 데이터(배열의 요소들)는 keccak256(3)번 슬롯부터 순차적으로 저장

            // --- No Slot (스토리지 사용 안 함) ---
            uint constant VERSION = 1;
            address immutable FACTORY;
            //constant와 immutable로 선언된 변수는 스토리지 슬롯을 전혀 사용하지 않습니다.
            // constant: 컴파일 시점에 그 값으로 대체됩니다. (바이트코드에 포함)
            // immutable: 컨트랙트 배포 시(constructor) 값이 정해지며, 바이트코드에 직접 포함됩니다.

            constructor(address _factory) {
                FACTORY = _factory;
            }
        }

    [물리적 저장]
    참고로 실제 저장은 물리적인 data store는 Merkle Patrica 방식으로 storage trie에 저장되는데...
    여기서도 key-value 쌍으로 저장하는데, 모든 key를 keccak256으로 해싱해서 저장함.
    그러니까 물리적인 저장 단계까지 갈 때 정적 변수는 1회, mapping은 2회 해싱된다고 보면 됨.
    (이 부분은 나중에 low-level 공부하며 직접 봐야할듯)



### codeHash
배포된 contract 바이트코드의 해시
    
    solidity에서 짠 contract 전체가 지문으로 keccak256으로 해싱되어서 codeHash에 저장됨.

    EOA는 기본적으로 공란이라 codeHash = keccak256("") = 0xc5d246... (고정값)






# Gas price, Gas fee

Gas Fee = Transaction Fee = 총 수수료 = Gas price * Gas Used

Gas price : 네트워크 부하에 따른 기름값
    Gwei는 1/1B ETH. 1,000Gwei면 백만분의 1 ETH임(ETH 4k 기준 0.4센트=6원)
    예) Base mainnet 현재 Gas price 0.09 Gwei

Gas Used (또는 Gas Limit) : 특정 행동에 얼만큰의 Gas가 소모되는가
    EVM이 실행한 연산량에 따라, 256개 OPCODE에 각각 미리 정해져 있음 : https://www.evm.codes/?fork=shanghai
    Gavin Wood가 2014년 Yellow Paper에 표로 써놓음 -> 이더리움 하드포크 때만 수정 가능
    Gas Limit은 최대 설정치고, 최종 계산은 Gas Used로 반영.
    예) ETH 전송: 21000 = 16,000 Base + 4,900 서명 + 100 기타


## 살짝 고급 개념
Base Fee : 위에서 말한 Gas fee
Priority Fee (팁) : 마이너에게 주는 팁(높으면 마이너가 우선적으로 처리)
Max Fee : 이 Tx에서 최대 얼마까지 낸다고 정해둔 제한.
Effective Gas Price : Base + Priority Fee




###################################################################
#######################    Extra Study    #########################
###################################################################


# Programming Language of Blockchain

## Solidity
EVM을 돌리는 대표적인 언어.
이더리움 재단 및 커뮤니티가 합작으로 만든 오픈소스 언어.

## Hardhat
VScode와 같은 IDE에 설치해서 쓰는 전문 개발 환경.
npm으로 프로젝트 폴더 안에 설치함.
typscript 등 다른 언어와 Solidity를 연동해주고, 내부에 로컬 테스트넷을 생성하는 등 다양한 기능.

## npm
Node Package Manager
Node.js와 함께 배포되는 패키지 관리자
node.js에 연동된 오픈소스 라이브러리(npm registry)가 있고, 여기 있는 걸 쉽게 끌어다 쓸 수 있게 해주는 매니저
npm install (명령어): 개발자가 이 명령어를 실행하면 -> npm이 프로그램 폴더에 있는 package.json에서 필요한 걸 읽어서
-> 창고(npm registry)에 있는 실제 라이브러리(코드)를 가져와 -> node_modules라는 폴더에 설치

### npm의 저작권
npm registry에 저장되고 '공개된' 패키지라고 해도 모두 MIT나 Apache-2.0처럼 상업적으로 이용 허락된 건 아님.
GPL처럼 '이용해도 되지만, 코드를 결합(정적/동적 링크)할 경우 네 코드도 전부 GPL로 공개해야 함'같은 경우도 있음.
    
    license-checker로 이 문제 해결. 지금 node_moidules에 들어있는 패키지의 라이선스를 요약해서 보여줌.
    npx license-checker --summary
        * npx : license-checker라는 도구를 내 컴퓨터에 설치하지 않고 "일회용"으로 다운로드해서 딱 한 번 실행하고 지우는 매우 유용한 npm 명령어
    


## OPCODE?
EVM은 256개의 opcode(명령어)로만 움직임.
일종의 EVM 버전 어셈블리어
    * 어셈블리어 = 사람이 읽기쉽게 문자로 써놓은 기계어(기본적으로는 종류 숫자가 같음... 다만 예외는 많음)
    * x86 체제의 어셈블리어는 약 수천 개
256개인 이유
    1바이트로 표현 가능: 0x00 ~ 0xFF → 256
    복잡한 CPU 대신 스택 + 메모리 + 스토리지만
    모든 opcode Gas 비용 고정 → DoS 공격 방어

















