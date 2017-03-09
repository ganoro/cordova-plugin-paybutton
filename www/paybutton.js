/*global cordova, module*/

module.exports = {
    greet: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Paybutton", "greet", [name]);
    },
    transaction: function(chargeParams, successCallback, errorCallback){
    	cordova.exec(successCallback, errorCallback, "Paybutton", "transaction", [chargeParams]);
    }
};
