/**
 * @作者 田应平
 * @创建时间 2020-05-15 22:58
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/
class Complier{
    constructor(el,vm){
        //判断el是否是一个元素
        this.el = this.isElementNode(el) ? el : document.querySelector(el);
        var fragment = this.nodeFragment(this.el);
        //把节点中的内容进行替换

        //编译模板
        this.compile(fragment);

        //最后把替换好的内容塞到页面中
        this.el.appendChild(fragment);
    }
    isElementNode(node){//判断是不是元素节点
        return node.nodeType === 1;
    }
    //把节点移到内存中
    nodeFragment(node){
        //创建一个文档碎片
        var fragment = document.createDocumentFragment();
        var firstChild;
        while(firstChild = node.firstChild){
            fragment.appendChild(firstChild);
        }
        return fragment;
    }
    //核心的编译方法
    compile(node){//编译内存中的dom节点
        let childNodes = node.childNodes;
        [...childNodes].forEach(child => {
            if(this.isElementNode(child)){
                this.compileElement(child)
            }else{
                this.compileText(child);
            }
        });
    }
    //编译dom元素,即包含v-model的元素
    compileElement(node){
        let attributes = node.attributes;//得到的是数组
        [...attributes].forEach(attr => {
            let {name,value} = attr;
            if(this.isDirective(name)){
                console.info(node);
            }
        });
    }
    //编译的静态的文本,即包含{{}}的文本
    compileText(node){

    }
    isDirective(attrName){
        return attrName.startsWith('v-');
    }
};
class Vue{
    constructor(options){
        this.$el = options.el;
        this.$data = options.data;
        if(this.$el){
            new Complier(this.$el,this);
        }
    }
}