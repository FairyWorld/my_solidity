// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
solidity中的继承，包括简单继承，多重继承，以及修饰器（modifier）和构造函数（constructor）的继承。


规则:
is: 用于继承合约
virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
override：子合约重写了父合约中的函数，需要加上override关键字。
- 子合约中函数既需要重写父合约的函数也要给下一个子合约重写, virtual和override都需要加上
- 重写的函数必须保证可见性, 权限, 参数等都一样
- modifier重写和函数重写一样, 在后面加上关键词即可


多重继承:
- solidity的合约可以继承多个合约。
- 继承时要按辈分最高到最低的顺序排。继承的顺序是从到右, 越靠右优先级越高
    - 比如我们写一个Erzi合约，继承Yeye合约和Baba合约，那么就要写成contract Erzi is Yeye, Baba，而不能写成contract Erzi is Baba, Yeye，
- 如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写。 
    - 重写在多个父合约中都重名的函数时，override关键字后面要加上"所有父合约名字"，例如override(Yeye, Baba)。


子合约有两种方法继承父合约的构造函数:
1. 在继承时声明父构造函数的参数，例如：contract B is A(1)
2. 在子合约的构造函数中声明构造函数的参数，例如： constructor(xx) Fa(xx) {}


子合约使用父合约的变量和函数
1. super.xx, 调用继承合约列表中最近的父合约, 最右侧的父合约
2. 父合约名字.xx
*/
contract Yeye {
    event Log(string msg);

    // 定义3个function: hip(), pop(), man()，Log值为Yeye。
    function hip() public virtual {
        emit Log("Yeye");
    }

    function pop() public virtual {
        // emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }
}

contract Baba is Yeye {
    // 继承两个function: hip()和pop()，输出改为Baba。
    function hip() public virtual override {
        emit Log("Baba");
    }

    function pop() public virtual override {
        // emit Log("Baba");
    }

    function baba() public virtual {
        emit Log("Baba");
    }
}

contract Erzi is Yeye, Baba {
    // 继承两个function: hip()和pop()，输出值为Erzi。
    function hip() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }

    function pop() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }
}

// modifier继承--------------------------------------------------------------------------------------------
contract Base1 {
    modifier exactDividedBy2And3(uint256 _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1 {
    modifier exactDividedBy2And3(uint256 _a) override {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }

    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint256 _dividend)
        public
        pure
        exactDividedBy2And3(_dividend)
        returns (uint256, uint256)
    {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint256 _dividend)
        public
        pure
        returns (uint256, uint256)
    {
        uint256 div2 = _dividend / 2;
        uint256 div3 = _dividend / 3;
        return (div2, div3);
    }
}

// 构造函数继承--------------------------------------------------------------------------------------------
// 子合约有两种方法继承父合约的构造函数
// 在继承时声明父构造函数的参数，例如：contract B is A(1)
// 在子合约的构造函数中声明构造函数的参数，例如：
contract A {
    uint256 public a;

    constructor(uint256 _a) {
        a = _a;
    }
}

// 继承方式1
contract B is A(1) {

}

// 继承方式2
contract C is A {
    constructor(uint256 _a) A(_a * _a) {}
}
