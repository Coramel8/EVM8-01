// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


//Wrapped ETH라는 건, ETH를 어떠한 이유로 ERC-20 형태로 Wrapping해둔 토큰.
contract WrappedETH {

    string name = "Wrapped ETH";
    string symbol = "WETH";
    uint8 decimals = 18;
    uint totalSupply = 0;

    mapping(address owner => uint amount) public balances;
    
    mapping(address => mapping(address => uint)) public allowances;
    
    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    //deposit(ethToToken) : ETH 받아서 - WETH 잔액 증가
    //withdraw(tokenTOETH) : WETH 받아서 - ETH 주기

    function deposit() public payable returns (bool success) {
        uint amount = msg.value;
        address owner = msg.sender;
        
        totalSupply += amount;
        balances[owner] += amount;

        // event Transfer가 토큰 전송의 표준이라, 아래처럼 써야 다른 곳에서 읽어올 수 있음.
        // 결국 WETH의 Transfer를 알려주는 게 중요.
        emit Transfer(address(0), owner, amount); 
        emit Deposit(owner, amount);

        return true;

    }

    function withdraw(uint amount) public returns (bool success) {

        address payable owner = payable(msg.sender);

        require(balances[owner] >= amount, "not enough balance in account.");

        balances[owner] -= amount;
        totalSupply -= amount;

        // (1) 현재 withdraw는 토큰을 소각하는 해우이
        // (2) 이걸 withdraw = 자사주 매입 으로 설계할 수도 있음
        //  그러면 totalSupply는 감소하지 않고, CA의 balances가 증가할 것.(EOA->CA 로 transfer되는 개념)

        owner.transfer(amount);

        emit Transfer(address(this), owner, amount);

        return true;
    }


    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }


    function allowance(
        address owner,
        address spender
    ) public view returns (uint) {
        return allowances[owner][spender];
    }

    function transfer(
        address _to, 
        uint _amount
    ) public returns (bool success) {
        
        address owner = msg.sender;

        require(balances[owner] >= _amount, "Not enough balance in account"); //체크
        
        balances[owner] -= _amount; //차감

        balances[_to] += _amount; //전송
        
        emit Transfer(owner, _to, _amount); //이벤트
        
        return true; //함수가 끝까지 실행됐다 = 전송이 잘 됐다 = 성공 반환
    }

    

    function approve(address _spender, uint _amount) public returns (bool success) {
        
        require(_spender != address(0), "You should not allow to zero address"); // 소각주소에 allow하는 거 아닌지 확인.
        
        allowances[msg.sender][_spender] = _amount;

        emit Approval(msg.sender, _spender, allowances[msg.sender][_spender]);

        return true;
    }

    function increaseAllowance(address _spender, uint _increaseamount) public returns (bool success) {
        
        allowances[msg.sender][_spender] += _increaseamount;

        emit Approval(msg.sender, _spender, allowances[msg.sender][_spender]);

        return true;
    }

    function decreaseAllowance(address _spender, uint _decreaseamount) public returns (bool success) {

        require(allowances[msg.sender][_spender] >= _decreaseamount, "allowance must be bigger than _decreaseamount");
        
        allowances[msg.sender][_spender] -= _decreaseamount;

        emit Approval(msg.sender, _spender, allowances[msg.sender][_spender]);

        return true;
    }


    function transferFrom(address _from, address _to, uint _amount) public returns (bool success) {

        uint currentAllowance = allowances[_from][msg.sender];

        require(currentAllowance >= _amount, "_amount must be same or smaller than allowance."); // allowance 체크

        require(balances[_from] >= _amount, "don't have enough amount."); // 밸런스 체크

        allowances[_from][msg.sender] = currentAllowance - _amount; // allowance 차감

        balances[_from] -= _amount; // 차감

        balances[_to] += _amount; // 전송

        emit Transfer(_from, _to, _amount); //이벤트

        return true;

    }


    

}



