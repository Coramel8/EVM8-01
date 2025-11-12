// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


//혼자 짜봄
contract ERC20practice {
    
}





/*[ERC20]
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
2. Approval: approve 성공*/