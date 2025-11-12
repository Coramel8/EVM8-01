// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract ENS {
    mapping(string => address) public names;

    event error(string error);

    function register(string memory _name, address _address) public {
        // memory : 함수가 실행되는 동안에만 임시로 데이터를 저장. 함수가 끝나면 사라짐.
            // 일반 변수보다 가스비 저렴.
        if (names[_name] == address(0)) {
            names[_name] = _address;
            // 입력한 name이 선점되지 않았으면(=address가 0이면/) 해당 name과 address mapping
        } else {
            emit error('not registered');
        }
    }

    // Register, Renew -> 기간 만료됐을 때 0으로 renew
    // price -> eth를 지불해야 등록 가능
        // + string 길이에 따라 가격 차등(짧을수록 비쌈)
    // Registry, Resolvers : 2 Structure 
    //  -> 등록하는 Registry, 저장하는 Resolvers
    // mapping 구조로 address => address
    // namehash: 실제에서는 name을 string이 아닌
    //  -> 해시값으로 저장함.
    // ens 사면 nft 형태로 토큰을 줌. 이걸 어떻게 구현할 것인가.
    //  -> ERC-721

    /*
    [이런 project 조사할 때]
    DOCs에서 먼저 구조를 익힘. 그림들이 중요함.
    그리고 scan에서 CA를 찾아가기.
    read가면 호출할 수 있는 함수들이 쭉 있음. 먼저 확인.
    막히면 contract를 보거나 docs로 가서 다시 확인. or AI찬스
    -> 이런 식으로 뜯고 씹고 하면서 프로젝트 구조를 파악할 수 있음
    
    */
}



