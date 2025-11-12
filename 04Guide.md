

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




















