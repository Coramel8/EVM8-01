// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can call this function.");
        _;
    }


}


contract Counter is Ownable{
    // 누구나 1ETH를 내고 카운터 숫자를 1 올릴 수 있음.
    // 계정주는 이를 초기화(reset)하거나 모인 ETH를 출금(withdraw)할 수 있음.
    
    uint private value = 0;

    //Owner 변경시 사용하는 임시저장소
    address public pendingOwner;


    event Reset(address owner, uint currentValue);


    function getvalue() public view returns (uint) {
        return value;
    }

    //1 ETH를 전송해야 Value가 1 올라가는 func
    function increment() public payable{  
        
        require(msg.value == 1 ether, "You must send 1 ETH to count.");

        value = value + 1;        

    }


    // owner만 쓸 수 있는 reset 함수
    function reset() public onlyOwner {

        emit Reset(msg.sender, value);

        value = 0;


    }

    // owner 변경 함수
    // 바로 변경하면 위함하기에(주소 잘못치면 ㅈ됨) 2단계에 걸쳐서 변경
    // 1단계. 임시 저장.
    function transferOwnership(address newOwner) public onlyOwner {
        
        // "0 주소"로 잘못 보내는 것을 원천 차단합니다.
        require(newOwner != address(0), "Cannot transfer ownership to zero address.");
        
        // 'owner'를 바로 바꾸는 대신, 'pendingOwner'에 임시 저장합니다.
        pendingOwner = newOwner;
    }
    
    //2단계. 변경할 EOA에서 함수 호출해서 권한 수락.
    function acceptOwnership() public {
        // 이 함수를 호출한 사람이 'pendingOwner'가 맞는지 확인.
        require(msg.sender == pendingOwner, "You are not the pending owner.");
        
        // 소유권을 최종적으로 넘기고, pendingOwner는 초기화합니다.
        owner = pendingOwner;
        pendingOwner = address(0);
    }




    // owner만 쓸 수 있는 withdraw 함수
    function withdraw_all() public payable onlyOwner {


        payable(owner).transfer(address(this).balance);

    
    }



// owner 알아보는 로직을 모듈화해도 revert가 다 되는가?


}

// 초기 함수 설계 //
// 1. DATA
//  * value : private한 변수. 
//  * owner : public한 변수. 
// 2. ACTION
//  * getValue : public 
//      public이 됨. 사람들이 값을 볼 수 있어야 하니까.
//  * increment : public, payable 
//      1ETH를 내고 숫자를 올리는 것. 근데 solidity에는 이 기능이 기본적으로 없음.
//      TX = 1) Invocation, 2) Payment
//      Invocation은 데이터가 있는가 / Payment는 이더 전송인가
//      예시) 1만 있고 2만 없는 건 free mint. 2만 있고 1만 있는건 전송. 1, 2 다 있는건 유료 minting.
//      payable이 되어있어야만 solidity 내의 함수가 ETH를 받을 수 있음.
//  * reset : public, 다만 owner만 호출 가능하도록 설계.
//      contract를 최초로 만든 사람을 알아야 함. 근데 이더리움은 contract 생성자에게 기본적으로 특별한 권한을 주지 않음.
//      프로그래밍할 때 계정주를 표현하는 값들이 있어야 함. 지갑을 설정하던가(이 경우 계정주 이동 기능도 구현 가능), NFT로 한다던가
//      NFT 경우에는 하이레벨에서 볼 수 있으니 소비자 친화적이고 보안에 약해짐.
//      추가로 왜 public이냐? 이 컨트랙트 안에서만 실행할 게 아니니까 멀리 띄운 EOA에서 결국 
//      reset과 withdraw를 해야 하므로.
//      EOA = Externally Owned Account = 일반 지갑 주소 (예: 0x123...abc)
//      컨트랙트 주소는 private 함수 호출 불가함.
//      따라서 사용자(owner의 지갑)가 직접 트랜잭션 보내야 함 → public 또는 external 필수
//  * withdraw : public, 다만 owner만 호출 가능하도록 설계.
// 3. EVENTS
//  * Reset 기록
//
//  * Event(Log)에도 데이터를 저장할 수 있음. 비용절감효과.





        // 1. Data
        //  * Single : uint, string, 주소 등
        //  * Multiple : array, 등
        //  * Complex

        // 2. Action
        //  * Conditional Statement, Loop
        //  * Function
        //  * Error
        //  * Event(Log)
        //  * modifier, Library, Contract Inheritance