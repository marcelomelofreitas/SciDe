        ��  ��                  D  4   H T M L   P L U S _ T I S       0         
const Plus = function() {
                        
  function parentModel(el) {
    for(var p = el.parent; p; p = p.parent) {
      //p.style.display;
      if(var dr = p.$model) return dr;
    }
    return null;
  }

  // setup model namespace binding, 'this' is the element
  function Model() 
  {
    var me = this;
    var mo = this.@["model"];
    this.$model = mo? eval(mo) : self.ns; 
    if(!this.$model) throw "Model {" + mo + "} not found!";
  }

  const reIsExpression=/ *[-()+*&:?|=!^"']+ */;
  //const reIsExpression=/ */;
  const reVarName = /[a-zA-Z_][a-zA-Z0-9_]*/;

  // 'changed()' gets called when coll[key] value has changed (updated or removed)
  function setupModelChangeHandler(coll,key,changed) 
  {
    // data change event handler 
    function on_model_change(changedef) { 
      // changedef here is:
      //[0] - symbol, one of #add,#update,#delete,#add-range,#delete-range or #update-range
      //[1] - object or vector, its element(s) was changed;
      //[2] - symbol or string, property name - for objects
      //      or start of changed range (index) in arrays  
      //[3] - end of changed range (index, not inclusive) in arrays  
      switch(changedef[0]) {
        case #update: if( key == changedef[2] ) changed(coll[key]); break; // object-property
        case #delete: if( key == changedef[2] ) changed(undefined); break; // object-property
        case #update-range: if( key >= changedef[2] &&  key < changedef[3] ) changed(coll[key]); break; // vector-index
        case #delete-range: if( key >= changedef[2] &&  key < changedef[3] ) changed(undefined); break; // vector-index
      }
    }  
    // assign it as an observer    
    Object.addObserver.call(coll,on_model_change); // subscribe to collection object changes
  }
  
  // 'added()' gets called for each new element added to coll
  function setupModelExpansionHandler(coll, added) 
  {
    // setup data object change event handler 
    function on_model_change(changedef) { 
      switch(changedef[0]) {
        case #add:        { added(coll,changedef[2]); } break; 
        case #add-range:  { var start = changedef[2]; var end = changedef[3]; for(var i = start; i < end; ++i) added(coll,i); } break; 
      }
    }      
    Object.addObserver.call(coll,on_model_change); // subscribe to collection object changes
  }
  
  // 'changed()' is called when coll.length has changed
  function setupModelLengthChangeHandler(coll, changed) 
  {
    // setup data object change event handler 
    function on_model_change(changedef) { 
      switch(changedef[0]) {
        case #add:    case #add-range:
        case #delete: case #delete-range:  changed(coll.length);  break; 
      }
    }      
    Object.addObserver.call(coll,on_model_change); // subscribe to collection object changes
  }
  
  // 'changed()' is called when coll changes
  function setupCollectionChangeHandler(coll, changed) 
  {
    // setup data object change event handler 
    function on_model_change(changedef) { changed(); }
    Object.addObserver.call(coll,on_model_change); // subscribe to collection object changes
  }
  
  
  // compile expression into function
  function compileExpr(model, expr) { 
    var func = new Function("return " + expr); func.namespace = model; return func; 
  }
  
  function setupTerminalBinding(model,thing,path,isInput,updater) 
  {
    //stdout.printf("STB %s %V\n", path, path.match( reIsExpression ) );
    if( typeof model != #object  && typeof model != #namespace)
      return;      

    if(reIsExpression.test(path)) { // looks like an expression, setup it as data observer
      var parts = path.split(reIsExpression);
      var expr = compileExpr(model,path);
      for( var part in parts) {
        if( part.match(reVarName) ) {
          var (coll,key) = Object.referenceOf(model, part);
          if(!key) continue;
          //stdout.printf("setupTerminalBinding, expr part key %s in coll %V\n", key, coll);    
          if(key == #length) setupModelLengthChangeHandler( coll, function(length) { updater(thing, expr()); } );
          else setupModelChangeHandler( coll, key, function(val) { updater(thing, expr()); } ); 
        }
      }
      updater(thing,expr());
      return;
    }
     
    assert model: "Model is null while binding " + path;
    
    //stdout.printf("STB %V %V\n", model, path );
    
    var (coll,key) = Object.referenceOf(model, path);
    if( !key ) return;
    
    //stdout.printf("setupTerminalBinding: coll=%s key=%v\n", typeof coll, key);    
    
    if( key == #length ) { // special treatment for length computale property
      setupModelLengthChangeHandler( coll, function(length) { updater(thing, length); } );
      updater(thing,coll.length); // intial value
    } 
    else { // subscribe to model change notifications:
      if( isInput ) { // setup DOM change event handler 
        function on_ui_change() { coll[key] = thing.value; return false; } 
        thing.subscribe("change.plus",on_ui_change); // subscribe to the element value change event
      }
      setupModelChangeHandler( coll, key, function(val) { updater(thing,val); } );
      updater(thing,coll[key]); // assign intial value to it;
    }
  }
  
  function valueUpdater(thing,v) { 
    //stdout.println("valueUpdater", thing,v);
    if(!thing.state.focus && v !== undefined) thing.value = v; 
  }
  
  // setup terminal binding on 'this'
  function Terminal() {
    var path = this.@["name"];
    var thing = this; // the DOM thing
    var model = /*this.$model ||*/ parentModel(thing);
    setupTerminalBinding(model,thing,path,thing.tag != #output, valueUpdater ); 
  }
  
  const CLASS_RE = /(.*)\{\{(([-_a-z0-9]+) *\:)? *(.+)\}\}(.*)/i;
  //const CLASS_RE = /(.*)\{\{([-_a-z0-9]+)(\:)+(.+)\}\}(.*)/i;  
  
  function ClassTerminal() {
    var model = this.$model || parentModel(this);
    var thing = this; // the DOM thing
    var classattr = this.@["class"];
    assert model : "model shall exist" ;
    assert classattr : "it should not be empty";
    
    var parts = classattr.match(CLASS_RE);
    
    if( parts[1] /*&& parts[5]*/ )
      this.@["class"] = parts[1] + " " + (parts[5] || "");
    else
      this.@["class"] = undefined;
    
    var expr = parts[4];   // expression
    var cname = parts[3];  // "cls1" if class="{{cls1:expr}}", A case, expr - boolean 
                           // "" if class="{{expr}}"         , B case, expr - string  
    var sname = null;      // class name set by B case expr  
    //stdout.printf("ClassTerminal %V\n", parts); 
    
    function classUpdater(thing,v) {
      thing.post(function() {
        if( cname )            // case A 
          thing.@.toggleClass(cname, v || false);  
        else if( sname != v )  // case B
          thing.@.removeClass(sname); thing.@.addClass(sname = v);  
      }, true);
      //stdout.println("classUpdater", thing, v);            
    }
    setupTerminalBinding(model,thing,expr,false,classUpdater); 
  }
  
  function AttrTerminal(attrname) {
    var model = this.$model || parentModel(this);
    var thing = this; // the DOM thing
    var attrval = this.@[attrname];
    assert model : "model shall exist" ;
    assert attrval : "it should not be empty";

    var prefix = attrval ~/ "{{";
    var expr  = attrval ~% "{{"; // expression part
    var suffix = expr %~ "}}"; // class name
    expr = expr /~ "}}";  // everything in between {{...}}
    //stdout.println("A:", prefix, expr, suffix);
    
    function attrUpdater(thing,v) {
      thing.post(function() {
          thing.@[attrname] = prefix + v + suffix;  
      }, true);
    }
    setupTerminalBinding(model,thing,expr,false,attrUpdater); 
  }
  
  function crackEachExpression(text) // parse iterator expression: each="[index,]item in collection[|extra]"
  {
    const RE = /(([a-z0-9]+)?\,?([a-z0-9]+)?) in ([^|]+)(\|(.+))?/i;  
    var parts = text.match(RE);
    if( !parts ) 
      throw "Unrecognized @each format:" + text;
   
    var nindex = parts[2]; // index var name
    var nitem = parts[3];  // 'item' var name 
    if( !nitem ) 
       (nitem,nindex) = (nindex,nitem);
    var ncoll = parts[4];
    nitem = symbol(nitem);
    if(nindex)
      nindex = symbol(nindex);
    var filter = parts.length > 6? parts[6]:null;
    
    return (ncoll, nitem, nindex, filter);
  }
  
  function eachRecord(rec,filter) { return true; }
  

  function functionFilter(rec,idx,filter) {
    if( filter(rec, idx) ) 
      return true;
    else
      return false;
  }

  function objectFilter(rec,idx,filter) {
    for(var (k,v) in filter) {
      var rv = rec[k];
           if( typeof v == #string ) { if( rv.indexOf(v) < 0 ) return false; }
      else if( typeof v == #function ) { if( !v(rv) ) return false;   }
      else if( rv != v ) return false;
    }
    return true;
  }
  function textFilter(rec,idx,filter) {
    for(var (k,v) in rec) {
      if( typeof v == #string && v.indexOf(filter) < 0 ) return false;
    }
    return true;
  }
  
  function Repeater() {
      var (ncoll, nitem, nindex, filter) = crackEachExpression(this.@["each"]);
      var root = parentModel(this); 
      assert root;
      var isSelect = this.tag == "select";
      var that = this; 
      var thing = isSelect? that.options: that; 
      var template = thing.first; 
      thing.clear();
      
      var renderList; // forward declaration

      var ff = eachRecord; // filter function
      var fs = null;       // filter value

      function rqRenderList() { thing.post(renderList,true); } 
     
      function appendRepeatableItem(cont, coll, idx, val, domItemIdx)
      {
        var domitem = cont[domItemIdx];
        if( domitem && domitem.$model) {
          var elval = domitem.$model[nitem];
          if( elval === val)
            return; // record already bound with the DOM  
          domitem.remove(); 
          Object.removeObserver.call(elval, rqRenderList);
        }
        //stdout.println("appendRepeatableItem", domItemIdx);
        domitem = template.clone();
        var repeatable_root = {};
        repeatable_root[nitem] = val; 
        if(nindex) repeatable_root[nindex] = idx; 
        repeatable_root.prototype = root; // repeatable root is derived from parent root
        domitem.$model = repeatable_root; // repeated element is holding local $model now for its descendannts.
        
        setupModelChangeHandler( coll, idx, 
          function(val) { if(val) repeatable_root[nitem] = val; // this will propagate changes to record content
                          else domitem.remove(); } );
        
        cont.insert(domitem,domItemIdx);
        
        if( ff !== eachRecord && typeof val == #object ) // if something in the record has changed we need to rerender the list
          Object.addObserver.call(val, rqRenderList);
      }
    
      var (rcoll,rkey) = Object.referenceOf(root, ncoll);
      var coll = rcoll[rkey];
                 //eval(ncoll,root);
      assert(coll);
      
      this.$model = coll;
     
      renderList = function () {
        //debug stacktrace;
        var seqNo = 0;
        for(var (k,v) in coll)
          if( ff(v,k,fs) )
            appendRepeatableItem(thing,coll,k,v,seqNo++);
     
        while( thing.length > seqNo ) {
          var domitem = thing.last;
          var elval = domitem.$model[nitem]; 
          domitem.remove(); 
          Object.removeObserver.call(elval, rqRenderList);
        }
        if(isSelect) // after rendering <select> items we need to reset value to match new options
          that.value = that.value;
      }
      
      if( filter ) {
        function updater(thing,val) { 
          fs = val;
          if( fs === null || fs === undefined) ff = eachRecord;
          else if( typeof fs == #function ) ff = functionFilter;
          else if( typeof fs == #object ) ff = objectFilter;
          else if( typeof fs == #string ) ff = textFilter;
          else if( !fs ) throw "Unknown filter " + fs.toString();
          renderList();
        }
        setupTerminalBinding(root,thing,filter,false,updater); 
      }
      else 
        renderList();
        
      // and setup observer for future modifications:
      setupCollectionChangeHandler(coll, rqRenderList ); 
      setupModelChangeHandler(rcoll, rkey, function() { 
         this.$model = coll = rcoll[rkey];  
         rqRenderList();
      } );
  }
  
  function handleEvent(target,name, evt) {
    var model = target.$model || parentModel(target);
    var action = target.attributes[name];
    return eval.call(target,action,model);
  }
  function handleKeyEvent(target, name, evt) {
    var code;   
    switch(name) {
      case "escape": code = Event.VK_ESCAPE; break;
      case "enter":  code = Event.VK_RETURN; break;
      default: return false;
    }
    if( evt.keyCode != code ) 
      return false;
    var model = target.$model || parentModel(target);
    var action = target.attributes[name];
    eval.call(target,action,model);
    return true;
  }
    
  function Click()    { this.subscribe("click", function(evt) { return handleEvent(this,"click",evt) }) }
  function DblClick() { this.subscribe("dblclick", function(evt) { return handleEvent(this,"dblclick",evt) }) }
  
  function Enter()    { this.subscribe("~keydown", function(evt) { return handleKeyEvent(this,"enter", evt) }) }
  function Escape()   { this.subscribe("~keydown", function(evt) { return handleKeyEvent(this,"escape", evt) }) }
  
  function FocusIn()  { this.subscribe("focusin", function(evt) { return handleEvent(this,"focusin",evt); } ) }
  function FocusOut() { this.subscribe("focusout", function(evt) { return handleEvent(this,"focusout",evt); } ) }
  
  function Change()   { this.subscribe("change", function(evt) { return handleEvent(this,"change",evt); } ) }
   
  return {
    Model:Model,
    Terminal:Terminal,
    ClassTerminal:ClassTerminal,
    AttrTerminal: AttrTerminal,
    valAttrTerminal: function() { AttrTerminal.call(this,"value"); },
    hrefAttrTerminal: function() { AttrTerminal.call(this,"href"); },
    srcAttrTerminal: function() { AttrTerminal.call(this,"src"); },
    Repeater:Repeater,
    Click:Click,
    DblClick:DblClick,
    Change:Change,
    Enter:Enter,
    Escape:Escape,
    FocusIn: FocusIn,
    FocusOut: FocusOut,
 };
 
}();


// the @observing decorator
// it gets applied to the function willing to be invoked when some data
// (defined by the path) gets changed
function @observing(func, paths..) {

  assert typeof this == #namespace;
  
  var observeChanges = this[#$observeChanges];
  if (!observeChanges)
  {
    observeChanges = function(obj, onchange, path = "") 
    {
      var typ = typeof obj;
      
      //stdout.println("observing:", path);
      if( obj && (typ == #object || typ == #namespace)) {
        var spath = path? path + "." : "";
        for(var (k,v) in obj)
          observeChanges(v, onchange, spath + k);
      }
      else if( typ == #array ) {
        var spath = path + "[]";
        for(var (k,v) in obj) 
          observeChanges(v, onchange, spath);
      }
      else 
        return;

      function subs(changedef) {
        var spath = path? path + "." : "";
        switch(changedef[0]) {
            case #add:    
            case #update: spath = spath + changedef[2]; observeChanges(obj[changedef[2]], onchange, spath); break;
            case #delete: spath = spath + changedef[2]; break; 
            case #add-range: 
            case #update-range:
            {
              var start = changedef[2], end = changedef[3];
              spath = path + "[]";
              for(var i = start; i < end; ++i)
                observeChanges(obj[i], onchange, spath);
            }
            case #delete-range: spath = path + "[]"; break;
          }
        onchange(obj,changedef,spath);
      }
          
      Object.addObserver.call(obj,subs);
    };
    
    observeChanges.list = [];
    observeChanges.purolator = function(obj,changedef,path) {
      for( var cb in observeChanges.list ) { 
	      //stdout.println(path, cb.path);
        if( path like cb.path ) self.post(cb.func, true);
      }
    }
    this[#$observeChanges] = observeChanges;
    // setup observer on the namespace
    observeChanges(this,observeChanges.purolator);
  }
  
  var onlyChanges = false;
  // subscribe
  for( var path in paths )
    if( path == #changes )
      onlyChanges = true;
    else
      observeChanges.list.push({path:path,func:func});
  // invoke it now (if not only changes requested)
  if(!onlyChanges) 
    self.post(func, true);
    
  return func;
}


// that is an equivalent of jQuery $.extend(deep) method:
function Object.extend(objects..) 
{
  const extend1 = function(reciever,source) {
    var rv;
    for( var (k,v) in source ) {
      if( typeof v == #object && typeof (rv = reciever[k]) == #object )
        extend1(rv,v);
      else
        reciever[k] = v;
    }
  }
  for( var obj in objects )
    extend1(this,obj);
}

  F  4   H T M L   P L U S _ C S S       0         
/* principal handlers */
[model] { aspect:"Plus.Model" url(plus.tis); }
[model] [each] { aspect:"Plus.Repeater"; } /* note repeater shall come first before [model] [name] for <select each="..." name="var"> */
[model] [name] { aspect:"Plus.Terminal"; }
[model] [class*='{{'] { aspect:"Plus.ClassTerminal"; }
[model] [value*='{{'] { aspect:"Plus.valAttrTerminal"; }
[model] [href*='{{'] { aspect:"Plus.hrefAttrTerminal"; }
[model] [src*='{{'] { aspect:"Plus.srcAttrTerminal"; }

/* auxiliary event handlers */
[model] [click] { aspect:"Plus.Click"; }
[model] [dblclick] { aspect:"Plus.DblClick"; }
[model] [change] { aspect:"Plus.Change"; }
[model] [enter] { aspect:"Plus.Enter"; }
[model] [escape] { aspect:"Plus.Escape"; }
[model] [focusin] { aspect:"Plus.FocusIn"; }
[model] [focusout] { aspect:"Plus.FocusOut"; }


  