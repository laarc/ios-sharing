var LSSEGetUrl = function() {};

LSSEGetUrl.prototype = {
    run: function(arguments) {
        arguments.completionFunction({"URL": document.URL, "String": document.title});
    },
    finalize: function(arguments) {
        // arguments contains the value the extension provides in [NSExtensionContext completeRequestReturningItems:completion:].
        // In this example, the extension provides a color as a returning item.
        
    }
};

var ExtensionPreprocessingJS = new LSSEGetUrl;
