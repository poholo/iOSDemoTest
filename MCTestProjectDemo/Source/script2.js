var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
function base64encode(str) {
    var out, i, len;
    var c1, c2, c3;

    len = str.length;
    i = 0;
    out = "";
    while(i < len) {
        c1 = str.charCodeAt(i++) & 0xff;
        if(i == len)
        {
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt((c1 & 0x3) << 4);
            out += "==";
            break;
        }
        c2 = str.charCodeAt(i++);
        if(i == len)
        {
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
            out += base64EncodeChars.charAt((c2 & 0xF) << 2);
            out += "=";
            break;
        }
        c3 = str.charCodeAt(i++);
        out += base64EncodeChars.charAt(c1 >> 2);
        out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
        out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >>6));
        out += base64EncodeChars.charAt(c3 & 0x3F);
    }
    return out;
}

var base64DecodeChars = new Array(
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
    -1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
    -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);

function base64decode(str) {
    var c1, c2, c3, c4;
    var i, len, out;

    len = str.length;
    i = 0;
    out = "";
    while(i < len) {
        /* c1 */
        do {
            c1 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
        } while(i < len && c1 == -1);
        if(c1 == -1)
            break;

        /* c2 */
        do {
            c2 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
        } while(i < len && c2 == -1);
        if(c2 == -1)
            break;

        out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4));

        /* c3 */
        do {
            c3 = str.charCodeAt(i++) & 0xff;
            if(c3 == 61)
                return out;
            c3 = base64DecodeChars[c3];
        } while(i < len && c3 == -1);
        if(c3 == -1)
            break;

        out += String.fromCharCode(((c2 & 0XF) << 4) | ((c3 & 0x3C) >> 2));

        /* c4 */
        do {
            c4 = str.charCodeAt(i++) & 0xff;
            if(c4 == 61)
                return out;
            c4 = base64DecodeChars[c4];
        } while(i < len && c4 == -1);
        if(c4 == -1)
            break;
        out += String.fromCharCode(((c3 & 0x03) << 6) | c4);
    }
    return out;
}

var self;
function Wideo() {
    self = this;
    if (typeof console != "undefined") {
        self.log = console.log
    } else {
        if (typeof log != "undefined") {
            self.log = log
        }
    }
    self.sniffers = {
        "meipai.com": self.sniffMeiPai,
    }
}
Wideo.prototype = {
    sniff: function (url,isDownload) {
        self.isDownload = isDownload;
        var c = {
            uri: null,
            title: null,
            video_uri: null,
            video_uri_sd: null,
            video_uri_ed: null,
            video_uri_hd720: null,
            video_uri_hd1080: null,
            header: null
        };
        var j = false;
        for (var b in self.sniffers) {
            if (new RegExp(b, "i").test(url)) {
                j = true
            }
        }
        if (!j) {
            log("can't find a sniffer");
            return c;
        }
        if (/youtube.com/i.test(url)) {
            url = url + "&nomobile=1"
        }
        if (/\/v.pps.tv/i.test(url)) {
            url = url.replace("v.pps.tv", "m.pps.tv")
        }
        for (b in self.sniffers) {
            if (new RegExp(b, "i").test(url)) {
                log("found sniffer for " + b);
                //try {
                var a = self.sniffers[b](url);
                if (typeof a == "string") {
                    c.video_uri = a
                } else {
                    if (a.video_uri_sd) c.video_uri_sd = a.video_uri_sd;
                    if (a.video_uri_ed) c.video_uri_ed = a.video_uri_ed;
                    if (a.video_uri_hd720) c.video_uri_hd720 = a.video_uri_hd720;
                    if (a.video_uri) c.video_uri = a.video_uri;
                    if(a.multiple){
                        c.multiple = a.multiple
                    }
                }
                //} catch (err) {
                //    if (window.platform == "test") {
                //        throw err;
                //    }
                //}
                break
            }
        }
        if (platform == 'and')
            return JSON.stringify(c);
        else
            return c;
    },

    getHTML: function (url, headers) {
        if (!headers)
            headers = {
                "User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.20 Safari/537.36"
            };
        log("http get " + url);
        if (platform == "and")
            return getHtmlUrl(url, headers);
        if (platform == "ios") {
            return getHtmlUrl(url, headers);
        }
        if (platform == "test") {
//            importClass(com.waqu.videoscript.Functions);
            return Functions.httpget(url, headers);
        }
    },

    sniffMeiPai: function (url) {
        log("enter sniffMeiPai");
        var b = self.getHTML(url);
        var  result = /data-video="(\w+)"/.exec(b);
        var a = result[1];
        result = a.slice(0,4).split('').reverse().join('');
        meta = parseInt(result,16).toString();
        splt1 = parseInt(meta[0]);
        size1 = parseInt(meta[1]);
        size2 = parseInt(meta[3]);
        payload = a.slice(4);
        first = payload.slice(0,splt1) + payload.slice(splt1+size1);
        splt2 = first.length - meta[2] - size2;
        second = first.slice(0,splt2) + first.slice(splt2+size2);
        return base64decode(second);
    },
};


var platform = "and";


function download(url,plat){
    platform = plat;
    log("enter download, platform is " + platform);
    var f = new Wideo();
    return f.sniff(url,true);
}


function sniff(url, plat) {
    platform = plat;
    log("enter sniff, platform is " + platform);
    var f = new Wideo();
    return f.sniff(url, false);
}
