pragma solidity ^0.4.17;

contract Utils {

    // 生成随机，用来取余数得
    uint modulus = 10 ** 16;

    // 判断字符串是否相等
    function isStrEqual(string _str1, string _str2) public pure  returns(bool){
       return keccak256(_str1) == keccak256(_str2);
    }

     //基于当前时间生成一个id；
    function _createId() public view returns(uint){
        uint rand = uint(keccak256(now));
        return rand % modulus;
    }
}