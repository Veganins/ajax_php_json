class Plyta{
    constructor(v1,v2,v3){
        this.tytul=v1;
        this.cena=v2;
        this.nosnik=v3;
    }
}
function buildAjaxData(d1,d2,d3) {
    var searchdata=new Plyta(d1,d2,d3);
    var xhr= new XMLHttpRequest();
    var serverURL="backend.php";
    var objectToSend=JSON.stringify(searchdata);
    console.log(objectToSend)
    var resContener=document.getElementById('results');
    xhr.open('POST',serverURL,true);
    xhr.setRequestHeader('Content-type',"application/x-www-form-url-urlencoded")
    xhr.onreadystatechange=function() {
        if((xhr.status>=200&&xhr.status<400) && xhr.readyState==4){
            var returndata=xhr.responseText;
            
            resContener.innerHTML=returndata;
            
        }
    }
    xhr.send(objectToSend);
}
function chacktitle(t) {
    console.log(t)
    if((t.length>=2)&&(t.length<=40)){
        return true;
    }else{
        return false;
    }
}
function chackData(n) {
    if(n.length==0){
        return false;
    }else{
        for (let x = 0; x < n.length; x++) {
            if((n.charCodeAt(x)>=33)&&(n.charCodeAt(x)<=47)||(n.charCodeAt(x)>=58)&&(n.charCodeAt(x)<=64)||(n.charCodeAt(x)>=91)&&(n.charCodeAt(x)<=96)){
                return false
            }else{
                if((n.charCodeAt(x)>=48)&&(n.charCodeAt(x)<=57)){
                    return false;
                }
            }
        }
        return true;
    }
}
function chackPrice(c) {
    if((c>0)&&(c<3000)){
        return true;
    }else{
        return false;
    }
}

var guzik=document.querySelector("input[type='button']");
guzik.addEventListener('click', function(){
    var tytul=document.getElementById('tytul').value;
    var cena =parseFloat(document.getElementById('cena').value);
    var nosnik=document.getElementById('nosnik').value;
    if(chacktitle(tytul)&&chackData(nosnik)&&chackPrice(cena)){
        buildAjaxData(tytul,cena,nosnik)
    }else{
        alert("niepoprawne lub niekompletne dane")
    }
});