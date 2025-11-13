// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


1. EIP-20 transfer() + balances
    기본적인 transfer
    그리고 각 지갑의 balances
2. EIP-20 transferFrom(), approve() + allowances : 
    다른 CA나 EOA가 토큰을 옮길 수 있게 하는 함수
    그걸 위한 approve 함수와 allowances 데이터
3.  (1) wrapped ETH 구현
    (2) 특수한 Transger(*) 



[Contracts]
* Data(Storage - EVM)
* Action
* Event(Log - EVM)

# EIP-20
https://eips.ethereum.org/EIPS/eip-20
- 9가지의 method와 2개의 event

[ERC20]
(data) + 9 methods + 2 events

[ERC20 Methods]

1. name("Words on Chain") 
2. symbol("Words)
3. decimals(18: default)
4. totalSupply
5. transfer(to, amount) - emit Transfer
6. transferFrom(from, to, amount) - emit Transfer
7. approve(to, amount): 주체는 owner(msg.sender) - emit Approval
8. allowance
9. balanceOf

[ERC20 Events]
1. Transfer: 전송 성공
2. Approval: approve 성공




# [06MEmeTOken]
메타마스크 등 UI단에서 보이는 transfer라도, 내부 동작은 다를 수 있음.
    (1) Etherscan에서 Contract가 verify(체크)되어있나 확인
    (2) Contract를 읽을 수 있어야 함.



# Uniswap에서의 동작

[PEPE -> WETH 를 하고 싶다]
1/ PEPE의 approve를 호출해 나=>UNISWAP=>amount 를 PEPE CA의 allowance으로 storage slot에 저장함.
2/ Uniswap을 호출하고, Uniswap이 PEPE와 WETH의 transferfrom을 각각 호출해 pool에서 내게 WETH를 옮기고,
    나에게서 pool로 PEPE를 옮김.

[Uniswap도 ERC-20을 상속함.]
- LP공급 -> addLiquidity -> uniswap contract에서 LP Token을 민팅하는 것.
- 사실상 WETH랑 크게 다르지 않음. TokenA-TokenB 페어를 넣고 LP Token을 주는 것일 뿐.



# [추가실습]
- 로빈후드의 test 토큰 -> 이름을 바꾸는 기능/모든 토큰을 폐기하는 기능
    이런 기능들이 있었는지 찾아보기.
    알고 있었다면 처음부터 들어가지 않을 수 있었음.
    기본적인 체크.
    pepe / aixbt 등과 비교하기.
- WETH 소스코드 확인(etherscan에서)

















