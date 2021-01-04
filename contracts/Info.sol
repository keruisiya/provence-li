pragma solidity ^0.4.19;
import './Account.sol';

import "./utils/LibString.sol";
import "./utils/LibInt.sol";

contract Info is Account{
    using LibString for *;
    using LibInt for *;
    //--------------- 打算的account.sol
    //--------------- 打算的account.sol
    //--------------- 打算的Utils.sol
    //--------------- 打算的Utils.sol

    // 生产商部分数据的上链和获取
    struct ProduceInfo{
        // 养殖场代号id
        string farmsID;
        // 养殖场名称；
        string farmsName;
        // 养殖厂地址；
        string farmsAdd;
        // 奶牛品种；
        string cowVar;
        // 奶牛来源
        string cowSource;
        // 养殖饲料；
        string feedAqu;
        // 饲料喂养人；
        string feedName;
    }
    // 挤奶阶段数据
    struct MilkingInfo {
        // 挤奶地址编号
        string milkingAddrCode;
        // 挤奶员；
        string milkingUser;
        // 挤奶卫生情况
        string milkingEnv;
        // 挤奶时间
        string milkingTime;
    }

    // 加工阶段信息
    struct ProcessInfo {
        // 加工地址代号
        string processAddr;
        // 加工员
        string processName;
        // 加工时间
        string processTime;
        // 包装地址代号
        string balingAddr;
        // 包装员
        string balingName;
        // 加工工艺和设备
        string equiSkil;
    }

    // 存储与物流阶段数据
    struct StoreExpressInfo{
        // 仓库地址代码
        string storeAddr;
        // 仓储操作员
        string storeName;
        // 入库时间
        string storageTime;
        // 出库时间
        string retirTime;
        // 承运人
        string transName;
        // // 运输单号
        string transCode;
        // // 运输时间
        string transTime;
    }
    // 销售部分数据
    struct SellInfo{
        // 销售单号
        string sellCode;
        // 销售员
        string sellName;
        // 销售日期
        string sellTime;
        // 销售地址
        string sellAddr;
        // 保质期
        string produDate;
    }

    // id与对应得 上传溯源信息；
    // 各身份得id数组；
    mapping(uint => string) public idToProduce;  //用json的格式代替了
    string[] public produceId;
    // string[] public proJson;

    mapping(uint => string) public idToMilking;
    string[] public milkingId;
    // string[] public milkJson;


    mapping(uint => string) public idToProcess;
    string[] public processId;
    // string[] public processJson;

    mapping(uint => string) public idToStoreExpress;
    string[] public storeExpressId;
    // string[] public storeExpressJson;

    mapping(uint => string) public idToSell;
    string[] public sellId;
    // string[] public sellJson;


    // 数据上链成功事件定义
    event ProduceDateAdded(uint _ID, string _farmsID, string _farmsName, string _farmsAdd, string _cowVar, string _cowSource, string _feedAqu, string _feedName);
    event MilkingDateAdded(uint _ID, string _milkingAddrCode, string _milkingUser, string _milkingEnv, string _milkingTime);
    event ProcessDateAdded(uint _ID, string _processAddr, string _processName, string _processTime, string _balingAddr, string _balingName, string _equiSkil);
    event StoreExpressDateAdded(uint _ID, string _storeAddr, string _storeName, string _storageTime, string _retirTime, string _transName, string _transCode, string _transTime);
    event SellDateAdded(uint _ID, string _sellCode, string _sellName, string _sellTime, string _sellAddr, string _produDate);

    // 有咩有办法合成一个方法 上传数据得方法
    
    // 设置生产者信息
    function _setProduceInfo(string _farmsID, string _farmsName, string _farmsAdd, string _cowVar, string _cowSource, string _feedAqu, string _feedName) public {
        // require(PRODUCE.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        ProduceInfo memory produceOne = ProduceInfo(_farmsID, _farmsName, _farmsAdd, _cowVar, _cowSource, _feedAqu, _feedName);
        produceId.push(_id.toString());
        // string memory _json = proJson1(produceOne, _id);
        // proJson.push(_json);
        string memory _temp = proJson2(produceOne);
        // 字符串不能作为mapping的键嘛？？？
        // 报错：Accessors for mapping with dynamically-sized keys not yet implemented.
        idToProduce[_id] = _temp;
        //proJson2.push(_json2);
        ProduceDateAdded(_id, _farmsID, _farmsName, _farmsAdd, _cowVar, _cowSource, _feedAqu, _feedName);
    }

    function getProlength() public returns(uint){
        return produceId.length;
    }

    function proJson1(ProduceInfo _self, uint _id) internal returns(string) {
        // 拼接成这样  ： '{"id":"281401138014041","farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}'
        string memory _json = '{';
        _json = _json.concat('"id":','"'.concat(_id.toString(),'"') ,',');
        _json = _json.concat('"farmsID":', '"'.concat(_self.farmsID,'"'),',');
        _json = _json.concat('"farmsName":', '"'.concat(_self.farmsName,'"'),',');
        _json = _json.concat('"farmsAdd":', '"'.concat(_self.farmsAdd,'"'),',');
        _json = _json.concat('"cowVar":', '"'.concat(_self.cowVar,'"'),',');
        _json = _json.concat('"cowSource":', '"'.concat(_self.cowSource,'"'),',');
        _json = _json.concat('"feedAqu":', '"'.concat(_self.feedAqu,'"'),',');
        _json = _json.concat('"feedName":', '"'.concat(_self.feedName,'"'));
        _json = _json = _json.concat('}');
        return _json;
    }

    function proJson2(ProduceInfo _self) internal returns(string){
        // 拼接成这样  ： '{"281401138014041":{"farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}}'
        string memory _json = '{';
        _json = _json.concat('"farmsID":', '"'.concat(_self.farmsID,'"'),',');
        _json = _json.concat('"farmsName":', '"'.concat(_self.farmsName,'"'),',');
        _json = _json.concat('"farmsAdd":', '"'.concat(_self.farmsAdd,'"'),',');
        _json = _json.concat('"cowVar":', '"'.concat(_self.cowVar,'"'),',');
        _json = _json.concat('"cowSource":', '"'.concat(_self.cowSource,'"'),',');
        _json = _json.concat('"feedAqu":', '"'.concat(_self.feedAqu,'"'),',');
        _json = _json.concat('"feedName":', '"'.concat(_self.feedName,'"'));
        _json = _json.concat('}');
        return _json;
    }
    
    // 设置jinai环节信息
    function _setMilkingInfo(string _milkingAddrCode, string _milkingUser, string _milkingEnv, string _milkingTime) public {
        // require(MILKING.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        MilkingInfo memory milkOne = MilkingInfo(_milkingAddrCode, _milkingUser, _milkingEnv, _milkingTime);
        // idToMilking[_id] = milkOne;
        milkingId.push(_id.toString());
        // string memory _json= milkJson1(milkOne, _id);
        // milkJson.push(_json);
        string memory _temp = milkJson2(milkOne);
        idToMilking[_id] = _temp;
        MilkingDateAdded(_id, _milkingAddrCode, _milkingUser, _milkingEnv, _milkingTime);
    }

    function milkJson1(MilkingInfo _self, uint _id) internal returns(string) {
        // 拼接成这样  ： '{"id":"281401138014041","farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}'
        string memory _json = '{';
        _json = _json.concat('"id":','"'.concat(_id.toString(),'"') ,',');
        _json = _json.concat('"milkingAddrCode":', '"'.concat(_self.milkingAddrCode,'"'),',');
        _json = _json.concat('"milkingUser":', '"'.concat(_self.milkingUser,'"'),',');
        _json = _json.concat('"milkingEnv":', '"'.concat(_self.milkingEnv,'"'),',');
        _json = _json.concat('"milkingTime":', '"'.concat(_self.milkingTime,'"'));
        _json = _json = _json.concat('}');
        return _json;
    }

    function milkJson2(MilkingInfo _self) internal returns(string){
        // 拼接成这样  ： '{"281401138014041":{"farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}}'
        string memory _json = '{';
        _json = _json.concat('"milkingAddrCode":', '"'.concat(_self.milkingAddrCode,'"'),',');
        _json = _json.concat('"milkingUser":', '"'.concat(_self.milkingUser,'"'),',');
        _json = _json.concat('"milkingEnv":', '"'.concat(_self.milkingEnv,'"'),',');
        _json = _json.concat('"milkingTime":', '"'.concat(_self.milkingTime,'"'));
        _json = _json.concat('}');
        return _json;
    }

    // 设置加工环节的信息
    function _setProcessInfo(string _processAddr, string _processName, string _processTime, string _balingAddr, string _balingName, string _equiSkil) public {
        // require(PROCESS.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        ProcessInfo memory processOne = ProcessInfo(_processAddr, _processName, _processTime, _balingAddr, _balingName, _equiSkil);
        // idToProcess[_id] = processOne;
        processId.push(_id.toString());
        // string memory _json = processJson1(processOne, _id);
        // processJson.push(_json);
        string memory _temp = processJson2(processOne);
        idToProcess[_id] = _temp;
        ProcessDateAdded(_id, _processAddr, _processName, _processTime, _balingAddr, _balingName, _equiSkil);
    }

    function processJson1(ProcessInfo _self, uint _id) internal returns(string) {
        // 拼接成这样  ： '{"id":"281401138014041","farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}'
        string memory _json = '{';
        _json = _json.concat('"id":','"'.concat(_id.toString(),'"') ,',');
        _json = _json.concat('"processAddr":', '"'.concat(_self.processAddr,'"'),',');
        _json = _json.concat('"processName":', '"'.concat(_self.processName,'"'),',');
        _json = _json.concat('"processTime":', '"'.concat(_self.processTime,'"'),',');
        _json = _json.concat('"balingAddr":', '"'.concat(_self.balingAddr,'"'),',');
        _json = _json.concat('"balingName":', '"'.concat(_self.balingName,'"'),',');
        _json = _json.concat('"equiSkil":', '"'.concat(_self.equiSkil,'"'));
        _json = _json = _json.concat('}');
        return _json;
    }

    function processJson2(ProcessInfo _self) internal returns(string){
        // 拼接成这样  ： '{"281401138014041":{"farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}}'
        string memory _json = '{';
        _json = _json.concat('"processAddr":', '"'.concat(_self.processAddr,'"'),',');
        _json = _json.concat('"processName":', '"'.concat(_self.processName,'"'),',');
        _json = _json.concat('"processTime":', '"'.concat(_self.processTime,'"'),',');
        _json = _json.concat('"balingAddr":', '"'.concat(_self.balingAddr,'"'),',');
        _json = _json.concat('"balingName":', '"'.concat(_self.balingName,'"'),',');
        _json = _json.concat('"equiSkil":', '"'.concat(_self.equiSkil,'"'));
        _json = _json.concat('}');
        return _json;
    }


    // 设置包装物流环节信息
    function _setStoreExpressInfo(string _storeAddr, string _storeName, string _storageTime, string _retirTime, string _transName, string _transCode, string _transTime) public {
        // require(STOREEXPRESS.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        StoreExpressInfo memory storeExpressOne = StoreExpressInfo(_storeAddr, _storeName, _storageTime, _retirTime, _transName, _transCode, _transTime);
        // idToStoreExpress[_id] = storeExpressOne;
        storeExpressId.push(_id.toString());
        // string memory _json = storeExpressJson1(storeExpressOne, _id);
        // storeExpressJson.push(_json);
        string memory _temp = storeExpressJson2(storeExpressOne);
        idToStoreExpress[_id] = _temp; 
        StoreExpressDateAdded(_id, _storeAddr, _storeName, _storageTime, _retirTime, _transName, _transCode, _transTime);
    }
    function storeExpressJson1(StoreExpressInfo _self, uint _id) internal returns(string) {
        // 拼接成这样  ： '{"id":"281401138014041","farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}'
        string memory _json = '{';
        _json = _json.concat('"id":','"'.concat(_id.toString(),'"') ,',');
        _json = _json.concat('"storeAddr":', '"'.concat(_self.storeAddr,'"'),',');
        _json = _json.concat('"storeName":', '"'.concat(_self.storeName,'"'),',');
        _json = _json.concat('"storageTime":', '"'.concat(_self.storageTime,'"'),',');
        _json = _json.concat('"retirTime":', '"'.concat(_self.retirTime,'"'),',');
        _json = _json.concat('"transName":', '"'.concat(_self.transName,'"'),',');
        _json = _json.concat('"transCode":', '"'.concat(_self.transCode,'"'),',');
        _json = _json.concat('"transTime":', '"'.concat(_self.transTime,'"'));
        _json = _json = _json.concat('}');
        return _json;
    }

    function storeExpressJson2(StoreExpressInfo _self) internal returns(string){
        // 拼接成这样  ： '{"281401138014041":{"farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}}'
        string memory _json = '{';
        _json = _json.concat('"storeAddr":', '"'.concat(_self.storeAddr,'"'),',');
        _json = _json.concat('"storeName":', '"'.concat(_self.storeName,'"'),',');
        _json = _json.concat('"storageTime":', '"'.concat(_self.storageTime,'"'),',');
        _json = _json.concat('"retirTime":', '"'.concat(_self.retirTime,'"'),',');
        _json = _json.concat('"transName":', '"'.concat(_self.transName,'"'),',');
        _json = _json.concat('"transCode":', '"'.concat(_self.transCode,'"'),',');
        _json = _json.concat('"transTime":', '"'.concat(_self.transTime,'"'));
        _json = _json.concat('}');
        return _json;
    }
    
    // // 设置销售环节信息
    function _setSellInfo(string _sellCode, string _sellName, string _sellTime, string _sellAddr, string _produDate) public {
        // require(SELL.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        SellInfo memory sellOne = SellInfo(_sellCode, _sellName, _sellTime, _sellAddr, _produDate);
        // idToSell[_id] = sellOne;
        sellId.push(_id.toString());
        // string memory _json = sellJson1(sellOne, _id);
        // sellJson.push(_json);
        string memory _temp = sellJson2(sellOne);
        idToSell[_id] = _temp; 
        SellDateAdded(_id, _sellCode, _sellName, _sellTime, _sellAddr, _produDate);
    }

    function sellJson1(SellInfo _self, uint _id) internal returns(string) {
        // 拼接成这样  ： '{"id":"281401138014041","farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}'
        string memory _json = '{';
        _json = _json.concat('"id":','"'.concat(_id.toString(),'"') ,',');
        _json = _json.concat('"sellCode":', '"'.concat(_self.sellCode,'"'),',');
        _json = _json.concat('"sellName":', '"'.concat(_self.sellName,'"'),',');
        _json = _json.concat('"sellTime":', '"'.concat(_self.sellTime,'"'),',');
        _json = _json.concat('"sellAddr":', '"'.concat(_self.sellAddr,'"'),',');
        _json = _json.concat('"produDate":', '"'.concat(_self.produDate,'"'));
        _json = _json = _json.concat('}');
        return _json;
    }

    function sellJson2(SellInfo _self) internal returns(string){
        // 拼接成这样  ： '{"281401138014041":{"farmsID":"12","farmsName":"fad","farmsAdd":"a","cowVar":"adf","cowSource":"a"}}'
        string memory _json = '{';
        _json = _json.concat('"sellCode":', '"'.concat(_self.sellCode,'"'),',');
        _json = _json.concat('"sellName":', '"'.concat(_self.sellName,'"'),',');
        _json = _json.concat('"sellTime":', '"'.concat(_self.sellTime,'"'),',');
        _json = _json.concat('"sellAddr":', '"'.concat(_self.sellAddr,'"'),',');
        _json = _json.concat('"produDate":', '"'.concat(_self.produDate,'"'));
        _json = _json.concat('}');
        return _json;
    }
    
}