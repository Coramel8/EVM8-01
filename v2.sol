// Decompiled by library.dedaub.com
// 2025.10.27 08:58 UTC
// Compiled using the solidity compiler version 0.8.20


// Data structures and variables inferred from the use of storage instructions
uint256 _updateMultiplier; // STORAGE[0x395525728d1d6f4af44d273368682dd92b28e7464d750ef3212d3cb7f5959d00]
mapping (uint256 => uint256) _sharesOf; // STORAGE[0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace00]
mapping (address => mapping (address => uint256)) _allowance; // STORAGE[0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace01]
uint256 _totalShares; // STORAGE[0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace02]
string _name; // STORAGE[0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace03]
string _symbol; // STORAGE[0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace04]
mapping (address => uint256) _nonces; // STORAGE[0x5ab42ced628888259c08ac98db1eb0cf702fc1501344311d8b100cd1bfe4bb00]
uint256 _uid; // STORAGE[0x8d25ea8ee309999a79f0af498fbab0e424669497170669bd9e93b81a62babc00]
uint256 _eip712Domain; // STORAGE[0xa16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d100]
uint256 stor_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d101; // STORAGE[0xa16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d101]
string array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102; // STORAGE[0xa16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102]
string array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103; // STORAGE[0xa16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103]
uint64 stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_0_7; // STORAGE[0xf0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00] bytes 0 to 7
bool stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8; // STORAGE[0xf0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00] bytes 8 to 8


// Events
Initialized(uint64);
TransferShares(address, address, uint256);
Transfer(address, address, uint256);
MultiplierUpdated(uint256);
Approval(address, address, uint256);

function 0x10b0(uint256 varg0) private { 
    v0 = 0x54e();
    v1 = 0x21ad(10 ** 18, v0, varg0);
    return v1;
}

function fallback() public payable {  find similar
    revert();
}

function name() public payable {  find similar
    v0 = 0x2ec7(_name.length);
    v1 = new bytes[](v0);
    v2 = v3 = v1.data;
    v4 = 0x2ec7(_name.length);
    if (v4) {
        if (31 < v4) {
            v5 = _name.data;
            while (v3 + v4 > v2) {
                MEM[v2] = STORAGE[v5];
                v5 += 1;
                v2 += 32;
            }
        } else {
            MEM[v3] = _name.length >> 8 << 8;
        }
    }
    v6 = new bytes[](v1.length);
    v7 = 0;
    while (v7 < v1.length) {
        v6[v7] = v1[v7];
        v7 += 32;
    }
    v6[v1.length] = 0;
    return v6;
}

function 0x1ed8(uint256 varg0) private { 
    v0 = 0x54e();
    v1 = 0x21ad(v0, 10 ** 18, varg0);
    return v1;
}

function 0x1f7c() private { 
    v0 = 0x2a2f();
    v1 = 0x2a99();
    MEM[64] += 192;
    return keccak256(0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f, v0, v1, CHAINID(), this);
}

function 0x1f86(uint256 varg0) private { 
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).hasRole(varg0, msg.sender).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(v1, AccessControlUnauthorizedAccount(msg.sender, varg0));
    return ;
}

function 0x1f93(uint256 varg0, address varg1, address varg2) private { 
    if (varg2) {
        if (_sharesOf[varg2] >= varg0) {
            _sharesOf[varg2] = _sharesOf[varg2] - varg0;
        } else {
            v0 = 0x10b0(varg0);
            revert(ERC20InsufficientBalance(varg2, _sharesOf[varg2], v0));
        }
    } else {
        v1 = _SafeAdd(_totalShares, varg0);
        _totalShares = v1;
    }
    if (varg1) {
        _sharesOf[varg1] = _sharesOf[varg1] + varg0;
    } else {
        _totalShares = _totalShares - varg0;
    }
    emit TransferShares(varg2, varg1, varg0);
    v2 = 0x10b0(varg0);
    emit Transfer(varg2, varg1, v2);
    return ;
}

function approve(address spender, uint256 amount) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    0x2431(1, amount, spender, msg.sender);
    return True;
}

function 0x2131(uint256 varg0, uint256 varg1) private { 
    require(address(varg1), ERC20InvalidReceiver(0));
    0x2735(varg0, varg1, 0);
    return ;
}

function 0x216b(uint256 varg0, uint256 varg1) private { 
    require(address(varg1), ERC20InvalidSender(0));
    0x2735(varg0, 0, varg1);
    return ;
}

function 0x21ad(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    v0 = varg1 * varg2;
    v1 = varg2 * varg1 % uint256.max - v0 - (varg2 * varg1 % uint256.max < v0);
    if (0 - v1) {
        require(varg0 > v1, MathOverflowedMulDiv());
        v2 = varg2 * varg1 % varg0;
        v3 = varg0 & 0 - varg0;
        v4 = varg0 / v3;
        v5 = (2 - v4 * ((2 - v4 * ((2 - v4 * (0x2 ^ v4 * 3)) * (0x2 ^ v4 * 3))) * ((2 - v4 * (0x2 ^ v4 * 3)) * (0x2 ^ v4 * 3)))) * ((2 - v4 * ((2 - v4 * (0x2 ^ v4 * 3)) * (0x2 ^ v4 * 3))) * ((2 - v4 * (0x2 ^ v4 * 3)) * (0x2 ^ v4 * 3)));
        return ((v0 - v2) / v3 | (v1 - (v2 > v0)) * (1 + (0 - v3) / v3)) * ((2 - v4 * ((2 - v4 * ((2 - v4 * v5) * v5)) * ((2 - v4 * v5) * v5))) * ((2 - v4 * ((2 - v4 * v5) * v5)) * ((2 - v4 * v5) * v5)));
    } else {
        require(varg0, Panic(18)); // division by zero
        return v0 / varg0;
    }
}

function totalSupply() public payable {  find similar
    v0 = 0x54e();
    v1 = 0x21ad(10 ** 18, v0, _totalShares);
    return v1;
}

function 0x2313(bytes varg0, bytes varg1) private { 
    require(stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8, NotInitializing());
    require(stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8, NotInitializing());
    require(varg1.length <= uint64.max, Panic(65)); // failed memory allocation (too much memory)
    v0 = 0x2ec7(_name.length);
    if (v0 > 31) {
        v1 = v2 = _name.data;
        v1 = v3 = v2 + (varg1.length + 31 >> 5);
        while (v1 < v2 + (v0 + 31 >> 5)) {
            STORAGE[v1] = 0;
            v1 += 1;
        }
    }
    v4 = v5 = 32;
    if (varg1.length > 31 == 1) {
        v6 = v7 = 0;
        v8 = v9 = _name.data;
        while (v6 < varg1.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) {
            STORAGE[v8] = MEM[v4 + varg1];
            v4 += v5;
            v8 = v8 + 1;
            v6 += v5;
        }
        if (varg1.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 < varg1.length) {
            STORAGE[v8] = ~(uint256.max >> (0xf8 & varg1.length << 3)) & MEM[v4 + varg1];
        }
        _name.length = (varg1.length << 1) + 1;
    } else {
        v10 = v11 = 0;
        if (varg1.length) {
            v10 = MEM[varg1.data];
        }
        _name.length = varg1.length << 1 | ~(uint256.max >> (varg1.length << 3)) & v10;
    }
    require(varg0.length <= uint64.max, Panic(65)); // failed memory allocation (too much memory)
    v12 = 0x2ec7(_symbol.length);
    if (v12 > 31) {
        v13 = v14 = _symbol.data;
        v13 = v15 = v14 + (varg0.length + 31 >> 5);
        while (v13 < v14 + (v12 + 31 >> 5)) {
            STORAGE[v13] = 0;
            v13 += 1;
        }
    }
    v16 = v17 = 32;
    if (varg0.length > 31 == 1) {
        v18 = v19 = 0;
        v20 = v21 = _symbol.data;
        while (v18 < varg0.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) {
            STORAGE[v20] = MEM[v16 + varg0];
            v16 += v17;
            v20 = v20 + 1;
            v18 += v17;
        }
        if (varg0.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 < varg0.length) {
            STORAGE[v20] = ~(uint256.max >> (0xf8 & varg0.length << 3)) & MEM[v16 + varg0];
        }
        _symbol.length = (varg0.length << 1) + 1;
    } else {
        v22 = v23 = 0;
        if (varg0.length) {
            v22 = MEM[varg0.data];
        }
        _symbol.length = varg0.length << 1 | ~(uint256.max >> (varg0.length << 3)) & v22;
    }
    return ;
}

function 0x2325(bytes varg0) private { 
    require(stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8, NotInitializing());
    require(stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8, NotInitializing());
    require(varg0.length <= uint64.max, Panic(65)); // failed memory allocation (too much memory)
    v0 = 0x2ec7(array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.length);
    if (v0 > 31) {
        v1 = v2 = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.data;
        v1 = v3 = v2 + (varg0.length + 31 >> 5);
        while (v1 < v2 + (v0 + 31 >> 5)) {
            STORAGE[v1] = 0;
            v1 += 1;
        }
    }
    v4 = v5 = 32;
    if (varg0.length > 31 == 1) {
        v6 = v7 = 0;
        v8 = v9 = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.data;
        while (v6 < varg0.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) {
            STORAGE[v8] = MEM[v4 + varg0];
            v4 += v5;
            v8 = v8 + 1;
            v6 += v5;
        }
        if (varg0.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 < varg0.length) {
            STORAGE[v8] = ~(uint256.max >> (0xf8 & varg0.length << 3)) & MEM[v4 + varg0];
        }
        array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.length = (varg0.length << 1) + 1;
    } else {
        v10 = v11 = 0;
        if (varg0.length) {
            v10 = MEM[varg0.data];
        }
        array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.length = varg0.length << 1 | ~(uint256.max >> (varg0.length << 3)) & v10;
    }
    require(v12.length <= uint64.max, Panic(65)); // failed memory allocation (too much memory)
    v13 = 0x2ec7(array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.length);
    if (v13 > 31) {
        v14 = v15 = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.data;
        v14 = v16 = v15 + 1;
        while (v14 < v15 + (v13 + 31 >> 5)) {
            STORAGE[v14] = 0;
            v14 += 1;
        }
    }
    v17 = v18 = 32;
    if (v12.length > 31 == 1) {
        v19 = v20 = 0;
        v21 = v22 = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.data;
        while (v19 < 0) {
            STORAGE[v21] = MEM[v17 + 49];
            v17 += v18;
            v21 = v21 + 1;
            v19 += v18;
        }
        if (0 < v12.length) {
            STORAGE[v21] = bytes1(MEM[v17 + 49]);
        }
        array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.length = 3;
    } else {
        v23 = v24 = 0;
        if (v12.length) {
            v25 = v12.data;
        }
        array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.length = 0x2 | bytes1(v23);
    }
    _eip712Domain = 0;
    stor_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d101 = 0;
    return ;
}

function 0x235a() private { 
    v0 = 0x2ec7(array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.length);
    v1 = new bytes[](v0);
    v2 = v3 = v1.data;
    v4 = 0x2ec7(array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.length);
    if (!v4) {
        return v1;
    } else if (31 < v4) {
        v5 = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.data;
        while (v3 + v4 > v2) {
            MEM[v2] = STORAGE[v5];
            v5 += 1;
            v2 += 32;
        }
        return v1;
    } else {
        MEM[v3] = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d102.length >> 8 << 8;
        return v1;
    }
}

function 0x2399() private { 
    v0 = 0x2ec7(array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.length);
    v1 = new bytes[](v0);
    v2 = v3 = v1.data;
    v4 = 0x2ec7(array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.length);
    if (!v4) {
        return v1;
    } else if (31 < v4) {
        v5 = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.data;
        while (v3 + v4 > v2) {
            MEM[v2] = STORAGE[v5];
            v5 += 1;
            v2 += 32;
        }
        return v1;
    } else {
        MEM[v3] = array_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d103.length >> 8 << 8;
        return v1;
    }
}

function 0x23d6(uint256 varg0) private { 
    v0 = 0x1f7c();
    return keccak256(6401, v0, varg0);
}

function multiplier() public payable {  find similar
    v0 = 0x54e();
    return v0;
}

function 0x2431(uint256 varg0, uint256 varg1, address varg2, address varg3) private { 
    require(varg3, ERC20InvalidApprover(0));
    require(varg2, ERC20InvalidSpender(0));
    _allowance[varg3][varg2] = varg1;
    if (!varg0) {
        return ;
    } else {
        emit Approval(varg3, varg2, varg1);
        return ;
    }
}

function transferFrom(address sender, address recipient, uint256 amount) public payable {  find similar
    require(msg.data.length - 4 >= 96);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(sender).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(sender));
    v4, /* bool */ v5 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(recipient).gas(msg.gas);
    require(bool(v4), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v5 == bool(v5));
    require(!v5, Blocked(recipient));
    v6, /* bool */ v7 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v6), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v7 == bool(v7));
    require(!v7, Blocked(msg.sender));
    0x2518(amount, msg.sender, sender);
    0x2578(amount, recipient, sender);
    return True;
}

function 0x2518(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    v0 = _allowance[address(varg2)][address(varg1)];
    if (v0 == uint256.max) {
        return ;
    } else {
        require(v0 >= varg0, ERC20InsufficientAllowance(address(varg1), v0, varg0));
        0x2431(0, v0 - varg0, varg1, varg2);
        return ;
    }
}

function 0x2578(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    require(address(varg2), ERC20InvalidSender(0));
    require(address(varg1), ERC20InvalidReceiver(0));
    0x2735(varg0, varg1, varg2);
    return ;
}

function decimals() public payable {  find similar
    return 18;
}

function DOMAIN_SEPARATOR() public payable {  find similar
    v0 = 0x1f7c();
    return v0;
}

function totalShares() public payable {  find similar
    return _totalShares;
}

function 0x2735(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    v0 = 0x1ed8(varg0);
    0x1f93(v0, varg1, varg2);
    return ;
}

function 0x274d(uint256 varg0, uint256 varg1, uint256 varg2) private { 
    require(address(varg2), ERC20InvalidSender(0));
    require(address(varg1), ERC20InvalidReceiver(0));
    0x1f93(varg0, varg1, varg2);
    return ;
}

function 0x3ec41e31(uint256 varg0) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    require(4 + varg0 + (varg0.length << 5) + 32 <= msg.data.length);
    0x1f86(0x3c11d16cbaffd01df69ce1c404f6340ee057498f5f00246190ea54220576a848);
    v0 = v1 = 0;
    while (1) {
        if (v0 >= varg0.length) {
            exit;
        } else {
            require(v0 < varg0.length, Panic(50)); // access an out-of-bounds or negative index of bytesN array or slice
            require((v0 << 5) + varg0.data + 32 - ((v0 << 5) + varg0.data) >= 32);
            require(varg0[v0] == address(varg0[v0]));
            require(v0 < varg0.length, Panic(50)); // access an out-of-bounds or negative index of bytesN array or slice
            require((v0 << 5) + varg0.data + 32 - ((v0 << 5) + varg0.data) >= 32);
            require(varg0[v0] == address(varg0[v0]));
            v2 = _sharesOf[address(varg0[v0])];
            if (address(varg0[v0])) {
                if (_sharesOf[address(varg0[v0])] >= v2) {
                    _sharesOf[address(varg0[v0])] = _sharesOf[address(varg0[v0])] - v2;
                } else {
                    v3 = 0x10b0(v2);
                    revert(ERC20InsufficientBalance(address(varg0[v0]), _sharesOf[address(varg0[v0])], v3));
                }
            } else {
                v4 = _totalShares;
                v5 = _SafeAdd(v4, v2);
                _totalShares = v5;
            }
            if (address(0x0)) {
                _sharesOf[address(0x0)] = _sharesOf[address(0x0)] + v2;
            } else {
                v6 = _totalShares;
                _totalShares = v6 - v2;
            }
            emit TransferShares(address(varg0[v0]), address(0x0), v2);
            v7 = 0x10b0(v2);
            emit Transfer(address(varg0[v0]), address(0x0), v7);
            require(v0 + 1, Panic(17)); // arithmetic overflow or underflow
            v0 += 1;
        }
    }
}

function mint(address to, uint256 amount) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    0x1f86(0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(to).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(to));
    v4, /* bool */ v5 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v4), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v5 == bool(v5));
    require(!v5, Blocked(msg.sender));
    0x2131(amount, to);
}

function 0x2a2f() private { 
    v0 = 0x235a();
    if (!v0.length) {
        if (!_eip712Domain) {
            return 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        } else {
            return _eip712Domain;
        }
    } else {
        v1 = v0.length;
        v2 = v0.data;
        return keccak256(v0);
    }
}

function burn(uint256 amount) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    0x1f86(0x3c11d16cbaffd01df69ce1c404f6340ee057498f5f00246190ea54220576a848);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(msg.sender));
    0x216b(amount, msg.sender);
}

function 0x2a99() private { 
    v0 = 0x2399();
    if (!v0.length) {
        if (!stor_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d101) {
            return 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        } else {
            return stor_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d101;
        }
    } else {
        v1 = v0.length;
        v2 = v0.data;
        return keccak256(v0);
    }
}

function 0x50c09be3() public payable {  find similar
    return address(0x7ba834024816fa5de620def31d03d12e6f20d2f9);
}

function 0x2ec7(uint256 varg0) private { 
    v0 = v1 = varg0 >> 1;
    if (!(varg0 & 0x1)) {
        v0 = v2 = v1 & 0x7f;
    }
    require((varg0 & 0x1) - (v0 < 32), Panic(34)); // access to incorrectly encoded storage byte array
    return v0;
}

function setMetadata(string varg0, string _description) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    require(varg0 <= uint64.max);
    require(4 + varg0 + 31 < msg.data.length);
    require(varg0.length <= uint64.max);
    require(4 + varg0 + varg0.length + 32 <= msg.data.length);
    require(_description <= uint64.max);
    require(4 + _description + 31 < msg.data.length);
    require(_description.length <= uint64.max);
    require(4 + _description + _description.length + 32 <= msg.data.length);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    0x1f86(0x7f5260842512b02356ff92de24be96e7e1aac2e234d9371b076ac2b4cddda61e);
    require(varg0.length <= uint64.max, Panic(65)); // failed memory allocation (too much memory)
    v2 = 0x2ec7(_name.length);
    if (v2 > 31) {
        v3 = v4 = _name.data;
        v3 = v5 = v4 + (varg0.length + 31 >> 5);
        while (v3 < v4 + (v2 + 31 >> 5)) {
            STORAGE[v3] = 0;
            v3 += 1;
        }
    }
    v6 = v7 = 0;
    if (varg0.length > 31 == 1) {
        v8 = v9 = _name.data;
        while (v6 < varg0.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) {
            STORAGE[v8] = varg0[v6];
            v6 += 32;
            v8 = v8 + 1;
            v6 += 32;
        }
        if (varg0.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 < varg0.length) {
            STORAGE[v8] = varg0[v6] & ~(uint256.max >> (varg0.length << 3 & 0xf8));
        }
        _name.length = (varg0.length << 1) + 1;
    } else {
        v10 = v11 = 0;
        if (varg0.length) {
            v10 = varg0[v7];
        }
        _name.length = varg0.length << 1 | ~(uint256.max >> (varg0.length << 3)) & v10;
    }
    require(_description.length <= uint64.max, Panic(65)); // failed memory allocation (too much memory)
    v12 = 0x2ec7(_symbol.length);
    if (v12 > 31) {
        v13 = v14 = _symbol.data;
        v13 = v15 = v14 + (_description.length + 31 >> 5);
        while (v13 < v14 + (v12 + 31 >> 5)) {
            STORAGE[v13] = 0;
            v13 += 1;
        }
    }
    v16 = v17 = 0;
    if (_description.length > 31 == 1) {
        v18 = v19 = _symbol.data;
        while (v16 < _description.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) {
            STORAGE[v18] = _description[v16];
            v16 += 32;
            v18 = v18 + 1;
            v16 += 32;
        }
        if (_description.length & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 < _description.length) {
            STORAGE[v18] = _description[v16] & ~(uint256.max >> (_description.length << 3 & 0xf8));
        }
        _symbol.length = (_description.length << 1) + 1;
    } else {
        v20 = v21 = 0;
        if (_description.length) {
            v20 = _description[v17];
        }
        _symbol.length = _description.length << 1 | ~(uint256.max >> (_description.length << 3)) & v20;
    }
    v22 = new bytes[](varg0.length);
    CALLDATACOPY(v22.data, varg0.data, varg0.length);
    v22[varg0.length] = 0;
    v23 = new bytes[](_description.length);
    v22[0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & varg0.length + 31] = _description.length;
    CALLDATACOPY(v23.data, _description.data, _description.length);
    v23[_description.length] = 0;
    emit 0x30cda629fbac2efa8c01c1732f1dd9cbec41aae6ceae83906fe6c003b3a03c(v22, v23);
}

function mintShares(address _target, uint256 _amount) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    0x1f86(0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(_target).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(_target));
    v4, /* bool */ v5 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v4), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v5 == bool(v5));
    require(!v5, Blocked(msg.sender));
    0x1f93(_amount, _target, 0);
}

function _SafeMul(uint256 varg0, uint256 varg1) private { 
    require((varg1 == varg1 * varg0 / varg0) | !varg0, Panic(17)); // arithmetic overflow or underflow
    return varg1 * varg0;
}

function _SafeAdd(uint256 varg0, uint256 varg1) private { 
    require(varg0 <= varg1 + varg0, Panic(17)); // arithmetic overflow or underflow
    return varg1 + varg0;
}

function sharesToBalance(uint256 shares) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    v0 = 0x10b0(shares);
    return v0;
}

function updateMultiplier(uint256 multiplierNumber) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    0x1f86(0x7158cf42e4a4f01c5456c8d75cdbd375748d45e9db7e812f5bcd18844122b615);
    v2 = 0x54e();
    require(100, Panic(18)); // division by zero
    v3 = v4 = multiplierNumber > v2 / 100;
    if (v4) {
        v5 = _SafeMul(100, v2);
        v3 = multiplierNumber < v5;
    }
    require(v3);
    _updateMultiplier = multiplierNumber;
    emit MultiplierUpdated(multiplierNumber);
}

function transferSharesFrom(address _sender, address _recipient, uint256 _sharesAmount) public payable {  find similar
    require(msg.data.length - 4 >= 96);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(_sender).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(_sender));
    v4, /* bool */ v5 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(_recipient).gas(msg.gas);
    require(bool(v4), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v5 == bool(v5));
    require(!v5, Blocked(_recipient));
    v6, /* bool */ v7 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v6), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v7 == bool(v7));
    require(!v7, Blocked(msg.sender));
    v8 = 0x10b0(_sharesAmount);
    0x2518(v8, msg.sender, _sender);
    0x274d(_sharesAmount, _recipient, _sender);
}

function balanceOf(address account) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    v0 = 0x10b0(_sharesOf[account]);
    return v0;
}

function nonces(address varg0) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    return _nonces[varg0];
}

function 0x812eb8b2(uint256 varg0, bytes varg1, bytes varg2) public payable {  find similar
    require(msg.data.length - 4 >= 96);
    require(varg1 <= uint64.max);
    require(4 + varg1 + 31 < msg.data.length);
    require(varg1.length <= uint64.max);
    require(4 + varg1 + varg1.length + 32 <= msg.data.length);
    require(varg2 <= uint64.max);
    require(4 + varg2 + 31 < msg.data.length);
    require(varg2.length <= uint64.max);
    require(4 + varg2 + varg2.length + 32 <= msg.data.length);
    v0 = stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8;
    v1 = v2 = !v0;
    v1 = v3 = !stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_0_7;
    v4 = v5 = 1 == stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_0_7;
    if (v5) {
        v4 = v6 = !this.code.size;
    }
    v7 = v8 = !v1;
    if (!bool(v1)) {
        v7 = !v4;
    }
    require(!v7, InvalidInitialization());
    stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_0_7 = 1;
    if (!stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8) {
        stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8 = 1;
    }
    v9 = new bytes[](varg1.length);
    CALLDATACOPY(v9.data, varg1.data, varg1.length);
    v9[varg1.length] = 0;
    v10 = new bytes[](varg2.length);
    CALLDATACOPY(v10.data, varg2.data, varg2.length);
    v10[varg2.length] = 0;
    0x2313(v10, v9);
    v11 = new bytes[](varg1.length);
    CALLDATACOPY(v11.data, varg1.data, varg1.length);
    v11[varg1.length] = 0;
    0x2325(v11);
    require(stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8, NotInitializing());
    _uid = varg0;
    if (!stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8) {
        stor_f0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00_8_8 = 0;
        emit Initialized(1);
    }
}

function eip712Domain() public payable {  find similar
    v0 = v1 = !_eip712Domain;
    if (!bool(_eip712Domain)) {
        v0 = v2 = !stor_a16a46d94261c7517cc8ff89f61c0ce93598e3c849801011dee649a6a557d101;
    }
    require(v0, Error('EIP712: Uninitialized'));
    v3 = 0x235a();
    v4 = 0x2399();
    v5 = new bytes[](v3.length);
    v6 = 0;
    while (v6 < v3.length) {
        v5[v6] = v3[v6];
        v6 += 32;
    }
    v5[v3.length] = 0;
    v7 = new bytes[](v4.length);
    v5[v3.length + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0] = v4.length;
    v8 = 0;
    while (v8 < v4.length) {
        v7[v8] = v4[v8];
        v8 += 32;
    }
    v7[v4.length] = 0;
    v9 = new uint256[](0);
    v7[v4.length + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0] = 0;
    v10 = v11 = MEM[64] + 32;
    v12 = v13 = v9.data;
    v14 = v15 = 0;
    while (v14 < 0) {
        MEM[v12] = MEM[v10];
        v10 += 32;
        v12 += 32;
        v14 += 1;
    }
    return bytes1(0xf00000000000000000000000000000000000000000000000000000000000000), v5, v7, CHAINID(), address(this), 0, v9;
}

function burnShares(uint256 amount) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    0x1f86(0x3c11d16cbaffd01df69ce1c404f6340ee057498f5f00246190ea54220576a848);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(msg.sender));
    0x1f93(amount, 0, msg.sender);
}

function transferShares(address _recipient, uint256 _sharesAmount) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(_recipient).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(_recipient));
    v4, /* bool */ v5 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v4), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v5 == bool(v5));
    require(!v5, Blocked(msg.sender));
    0x274d(_sharesAmount, _recipient, msg.sender);
}

function DENOMINATOR() public payable {  find similar
    return 10 ** 18;
}

function symbol() public payable {  find similar
    v0 = 0x2ec7(_symbol.length);
    v1 = new bytes[](v0);
    v2 = v3 = v1.data;
    v4 = 0x2ec7(_symbol.length);
    if (v4) {
        if (31 < v4) {
            v5 = _symbol.data;
            while (v3 + v4 > v2) {
                MEM[v2] = STORAGE[v5];
                v5 += 1;
                v2 += 32;
            }
        } else {
            MEM[v3] = _symbol.length >> 8 << 8;
        }
    }
    v6 = new bytes[](v1.length);
    v7 = 0;
    while (v7 < v1.length) {
        v6[v7] = v1[v7];
        v7 += 32;
    }
    v6[v1.length] = 0;
    return v6;
}

function transfer(address recipient, uint256 amount) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    v0, /* bool */ v1 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).paused().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == bool(v1));
    require(!v1, Paused());
    v2, /* bool */ v3 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(recipient).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    require(!v3, Blocked(recipient));
    v4, /* bool */ v5 = address(0x7ba834024816fa5de620def31d03d12e6f20d2f9).isBlocked(msg.sender).gas(msg.gas);
    require(bool(v4), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v5 == bool(v5));
    require(!v5, Blocked(msg.sender));
    0x2578(amount, recipient, msg.sender);
    return True;
}

function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public payable {  find similar
    require(msg.data.length - 4 >= 224);
    require(block.timestamp <= deadline, ERC2612ExpiredSignature(deadline));
    _nonces[owner] = _nonces[owner] + 1;
    v0 = 0x23d6(keccak256(0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9, owner, spender, value, _nonces[owner], deadline));
    if (s <= 0x7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a0) {
        MEM[MEM[64]] = 0;
        MEM[MEM[64] + 32] = v0;
        MEM[MEM[64] + 64] = v;
        MEM[MEM[64] + 96] = r;
        MEM[MEM[64] + 128] = s;
        v1 = ecrecover(MEM[MEM[64]:MEM[64] + 160 + MEM[64] - MEM[64]], MEM[MEM[64] - 32:MEM[64] - 32 + 32]);
        require(bool(v1), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        v2 = v3 = MEM[MEM[64] - 32];
        if (address(v3)) {
            v2 = v4 = 0;
        } else {
            v2 = v5 = 0;
            v2 = 1;
        }
    } else {
        v2 = v6 = 0;
        v2 = v7 = 3;
    }
    require(v2 <= 3, Panic(33)); // failed convertion to enum type
    if (v2 - 0) {
        require(v2 <= 3, Panic(33)); // failed convertion to enum type
        require(v2 - 1, ECDSAInvalidSignature());
        require(v2 <= 3, Panic(33)); // failed convertion to enum type
        require(v2 - 2, ECDSAInvalidSignatureLength(v2));
        require(v2 <= 3, Panic(33)); // failed convertion to enum type
        require(v2 - 3, ECDSAInvalidSignatureS(v2));
    }
    require(address(v2) == owner, ERC2612InvalidSigner(address(v2), owner));
    0x2431(1, value, spender, owner);
}

function balanceToShares(uint256 balance) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    v0 = 0x1ed8(balance);
    return v0;
}

function allowance(address owner, address spender) public payable {  find similar
    require(msg.data.length - 4 >= 64);
    return _allowance[owner][spender];
}

function uid() public payable {  find similar
    return _uid;
}

function sharesOf(address account) public payable {  find similar
    require(msg.data.length - 4 >= 32);
    return _sharesOf[account];
}

function 0x54e() private { 
    if (0 - _updateMultiplier) {
        return _updateMultiplier;
    } else {
        return 10 ** 18;
    }
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function __function_selector__( function_selector) public payable { 
    MEM[64] = 128;
    require(!msg.value);
    if (msg.data.length >= 4) {
        v0 = function_selector >> 224;
        if (0x5ffe6146 > v0) {
            if (0x3a98ef39 > v0) {
                if (0x1b3ed722 > v0) {
                    if (0x6fdde03 == v0) {
                        name();
                    } else if (0x95ea7b3 == v0) {
                        approve(address,uint256);
                    } else if (0x18160ddd == v0) {
                        totalSupply();
                    }
                } else if (0x1b3ed722 == v0) {
                    multiplier();
                } else if (0x23b872dd == v0) {
                    transferFrom(address,address,uint256);
                } else if (0x313ce567 == v0) {
                    decimals();
                } else {
                    require(0x3644e515 == v0);
                    DOMAIN_SEPARATOR();
                }
            } else if (0x50c09be3 > v0) {
                if (0x3a98ef39 == v0) {
                    totalShares();
                } else if (0x3ec41e31 == v0) {
                    0x3ec41e31();
                } else if (0x40c10f19 == v0) {
                    mint(address,uint256);
                } else {
                    require(0x42966c68 == v0);
                    burn(uint256);
                }
            } else if (0x50c09be3 == v0) {
                0x50c09be3();
            } else if (0x51335b50 == v0) {
                setMetadata(string,string);
            } else if (0x528c198a == v0) {
                mintShares(address,uint256);
            } else {
                require(0x53735f37 == v0);
                sharesToBalance(uint256);
            }
        } else if (0x918f8674 > v0) {
            if (0x812eb8b2 > v0) {
                if (0x5ffe6146 == v0) {
                    updateMultiplier(uint256);
                } else if (0x6d780459 == v0) {
                    transferSharesFrom(address,address,uint256);
                } else if (0x70a08231 == v0) {
                    balanceOf(address);
                } else {
                    require(0x7ecebe00 == v0);
                    nonces(address);
                }
            } else if (0x812eb8b2 == v0) {
                0x812eb8b2();
            } else if (0x84b0196e == v0) {
                eip712Domain();
            } else if (0x853c637d == v0) {
                burnShares(uint256);
            } else {
                require(0x8fcb4e5b == v0);
                transferShares(address,uint256);
            }
        } else if (0xd8ddf18f > v0) {
            if (0x918f8674 == v0) {
                DENOMINATOR();
            } else if (0x95d89b41 == v0) {
                symbol();
            } else if (0xa9059cbb == v0) {
                transfer(address,uint256);
            } else {
                require(0xd505accf == v0);
                permit(address,address,uint256,uint256,uint8,bytes32,bytes32);
            }
        } else if (0xd8ddf18f == v0) {
            balanceToShares(uint256);
        } else if (0xdd62ed3e == v0) {
            allowance(address,address);
        } else if (0xf514ce36 == v0) {
            uid();
        } else {
            require(0xf5eb42dc == v0);
            sharesOf(address);
        }
    }
    fallback();
}
