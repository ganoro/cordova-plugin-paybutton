/*global cordova, module*/

module.exports = {
    greet: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Paybutton", "greet", [name]);
    },
    test: function(chargeParams, successCallback, errorCallback){
    	cordova.exec(successCallback, errorCallback, "Paybutton", "test", [chargeParams]);
    },
    transaction: function(chargeParams, successCallback, errorCallback){
    	cordova.exec(successCallback, errorCallback, "Paybutton", "transaction", [chargeParams]);
    }
};
