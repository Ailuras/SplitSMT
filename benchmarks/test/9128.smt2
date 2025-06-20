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

(declare-sort var543 0)
(declare-sort var3382 0)
(declare-sort var1362 0)
(declare-sort var3803 0)
(declare-sort var3341 0)
(declare-sort var2846 0)
(declare-sort var2574 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2846!class ClassObject)
(declare-fun var543_get/1088891777 (var543 var3382) var3382)
(declare-fun cast-from-String-to-var3382 (String) var3382)
(declare-fun cast-from-var3382-to-String (var3382) String)
(declare-fun var3803_notEmptyString/1687515918 (String String) void)
(declare-fun var543_put/1464166817 (var543 var3382 var3382) var3382)
(declare-fun var543_remove/-1201052315 (var543 var3382) var3382)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun var543_containsValue/-75917476 (var543 var3382) Bool)
(declare-fun var2574_isEquals/882237642 (String String) Bool)
(declare-fun cast-from-var3382-to-__Array__Int__String__ (var3382) (Array Int String))
(declare-const null-var543 var543)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var3341 var3341)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2968 var543) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var2968 null-var543)))
(declare-const var1434 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var1434 null-ClassObject)))
(define-const var2839 var3382 (var543_get/1088891777 var2968 (cast-from-String-to-var3382 "interface"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var968 String (cast-from-var3382-to-String var2839)) ; Statement: r16 = (java.lang.String) $r1 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var968 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var968 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 
(assert (not (= var968 null-String))) ; Cond: r16 != null 
;(assert (var3803_notEmptyString/1687515918 var968 "The interface class or name of reference was not found")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 

(declare-const var968!1 String)
(declare-const var70 String)
(define-const var17 var3341 null-var3341) ; Statement: r18 = null 
 ; Statement: if r2 == null goto (branch) 
(assert (= var1434 null-ClassObject)) ; Cond: r2 == null 
 ; Statement: if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 
(assert (= var17 null-var3341)) ; Cond: r18 == null 
;(assert (var543_put/1464166817 var2968 (cast-from-String-to-var3382 "interface") (cast-from-String-to-var3382 var968!1))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 

(declare-const var2968!1 var543)
(declare-const var3796 String)
(declare-const var968!2 String)
;(assert (var543_remove/-1201052315 var2968!1 (cast-from-String-to-var3382 "interfaceName"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName") 

(declare-const var2968!2 var543)
(declare-const var2089 String)
;(assert (var543_remove/-1201052315 var2968!2 (cast-from-String-to-var3382 "interfaceClass"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass") 

(declare-const var2968!3 var543)
(declare-const var1384 String)
 ; Statement: if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0 
(assert (not (= var1434 var2846!class))) ; Cond: r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" 
(define-const var1164 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var3932 String (String_valueOf/-1973653463 var1164)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5) 
(define-const var657 Bool (var543_containsValue/-75917476 var2968!3 (cast-from-String-to-var3382 "generic"))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic") 
 ; Statement: if $z0 == 0 goto $r21 = "false" 
(assert (= (ite var657 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1711 String "false") ; Statement: $r21 = "false" 
(assert true) ; Non Conditional
(define-const var356 Bool (var2574_isEquals/882237642 var1711 var3932)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6) 
 ; Statement: if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(assert (not (= (ite var356 1 0) 0))) ; Cond: $z1 != 0 
(define-const var369 var3382 (var543_get/1088891777 var2968!3 (cast-from-String-to-var3382 "registry"))) ; Statement: $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(define-const var714 (Array Int String) (cast-from-var3382-to-__Array__Int__String__ var369)) ; Statement: $r4 = (java.lang.String[]) $r3 
 ; Statement: if $r4 == null goto return 
(assert (= var714 null-__Array__Int__String__)) ; Cond: $r4 == null 
 ; Statement: return 
(check-sat)
; {var543_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3382=([java.lang.String], java.lang.Object), cast-from-var3382-to-String=([java.lang.Object], java.lang.String), var3803_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), var543_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), var543_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), String_valueOf/-1973653463=([boolean], java.lang.String), var543_containsValue/-75917476=([java.util.Map, java.lang.Object], boolean), var2574_isEquals/882237642=([java.lang.String, java.lang.String], boolean), cast-from-var3382-to-__Array__Int__String__=([java.lang.Object], java.lang.String[])}
; {var543=java.util.Map, var2968=r0, var1434=r2, var3382=java.lang.Object, var2839=$r1, var968=r16, var1362=null_type, var3803=org.apache.dubbo.common.utils.Assert, var70="The interface class or name of reference was not found", var3341=org.apache.dubbo.config.annotation.ProvidedBy, var17=r18, var3796="interface", var2089="interfaceName", var1384="interfaceClass", var2846=org.apache.dubbo.rpc.service.GenericService, var1164=$z5, var3932=$r6, var657=$z0, var1711=$r21, var2574=org.apache.dubbo.common.utils.StringUtils, var356=$z1, var369=$r3, var714=$r4}
; {java.util.Map=var543, r0=var2968, r2=var1434, java.lang.Object=var3382, $r1=var2839, r16=var968, null_type=var1362, org.apache.dubbo.common.utils.Assert=var3803, "The interface class or name of reference was not found"=var70, org.apache.dubbo.config.annotation.ProvidedBy=var3341, r18=var17, "interface"=var3796, "interfaceName"=var2089, "interfaceClass"=var1384, org.apache.dubbo.rpc.service.GenericService=var2846, $z5=var1164, $r6=var3932, $z0=var657, $r21=var1711, org.apache.dubbo.common.utils.StringUtils=var2574, $z1=var356, $r3=var369, $r4=var714}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r2 := @parameter1: java.lang.Class;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	r16 = (java.lang.String) $r1;	if r16 != null goto (branch);	if r16 != null goto (branch);	if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	r18 = null;	if r2 == null goto (branch);	if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName");	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass");	if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0;	$z5 = 0;	$r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5);	$z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic");	if $z0 == 0 goto $r21 = "false";	$r21 = "false";	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6);	if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r4 = (java.lang.String[]) $r3;	if $r4 == null goto return;	return
;block_num 12