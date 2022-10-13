// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// 控制流程
// 支持三元运算符
// 支持continue（立即进入下一个循环）和break（跳出当前循环）关键字可以使用
contract IfWhileFor {
    // if
    function ifElseTest(uint256 _number) public pure returns (bool) {
        if (_number == 0) {
            return (true);
        } else {
            return (false);
        }
    }

    // for
    function forLoopTest() public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < 10; i++) {
            sum += i;
        }
        return (sum);
    }

    // while
    function whileTest() public pure returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        return (sum);
    }

    // do-while
    function doWhileTest() public pure returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        do {
            sum += i;
            i++;
        } while (i < 10);
        return (sum);
    }

    // 支持三元运算符
    function ternaryTest(uint256 x, uint256 y) public pure returns (uint256) {
        // return the max of x and y
        return x >= y ? x : y;
    }

    // 插入排序 正确版
    function insertionSort0(uint[] memory arr)
        public
        pure
        returns (uint[] memory)
    {
        for (uint i = 1; i < arr.length; i++) {
            // 获取当前值
            uint temp = arr[i];
            // 前一个值的索引
            // uint j = i - 1;
            // 这里不能用i-1, 因为j是无符号整数, j--会越界结果不是-1, 所以不能采用从当前位置开始往前面找比当前值小的位置的后方插入
            // 改为从当前位置开始, 前面的所有都是有序的, 然后我们从这段有序的从前往后找, 找到第一个比当前值大的, 他的前一个位置就是需要插入的位置
            // 或者修改界限
            uint j = i;
            // 条件顺序不要写反, j >= 1在j=0是可以短路, 否则unit 0 - 1会报错
            while ((j >= 1) && (temp < arr[j - 1])) {
                // 数字后移给更小的值留出空间
                // j-1=0时或者不满足条件退出
                arr[j] = arr[j - 1];
                j--;
            }
            // 此时的arr[j]就是比temp更小的值或者j=1, j-1=0, 在这个位置插入temp
            arr[j] = temp;
        }
        return (arr);
    }

    // 插入排序 正确版
    function insertionSort1(uint[] memory a) public pure returns(uint[] memory) {
        // note that uint can not take negative value
        for (uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j=i;
            while( (j >= 1) && (temp < a[j-1])){
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return(a);
    }
}
