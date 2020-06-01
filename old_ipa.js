/*
    本作品用于 QuantumultX 和 Surge 之间 js 执行方法的转换
    您只需书写其中任一软件的 js, 然后在您的 js 最【前面】追加上此段 js 即可
    无需担心影响执行问题，具体原理是将 QX 和 Surge 的方法转换为互相可调用的方法
    尚未测试是否支持 import 的方式进行使用，因此暂未 export
    如有问题或您有更好的改进方案，请前往 https://github.com/sazs34/TaskConfig/issues 提交内容，或直接进行 pull request
*/
// #region 固定头部
 let isQuantumultX = $task != undefined; // 判断当前运行环境是否是 qx
let isSurge = $httpClient != undefined; // 判断当前运行环境是否是 surge
//http 请求
 var $task = isQuantumultX ? $task : {};
var $httpClient = isSurge ? $httpClient : {};
//cookie 读写
 var $prefs = isQuantumultX ? $prefs : {};
var $persistentStore = isSurge ? $persistentStore : {};
// 消息通知
 var $notify = isQuantumultX ? $notify : {};
var $notification = isSurge ? $notification : {};
// #endregion 固定头部

 // #region 网络请求专用转换
 if (isQuantumultX) {
    var errorInfo = {
        error: ''
    };
    $httpClient = {
        get: (url, cb) => {
            var urlObj;
            if (typeof (url) == 'string') {
                urlObj = {
                    url: url
                }
            } else {
                urlObj = url;
            }
            $task.fetch(urlObj).then(response => {
                cb(undefined, response, response.body)
            }, reason => {
                errorInfo.error = reason.error;
                cb(errorInfo, response, '')
            })
        },
        post: (url, cb) => {
            var urlObj;
            if (typeof (url) == 'string') {
                urlObj = {
                    url: url
                }
            } else {
                urlObj = url;
            }
            url.method = 'POST';
            $task.fetch(urlObj).then(response => {
                cb(undefined, response, response.body)
            }, reason => {
                errorInfo.error = reason.error;
                cb(errorInfo, response, '')
            })
        }
    }
}
if (isSurge) {
    $task = {
        fetch: url => {
            // 为了兼容 qx 中 fetch 的写法，所以永不 reject
            return new Promise((resolve, reject) => {
                if (url.method == 'POST') {
                    $httpClient.post(url, (error, response, data) => {
                        if (response) {
                            response.body = data;
                            resolve(response, {
                                error: error
                            });
                        } else {
                            resolve(null, {
                                error: error
                            })
                        }
                    })
                } else {
                    $httpClient.get(url, (error, response, data) => {
                        if (response) {
                            response.body = data;
                            resolve(response, {
                                error: error
                            });
                        } else {
                            resolve(null, {
                                error: error
                            })
                        }
                    })
                }
            })

        }
    }
}
// #endregion 网络请求专用转换

 // #region cookie 操作
 if (isQuantumultX) {
    $persistentStore = {
        read: key => {
            return $prefs.valueForKey(key);
        },
        write: (val, key) => {
            return $prefs.setValueForKey(val, key);
        }
    }
}
if (isSurge) {
    $prefs = {
        valueForKey: key => {
            return $persistentStore.read(key);
        },
        setValueForKey: (val, key) => {
            return $persistentStore.write(val, key);
        }
    }
}
// #endregion

// #region 消息通知
 if (isQuantumultX) {
    $notification = {
        post: (title, subTitle, detail) => {
            $notify(title, subTitle, detail);
        }
    }
}
if (isSurge) {
    $notify = function (title, subTitle, detail) {
        $notification.post(title, subTitle, detail);
    }
}
// #endregion

/ *
LangKhach的Old_iPA_Downloader
* /
var url = $ request.url;
var obj = $ request.body;

const api =“ unlimapps”;
const buy =“ buyProduct”;

if（url.indexOf（api）！= -1）{
var appidget = url.match（/ \ d {6，} $ /）;
console.log（“🟢\ n appid：” + appidget）;
$ persistentStore.write（appidget.toString（），“ appid”）;
$ notification.post（'Old_iPA_Dowloader'，'iTunes PC search app and click Get'，'By @LãngKhách'）;
$ done（{body}）;
}
if（url.indexOf（buy）！= -1）{ 
var appid = $ persistentStore.read（“ appid”）;
var body = obj.replace（/ \ d {6，} /，appid）;
console.log（'🟢Old_iPA_Downloader \ nappid：'+ appid）;
$ done（{body}）;
}
