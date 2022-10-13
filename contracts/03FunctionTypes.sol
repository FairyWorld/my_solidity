// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// 关键词顺序: 数据类型 => 存储类型 => 可见性 => 权限 

/*
格式: 
function <function name> (<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]

function：声明函数时的固定用法，想写函数，就要以function关键字开头。

<function name>：函数名。

(<parameter types>)：圆括号里写函数的参数，也就是要输入到函数的变量类型和名字。

{internal|external|public|private}：函数可见性说明符，一共4种。没标明函数类型的，默认internal。

public: 内部外部均可见。(也可用于修饰状态变量，public变量会自动生成 getter函数，用于查询数值).
private: 只能从本合约内部访问，继承的合约也不能用（也可用于修饰状态变量）。
external: 只能从合约外部访问（但是可以用this.f()来调用，f是函数名）
internal: 只能从合约内部访问，继承的合约可以用（也可用于修饰状态变量）。

[pure|view|payable]：
决定函数权限/功能的关键字。
权限关键字是对当前函数的限制, 和函数内部调用的其他函数无关, 即pure内部可以调用具有view权限的函数。
    - 如果是调用其他合约的函数需要注意的是
    - 如果改函数读取到内部的值(是view权限), 那么我们可以使用pure权限的修饰我们的函数
    - 如果该函数修改了内部是值(写权限), 其实最终也会修改我们在自己合约定义的这个合约, 所以我们的函数也要有写权限
        - 'Good good; good.setXX(xx);', 这种在其他合约调用需要写权限
payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入ETH。pure和view的介绍见下一节。

[returns ()]：函数返回的变量类型和名称。是一个列表, 用,分割。
*/

contract FunctionTypes {
    uint256 public number = 0;

    // pure: 不能读取内部变量/函数
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number+1;
    }

    // view: 只能读取不能修改内部变量/函数
    function addView() external view returns(uint256 new_number){
        new_number = number + 1;
    }

    // 默认, internal以及非pure非view非payable(需要gas), 如果每次指明类型就是internal, 但是会有警告。
    // 可以returns查看或者执行number()
    function addInternal() internal{
        number = number + 1;
    }

    // 为了方便调试, 要么手动改为addInternal为external, 要么间接调用addInternal这个internal方法
    // 不能隐式返回, 例如下面我想返回内部的number, 不能改为returns(uint256 number), 而不进行赋值
    function addExternal() external returns(uint256 new_number){
        addInternal();
        new_number = number;
    }

    // payable: 是指可以给合约打钱的函数.
    // 和默认值(非pure非view非payable)不同, 默认值是指消耗汽油, 钱是给矿工和以太坊的, 所以不能打钱(这只value)。
    // payable是在默认值的基础上支持执行函数打钱到合约(设置value), 可以为0 
    function addPayable() external payable returns(uint256 balance){
        balance = address(this).balance;
    }

    /*
    函数返回关键词: return, returns
        - return用在函数体内, 手动指明返回的内容, 比隐式返回优先级高
        - returns用在函数声明, 用于指定函数返回的类型和名字, 名字可省略
    returns如果指定返回的名字, 那么函数初始化就会自动创建该变量并初始化为该类型的默认值
        - 所以第45行的隐式返回不能用, 因为返回的是和内部变量同名的局部变量number, 默认值为0
        - 如果没有使用return关键字(优先级高)显示返回, 那么自动把函数的同名局部变量返回
    returns如果只指定类型, 那么必须使用return返回
    returns如果有多个返回值可以使用解构赋值, (, b, c, ) = fn(), 顺序和个数必须一致, 不需要获取的用空格代替逗号保留
    */ 

    function fnReturn() external pure returns(uint256, uint256, bool boo){
        return (111, 222, true);
    }

    function fnReturn2() external view returns(uint256, bool){
        (uint256 value1, ,bool boo) = this.fnReturn();
        return (value1, boo);
    }


    function f(uint256[] calldata a) external pure returns(uint256[] calldata){
        // a = 10;
        // uint256[] calldata b;
        // b[1] = 10;
        return a;
    }

}