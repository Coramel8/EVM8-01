// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Rullet {
    
    // data //
    // 모든 사람들이 행한 총 룰렛 횟수(0.1 ETH 당 1회) 카운트하는 넘버
    // 넘버 올린 주소별 잔고
    // 관리자용 address 저장

    uint public number;
    address public owner;
    mapping(address => uint) public balances;


    // action //
    // fullet : 입금하면 입금한 금액만큼 0.1ETH당 무작위로 증가
        // (50%: 0~0.05, 30% 0.05~0.1, 19% 0.1~0.2, 1% 0.2~1)
    // withdraw_개별계좌
    // withdraw_관리자 : 관리자 전체 출금
    // renew : 관리자 전체 리셋
    // 관리자 번경

    constructor() {
        owner = msg.sender;
    }

    event Log(string message);
    event num(uint number);
    event result(address, uint, uint, uint);


    // 갬블
    function rullet() public payable {
        require(msg.value > 0, "You have to deposite to gamble.");

        uint roll = msg.value / 0.1 ether;
        uint total = 0;

        for (uint i = 0; i < roll; i++) {
            uint256 random = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, i)));
            uint256 randomNumber = random % 100; // 0에서 99 사이의 난수 생성

            // keccak256 해시 함수: bytes 덩어리 입력 -> 32bytes 출력(bytes32 hash)
            // abi.encodePacked(a, b, c, ...): "여러 개의 변수"(uint, address, string 등)를 keccak256이
            // 받을 수 있는 한 덩이의 bytes 타입으로 합쳐주는 역할. padding 없이 바이트 그대로 붙여버림.
            // 타임스탬프, block 난이도, 루프 횟수 i를 뒤섞어서 pseudo-random generator를 만든 것
            // block.prevrandao: 비콘 체인(Beacon Chain)에서 생성되는 이전 블록의 랜덤 값.
                // block 난이도(block.difficulty): PoS 방식에서는 난이도가 존재하지 않음.
                // 다만 PoS 업데이트 당시 block.difficulty를 반환하는 Opcode(0x44)를 그냥 날려버리면,
                // 이전에 배포된 수많은 CA가 먹통이 될 것이기에 대신 block.prevrandao를 반환하게 함.
            
            uint earn;

            if(randomNumber < 50) {
                earn = (randomNumber + 1) * 0.001 ether;
                balances[msg.sender] += earn;
            } else if (randomNumber < 80) {
                earn = ((randomNumber - 49) * 0.05 ether / 30 + 0.05 ether);
                balances[msg.sender] += earn;
            } else if(randomNumber < 95) {
                earn = ((randomNumber - 79) * 0.01 ether / 15 + 0.1 ether);
                balances[msg.sender] += earn;
            } else {
                earn = ((randomNumber - 94) * 0.08 ether / 5 + 0.2 ether);
                balances[msg.sender] += earn;
            }

            total += earn;
            number++;
        }

        
        emit result(msg.sender, (msg.value / 1 gwei), (total/1 gwei), (balances[msg.sender] / 1 gwei));

    }

    // 유저 인출
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "not enough money in account");

        balances[msg.sender] -= _amount;

        payable(msg.sender).transfer(_amount);
    }

    // 관리자 인출
    function withdraw_system(uint256 _amount) public {
        require(msg.sender == owner, "Only ownder can use this");

        payable(msg.sender).transfer(_amount);

        //정해진 분량 인출

    }



}

