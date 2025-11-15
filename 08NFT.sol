// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract AFK_NFT is ERC721 {
    
    address dev;
    
    constructor() ERC721("Infinite NFY", "8NFT") {
        // 상속받을 떄 부모 constructor를 호출하는 방식.
        
        dev = msg.sender;
        _mint(dev, 1);
        _mint(dev, 9999);
        // _mint(address to, uint256 tokenId)
        // 근데 nft 이름이 string인 경우, 이를 숫자로 바꿔서 저장.
            // 예를 들어 ens는 namehash(이름)의 decimal(10진수) 변환값으로 저장.
    }

    // BaseURI(클라우드주소) + TokenID = TokenURI
    // 다음과 같음 방식. image.AFK.com/nft/1
    // override로 덮어써서 만들어보기.
    function _baseURI() internal view virtual override returns (string memory) {
        return "https://images.AFK.com/nft/";
    }



    // 생성될 때, 자동으로 나에게 TokenId가 1인 NFT가 민팅되도록
    // Openzeppelin ERVC721 검색해서 코드확인.
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol

}
