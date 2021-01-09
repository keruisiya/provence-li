pragma solidity ^0.4.19;

import './Ownable.sol';
import './Utils.sol';

//json库使用不了
// import "./utils/LibString.sol";
// import "./utils/LibInt.sol";

contract Account is Ownable, Utils{
    // using LibString for * ;
    // using LibInt for *;
    // 身份字符串；
    string PRODUCE = 'produce';
    string MILKING = 'milking';
    string PROCESS = 'process';
    string STOREEXPRESS ='storeExpress';
    string SELL = 'sell';
    // 身份设定成功事件
    event identitySetSucc(address _address, string _str); 

    address[] public participateArr;
    // 这两个结构都是 有ber而来
    struct Member{
        // 身份
        string identity;
        // 是否被管理者批准----账户是否有效
        bool isVaild;
        // 是否申请创建----判断
        bool isExist;
        string applyDate;
    }
    // 地址和对应的身份   0x123456 ===> {'produce',false,false,'2020-1-1'} ---为了方便根据地址查询身份的方便
    mapping(address => Member) public addressToIdentity;
    // 给一个账户地址设定一个身份------**这个和后续准入机制有关**

    // 普通账户申请成为参与者---public
    function setIdentity(address _address, string _str, string _date) public {
        // 确认账户没有确认的身份----可能注册一个身份被拒绝，但是还是可以注册另一个身份
        require(!addressToIdentity[_address].isVaild);
        // 如果一个账户从未申请过，加入到participateArr数组中
        if(!addressToIdentity[_address].isExist){
            participateArr.push(_address);
        }
        // 不管账户有没有申请过，更新映射中的消息
        addressToIdentity[_address].identity = _str;
        addressToIdentity[_address].applyDate = _date;
        addressToIdentity[_address].isExist = true;
    }

    // 管理者确认参与者身份，
    function confirmIdentity(address _address) public {
        // 确认账户是否已经申请过；
        require(addressToIdentity[_address].isExist);
        addressToIdentity[_address].isVaild = true;
        // 广播事件
        identitySetSucc(_address, addressToIdentity[_address].identity);
    }

    // 放回参与方地址集合的 数组长度
    function getIdentityArrLength() public view returns(uint){
        return participateArr.length;
    }

    // 判断地址数组中是否存在这个地址的方法 最高效的是用mapping判断
    // 判断是否是参与者的 定义的函数修饰符；`
    modifier onlyparticipate(address _address) {
        require(addressToIdentity[_address].isVaild);
        _;
    }
}