(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3103 0)
(declare-sort var3907 0)
(declare-sort var1339 0)
(declare-sort var532 0)
(declare-sort var1806 0)
(declare-sort var2567 0)
(declare-sort var2739 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2567!class ClassObject)
(declare-fun var3103_get/1088891777 (var3103 var3907) var3907)
(declare-fun cast-from-String-to-var3907 (String) var3907)
(declare-fun cast-from-var3907-to-String (var3907) String)
(declare-fun var532_notEmptyString/1687515918 (String String) void)
(declare-fun var3103_put/1464166817 (var3103 var3907 var3907) var3907)
(declare-fun var3103_remove/-1201052315 (var3103 var3907) var3907)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun var3103_containsValue/-75917476 (var3103 var3907) Bool)
(declare-fun String_valueOf/-333372740 (var3907) String)
(declare-fun var2739_isEquals/882237642 (String String) Bool)
(declare-fun cast-from-var3907-to-__Array__Int__String__ (var3907) (Array Int String))
(declare-const null-var3103 var3103)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var1806 var1806)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2773 var3103) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var2773 null-var3103)))
(declare-const var791 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var791 null-ClassObject)))
(define-const var1306 var3907 (var3103_get/1088891777 var2773 (cast-from-String-to-var3907 "interface"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var2906 String (cast-from-var3907-to-String var1306)) ; Statement: r16 = (java.lang.String) $r1 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var2906 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var2906 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 
(assert (not (= var2906 null-String))) ; Cond: r16 != null 
;(assert (var532_notEmptyString/1687515918 var2906 "The interface class or name of reference was not found")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 

(declare-const var2906!1 String)
(declare-const var3168 String)
(define-const var3423 var1806 null-var1806) ; Statement: r18 = null 
 ; Statement: if r2 == null goto (branch) 
(assert (= var791 null-ClassObject)) ; Cond: r2 == null 
 ; Statement: if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 
(assert (= var3423 null-var1806)) ; Cond: r18 == null 
;(assert (var3103_put/1464166817 var2773 (cast-from-String-to-var3907 "interface") (cast-from-String-to-var3907 var2906!1))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 

(declare-const var2773!1 var3103)
(declare-const var2479 String)
(declare-const var2906!2 String)
;(assert (var3103_remove/-1201052315 var2773!1 (cast-from-String-to-var3907 "interfaceName"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName") 

(declare-const var2773!2 var3103)
(declare-const var656 String)
;(assert (var3103_remove/-1201052315 var2773!2 (cast-from-String-to-var3907 "interfaceClass"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass") 

(declare-const var2773!3 var3103)
(declare-const var3632 String)
 ; Statement: if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0 
(assert (not (not (= var791 var2567!class)))) ; Negate: Cond: r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;"  
(define-const var1105 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
 ; Statement: goto [?= $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5)] 
(assert true) ; Non Conditional
(define-const var1748 String (String_valueOf/-1973653463 var1105)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5) 
(define-const var3794 Bool (var3103_containsValue/-75917476 var2773!3 (cast-from-String-to-var3907 "generic"))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic") 
 ; Statement: if $z0 == 0 goto $r21 = "false" 
(assert (not (= (ite var3794 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2789 var3907 (var3103_get/1088891777 var2773!3 (cast-from-String-to-var3907 "generic"))) ; Statement: $r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("generic") 
(define-const var2999 String (String_valueOf/-333372740 var2789)) ; Statement: $r21 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5) 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6)] 
(assert true) ; Non Conditional
(define-const var569 Bool (var2739_isEquals/882237642 var2999 var1748)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6) 
 ; Statement: if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(assert (not (= (ite var569 1 0) 0))) ; Cond: $z1 != 0 
(define-const var586 var3907 (var3103_get/1088891777 var2773!3 (cast-from-String-to-var3907 "registry"))) ; Statement: $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(define-const var1066 (Array Int String) (cast-from-var3907-to-__Array__Int__String__ var586)) ; Statement: $r4 = (java.lang.String[]) $r3 
 ; Statement: if $r4 == null goto return 
(assert (= var1066 null-__Array__Int__String__)) ; Cond: $r4 == null 
 ; Statement: return 
(check-sat)
; {var3103_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3907=([java.lang.String], java.lang.Object), cast-from-var3907-to-String=([java.lang.Object], java.lang.String), var532_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), var3103_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), var3103_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), String_valueOf/-1973653463=([boolean], java.lang.String), var3103_containsValue/-75917476=([java.util.Map, java.lang.Object], boolean), String_valueOf/-333372740=([java.lang.Object], java.lang.String), var2739_isEquals/882237642=([java.lang.String, java.lang.String], boolean), cast-from-var3907-to-__Array__Int__String__=([java.lang.Object], java.lang.String[])}
; {var3103=java.util.Map, var2773=r0, var791=r2, var3907=java.lang.Object, var1306=$r1, var2906=r16, var1339=null_type, var532=org.apache.dubbo.common.utils.Assert, var3168="The interface class or name of reference was not found", var1806=org.apache.dubbo.config.annotation.ProvidedBy, var3423=r18, var2479="interface", var656="interfaceName", var3632="interfaceClass", var2567=org.apache.dubbo.rpc.service.GenericService, var1105=$z5, var1748=$r6, var3794=$z0, var2789=$r5, var2999=$r21, var2739=org.apache.dubbo.common.utils.StringUtils, var569=$z1, var586=$r3, var1066=$r4}
; {java.util.Map=var3103, r0=var2773, r2=var791, java.lang.Object=var3907, $r1=var1306, r16=var2906, null_type=var1339, org.apache.dubbo.common.utils.Assert=var532, "The interface class or name of reference was not found"=var3168, org.apache.dubbo.config.annotation.ProvidedBy=var1806, r18=var3423, "interface"=var2479, "interfaceName"=var656, "interfaceClass"=var3632, org.apache.dubbo.rpc.service.GenericService=var2567, $z5=var1105, $r6=var1748, $z0=var3794, $r5=var2789, $r21=var2999, org.apache.dubbo.common.utils.StringUtils=var2739, $z1=var569, $r3=var586, $r4=var1066}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r2 := @parameter1: java.lang.Class;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	r16 = (java.lang.String) $r1;	if r16 != null goto (branch);	if r16 != null goto (branch);	if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	r18 = null;	if r2 == null goto (branch);	if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName");	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass");	if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0;	$z5 = 1;	goto [?= $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5)];	$r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5);	$z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic");	if $z0 == 0 goto $r21 = "false";	$r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("generic");	$r21 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5);	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6);	if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r4 = (java.lang.String[]) $r3;	if $r4 == null goto return;	return
;block_num 12