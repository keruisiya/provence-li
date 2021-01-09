pragma solidity ^0.4.19;
import './Account.sol';

import "./utils/LibString.sol";
import "./utils/LibInt.sol";

contract Info is Account{
    using LibString for *;
    using LibInt for *;

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
    mapping(string => string) idToProduce;  //用json的格式代替了
    string[] public produceId;
    // string[] public proJson;

    mapping(string => string) idToMilking;
    string[] public milkingId;
    // string[] public milkJson;


    mapping(string => string) idToProcess;
    string[] public processId;
    // string[] public processJson;

    mapping(string => string) idToStoreExpress;
    string[] public storeExpressId;
    // string[] public storeExpressJson;

    mapping(string => string) idToSell;
    string[] public sellId;
    // string[] public sellJson;


    // 数据上链成功事件定义
    // event ProduceDateAdded(string _ID, string _farmsID, string _farmsName, string _farmsAdd, string _cowVar, string _cowSource, string _feedAqu, string _feedName);
    event ProduceDateAdded(string _ID, uint _index);
    // event MilkingDateAdded(string _ID, string _milkingAddrCode, string _milkingUser, string _milkingEnv, string _milkingTime);
    event MilkingDateAdded(string _ID, uint _index);
    // event ProcessDateAdded(string _ID, string _processAddr, string _processName, string _processTime, string _balingAddr, string _balingName, string _equiSkil);
    event ProcessDateAdded(string _ID, uint _index);
    // event StoreExpressDateAdded(string _ID, string _storeAddr, string _storeName, string _storageTime, string _retirTime, string _transName, string _transCode, string _transTime);
    event StoreExpressDateAdded(string _ID, uint _index);
    // event SellDateAdded(string _ID, string _sellCode, string _sellName, string _sellTime, string _sellAddr, string _produDate);
    event SellDateAdded(string _ID, uint _index);

    // 5位补零前置补零
    function _paddingZero(uint _num) public view returns(string){
        string memory _ret;
        uint _temp = _num;
        uint _count = 5;
        while(_temp>=1){
            _temp = _temp/10;
            _count--;
        }
        for (uint i = 1; i<=_count; i++){
            _ret = _ret.concat("0");
        }
        return _ret.concat(_num.toString());

    }

    // 设置生产者信息
    function _setProduceInfo(string _farmsID, string _farmsName, string _farmsAdd, string _cowVar, string _cowSource, string _feedAqu, string _feedName) public {
        // require(PRODUCE.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        ProduceInfo memory produceOne = ProduceInfo(_farmsID, _farmsName, _farmsAdd, _cowVar, _cowSource, _feedAqu, _feedName);
        // id转成字符串添加进去；
        string memory _produceId = _paddingZero(_id);
        produceId.push(_produceId);
        // 数据转成json 加入到 mapping 得idToProduce中
        string memory _temp = proJson2(produceOne);
        idToProduce[_produceId] = _temp;
        // ProduceDateAdded(_produceId, _farmsID, _farmsName, _farmsAdd, _cowVar, _cowSource, _feedAqu, _feedName);
        ProduceDateAdded(_produceId, 1);
    }

    function getProlength() public returns(uint){
        return produceId.length;
    }
    function getProJsonbyID(string _id) public returns(string _json){
        return idToProduce[_id];
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
    function _setMilkingInfo(string _produceId, string _milkingAddrCode, string _milkingUser, string _milkingEnv, string _milkingTime) public {
        // require(MILKING.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        MilkingInfo memory milkOne = MilkingInfo(_milkingAddrCode, _milkingUser, _milkingEnv, _milkingTime);
        // 组合id并加入到数组中；
        string memory _milkId = _paddingZero(_id).concat(_produceId);
        milkingId.push(_milkId);
        // 数据转成json加入到 mapping 得idToMilking中
        string memory _temp = milkJson2(milkOne);
        idToMilking[_milkId] = _temp;
        MilkingDateAdded(_milkId, 1);
    }
    function getMilklength() public returns(uint){
        return milkingId.length;
    }
    function getMilkJsonbyID(string _id) public returns(string _json){
        return idToMilking[_id];
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

    // // 设置加工环节的信息
    function _setProcessInfo(string _milkId, string _processAddr, string _processName, string _processTime, string _balingAddr, string _balingName, string _equiSkil) public {
        // require(PROCESS.equals(addressToIdentity[msg.sender].identity));
        uint _id = _createId();
        ProcessInfo memory processOne = ProcessInfo(_processAddr, _processName, _processTime, _balingAddr, _balingName, _equiSkil);
        // 组合id并加入到数组中
        string memory _processId = _paddingZero(_id).concat(_milkId);
        processId.push(_processId);
        // 上传数据转换成json并加入到 mapping得 idToProcess
        string memory _temp = processJson2(processOne);
        idToProcess[_processId] = _temp;
        ProcessDateAdded(_processId, 1);
    }
    function getProcesslength() public returns(uint){
        return processId.length;
    }
    function getProcessJsonbyID(string _id) public returns(string _json){
        return idToProcess[_id];
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


    // // 设置包装物流环节信息
    function _setStoreExpressInfo(string _commodityId, string _storeAddr, string _storeName, string _storageTime, string _retirTime, string _transName, string _transCode, string _transTime) public {
        // require(STOREEXPRESS.equals(addressToIdentity[msg.sender].identity));
        StoreExpressInfo memory storeExpressOne = StoreExpressInfo(_storeAddr, _storeName, _storageTime, _retirTime, _transName, _transCode, _transTime);
        // 并不需要组合id了，已经是一个完整得商品；直接加入商品数组
        storeExpressId.push(_commodityId);
        string memory _temp = storeExpressJson2(storeExpressOne);
        // 数据转换成json加入到 mapping得 idToStoreExpress
        idToStoreExpress[_commodityId] = _temp; 
        StoreExpressDateAdded(_commodityId, 1);
    }

    function getStoreExpresslength() public returns(uint){
        return storeExpressId.length;
    }
    function getStoreExpressJsonbyID(string _id) public returns(string _json){
        return idToStoreExpress[_id];
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
    
    // // // 设置销售环节信息
    function _setSellInfo(string _commodityId, string _sellCode, string _sellName, string _sellTime, string _sellAddr, string _produDate) public {
        // require(SELL.equals(addressToIdentity[msg.sender].identity));
        SellInfo memory sellOne = SellInfo(_sellCode, _sellName, _sellTime, _sellAddr, _produDate);
        // // 并不需要组合id了，已经是一个完整得商品；直接加入商品数组
        sellId.push(_commodityId);
        string memory _temp = sellJson2(sellOne);
        // 数据转换成json加入到 mapping得 idToSell
        idToSell[_commodityId] = _temp; 
        SellDateAdded(_commodityId, 1);
    }

    function getSelllength() public returns(uint){
        return sellId.length;
    }
    function getSellJsonbyID(string _id) public returns(string _json){
        return idToSell[_id];
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