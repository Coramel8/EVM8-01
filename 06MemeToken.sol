// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


//Transfer할 때 개발자에게 10% 수수료 뗴는 MemeToken
contract WrappedETH {

    string name = "Wrapped ETH MEME";
    string symbol = "WETHMEME";
    uint8 decimals = 18;
    uint totalSupply = 0;

    address dev;

    mapping(address owner => uint amount) public balances;
    
    mapping(address => mapping(address => uint)) public allowances;
    
    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);

    constructor() {
        balances[msg.sender] = totalSupply;
        dev = msg.sender;
    }


    function deposit() public payable returns (bool success) {
        uint amount = msg.value;
        address owner = msg.sender;
        
        totalSupply += amount;
        balances[owner] += amount;

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

        emit Transfer(owner, address(0), amount);

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

    // 메타마스크 등 UI단에서 보이는 transfer라도, 내부 동작은 다를 수 있음.
    //  (1) Etherscan에서 Contract가 verify(체크)되어있나 확인
    //  (2) Contract를 읽을 수 있어야 함.
    function transfer(
        address _to, 
        uint _amount
    ) public returns (bool success) {
        
        address owner = msg.sender;
        uint fee = _amount / 10;

        require(balances[owner] >= _amount, "Not enough balance in account"); //체크
        
        balances[owner] -= _amount; //차감
        // dev에게 수수료 10% 보내도로 구현.
        balances[dev] += fee;
        balances[_to] += (_amount - fee); //전송
        
        emit Transfer(owner, _to, _amount); //이벤트
        
        return true;
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
        uint fee = _amount / 10;

        require(currentAllowance >= _amount, "_amount must be same or smaller than allowance."); // allowance 체크

        require(balances[_from] >= _amount, "don't have enough amount."); // 밸런스 체크

        allowances[_from][msg.sender] = currentAllowance - _amount; // allowance 차감

        balances[_from] -= _amount; // 차감

        balances[dev] += fee;
        balances[_to] += (_amount - fee); // 전송

        emit Transfer(_from, _to, _amount); //이벤트

        return true;

    }


    

}



