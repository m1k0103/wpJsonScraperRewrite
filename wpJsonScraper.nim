import httpclient
import std/strformat
import strutils
import std/os


proc scrape(base_url: string)= 
    var endpoint = &"{base_url}/wp-json/"
    var client = newHttpClient()

    try:
        var content = client.getContent(endpoint)
        var splitContents = content.split({',', '[', ']', '{', '}'})
        #echo splitContents
        #echo splitContents.len
        var f = open("output.txt", fmAppend)

        for i in splitContents:
            if i.startsWith("\"href\""):
                f.write(i.replace("\"href\":\"", "").replace("\"", "").replace(r"\\/", r"/").replace("\\/", "/"), "\n")
    except:
        echo "error"
    finally:
        client.close()


# Do include the https:// and include the end / please for it to work.
var url = paramStr(1)

scrape(url)

