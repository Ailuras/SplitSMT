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

(declare-sort var3414 0)
(declare-sort var1890 0)
(declare-sort var1653 0)
(declare-sort var2132 0)
(declare-sort var331 0)
(declare-sort var796 0)
(declare-sort var3138 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var796!class ClassObject)
(declare-fun var3414_get/1088891777 (var3414 var1890) var1890)
(declare-fun cast-from-String-to-var1890 (String) var1890)
(declare-fun cast-from-var1890-to-String (var1890) String)
(declare-fun var2132_notEmptyString/1687515918 (String String) void)
(declare-fun var3414_put/1464166817 (var3414 var1890 var1890) var1890)
(declare-fun var3414_remove/-1201052315 (var3414 var1890) var1890)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun var3414_containsValue/-75917476 (var3414 var1890) Bool)
(declare-fun String_valueOf/-333372740 (var1890) String)
(declare-fun var3138_isEquals/882237642 (String String) Bool)
(declare-fun cast-from-var1890-to-__Array__Int__String__ (var1890) (Array Int String))
(declare-const null-var3414 var3414)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var331 var331)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var445 var3414) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var445 null-var3414)))
(declare-const var2597 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var2597 null-ClassObject)))
(define-const var424 var1890 (var3414_get/1088891777 var445 (cast-from-String-to-var1890 "interface"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var2968 String (cast-from-var1890-to-String var424)) ; Statement: r16 = (java.lang.String) $r1 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var2968 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var2968 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 
(assert (not (= var2968 null-String))) ; Cond: r16 != null 
;(assert (var2132_notEmptyString/1687515918 var2968 "The interface class or name of reference was not found")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 

(declare-const var2968!1 String)
(declare-const var1269 String)
(define-const var357 var331 null-var331) ; Statement: r18 = null 
 ; Statement: if r2 == null goto (branch) 
(assert (= var2597 null-ClassObject)) ; Cond: r2 == null 
 ; Statement: if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 
(assert (= var357 null-var331)) ; Cond: r18 == null 
;(assert (var3414_put/1464166817 var445 (cast-from-String-to-var1890 "interface") (cast-from-String-to-var1890 var2968!1))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 

(declare-const var445!1 var3414)
(declare-const var2193 String)
(declare-const var2968!2 String)
;(assert (var3414_remove/-1201052315 var445!1 (cast-from-String-to-var1890 "interfaceName"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName") 

(declare-const var445!2 var3414)
(declare-const var969 String)
;(assert (var3414_remove/-1201052315 var445!2 (cast-from-String-to-var1890 "interfaceClass"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass") 

(declare-const var445!3 var3414)
(declare-const var3488 String)
 ; Statement: if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0 
(assert (not (= var2597 var796!class))) ; Cond: r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" 
(define-const var168 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var73 String (String_valueOf/-1973653463 var168)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5) 
(define-const var2972 Bool (var3414_containsValue/-75917476 var445!3 (cast-from-String-to-var1890 "generic"))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic") 
 ; Statement: if $z0 == 0 goto $r21 = "false" 
(assert (not (= (ite var2972 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var52 var1890 (var3414_get/1088891777 var445!3 (cast-from-String-to-var1890 "generic"))) ; Statement: $r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("generic") 
(define-const var541 String (String_valueOf/-333372740 var52)) ; Statement: $r21 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5) 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6)] 
(assert true) ; Non Conditional
(define-const var2535 Bool (var3138_isEquals/882237642 var541 var73)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6) 
 ; Statement: if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(assert (not (= (ite var2535 1 0) 0))) ; Cond: $z1 != 0 
(define-const var635 var1890 (var3414_get/1088891777 var445!3 (cast-from-String-to-var1890 "registry"))) ; Statement: $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(define-const var3920 (Array Int String) (cast-from-var1890-to-__Array__Int__String__ var635)) ; Statement: $r4 = (java.lang.String[]) $r3 
 ; Statement: if $r4 == null goto return 
(assert (= var3920 null-__Array__Int__String__)) ; Cond: $r4 == null 
 ; Statement: return 
(check-sat)
; {var3414_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1890=([java.lang.String], java.lang.Object), cast-from-var1890-to-String=([java.lang.Object], java.lang.String), var2132_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), var3414_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), var3414_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), String_valueOf/-1973653463=([boolean], java.lang.String), var3414_containsValue/-75917476=([java.util.Map, java.lang.Object], boolean), String_valueOf/-333372740=([java.lang.Object], java.lang.String), var3138_isEquals/882237642=([java.lang.String, java.lang.String], boolean), cast-from-var1890-to-__Array__Int__String__=([java.lang.Object], java.lang.String[])}
; {var3414=java.util.Map, var445=r0, var2597=r2, var1890=java.lang.Object, var424=$r1, var2968=r16, var1653=null_type, var2132=org.apache.dubbo.common.utils.Assert, var1269="The interface class or name of reference was not found", var331=org.apache.dubbo.config.annotation.ProvidedBy, var357=r18, var2193="interface", var969="interfaceName", var3488="interfaceClass", var796=org.apache.dubbo.rpc.service.GenericService, var168=$z5, var73=$r6, var2972=$z0, var52=$r5, var541=$r21, var3138=org.apache.dubbo.common.utils.StringUtils, var2535=$z1, var635=$r3, var3920=$r4}
; {java.util.Map=var3414, r0=var445, r2=var2597, java.lang.Object=var1890, $r1=var424, r16=var2968, null_type=var1653, org.apache.dubbo.common.utils.Assert=var2132, "The interface class or name of reference was not found"=var1269, org.apache.dubbo.config.annotation.ProvidedBy=var331, r18=var357, "interface"=var2193, "interfaceName"=var969, "interfaceClass"=var3488, org.apache.dubbo.rpc.service.GenericService=var796, $z5=var168, $r6=var73, $z0=var2972, $r5=var52, $r21=var541, org.apache.dubbo.common.utils.StringUtils=var3138, $z1=var2535, $r3=var635, $r4=var3920}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r2 := @parameter1: java.lang.Class;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	r16 = (java.lang.String) $r1;	if r16 != null goto (branch);	if r16 != null goto (branch);	if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	r18 = null;	if r2 == null goto (branch);	if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName");	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass");	if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0;	$z5 = 0;	$r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5);	$z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic");	if $z0 == 0 goto $r21 = "false";	$r5 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("generic");	$r21 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r5);	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6);	if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r4 = (java.lang.String[]) $r3;	if $r4 == null goto return;	return
;block_num 12