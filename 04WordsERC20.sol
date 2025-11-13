// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


//혼자 짜봄
contract WordsonChainERC20 {

    string tokenName = "Words on Chain Token";
    string tokenSymbol = "Words";
    uint8 tokenDecimals = 18;
    uint tokenTotalSupply = 1e9 * 1e18; // 1B total supply. Decimal이 18이기에 1e18 곱해야함.
    // 0으로 시작 -> mint할때마다 증가 & burn할 떄마다 감소

    mapping(address owner => uint amount) public balances;
    // 특수한 경우(매년 토큰의 갯수가 리셋된다면?)
    //  1) Contract를 매년 새로 배포.
    //  2) 단일 Contract로 모든 토큰 관리
    //      mapping(uint year => mapping(address owner => uint amount)) public balances;
    
    mapping(address => mapping(address => uint)) public allowances;
    

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    constructor() {
        balances[msg.sender] = tokenTotalSupply;
    }

    // name, symbol, decimals - 이 3가지는 그냥 변수로 정해서 Solidity가 자동으로
    // getter function 만들어주게 해도 됨.
    function name() public view returns (string memory _name) {
        // In Solidity, when returning a reference type (like string, array, struct, etc.) 
        // from a function, you must explicitly specify its data location (memory or calldata).
        // 어디에 저장할지 명시해야 -> 가스비를 의도한 대로 쓸 수 있음.
        return tokenName;
    }

    function symbol() public view returns (string memory) {
        return tokenSymbol;
    }

    function decimals () public view returns (uint8) {
        return tokenDecimals;
    }

    function totalSupply() public view returns (uint) {
        return tokenTotalSupply;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
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
        // mapping(address => mapping(address => uint)) public allowances; 구조임. 따라서 mapping을 이어서 위와 같이 사용.

        // ERC20의 기본 코드는 allowances[msg.sender][_spender] = _amount;
        // 이는 front-run Attack에 취약.
            // allowance 100 설정 -> allowance 50 덮어쓰기-를 할 때 mempool에서 이를 읽은 spender가 악의를 품고 100을 출금 -> 100 출금이 먼저 실행되고 50 덮어쓰기
            // -> 결과적으로 owner는 allowance를 50으로 수정하고 싶었으나, 100 출금+50 allowance = 150 이 탈취됨.
        // 이는 ERC-20 자체의 취약점.
        // OpenZeppelin에서는 다음과 같이 보안.
            // UI 단에서 기존 allowance값을 먼저 0으로 만드는 TX를 보내고, 그다음 새 값을 설정하는 TX를 보내도록 유도.(단점: 가스비 중복)
            // increaseAllowance, decreaseAllowance 추가 권장함.
            // 그런데 이렇게 해도 결국 CA 단에서 front-run attack를 막을 순 없고, UI 단에서 어떤 함수 호출할지 잘 정해야 되는 거임.
        
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

    function allowance(
        address owner,
        address spender
    ) public view returns (uint) {
        return allowances[owner][spender];
    }
    

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
    1. Error
        (1) 잔액이 충분한가?
        (2) 권한이 있는가? - Spender의 alloawnce >= amount
    2. Data Update
        (1) balances
        (2) allowance
    3. Event
    4. return ture.
7. approve(to, amount): 주체는 owner(msg.sender) - emit Approval
    scan page에서 token approve에 가면 unapprove 가능함.
8. allowance
9. balanceOf

[ERC20 Events]
1. Transfer: 전송 성공
2. Approval: approve 성공*/