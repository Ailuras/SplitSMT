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

(declare-sort var1080 0)
(declare-sort var2432 0)
(declare-sort var487 0)
(declare-sort var670 0)
(declare-sort var3663 0)
(declare-sort var669 0)
(declare-sort var600 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var669!class ClassObject)
(declare-fun var1080_get/1088891777 (var1080 var2432) var2432)
(declare-fun cast-from-String-to-var2432 (String) var2432)
(declare-fun cast-from-var2432-to-String (var2432) String)
(declare-fun var670_notEmptyString/1687515918 (String String) void)
(declare-fun var1080_put/1464166817 (var1080 var2432 var2432) var2432)
(declare-fun var1080_remove/-1201052315 (var1080 var2432) var2432)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun var1080_containsValue/-75917476 (var1080 var2432) Bool)
(declare-fun var600_isEquals/882237642 (String String) Bool)
(declare-fun cast-from-var2432-to-__Array__Int__String__ (var2432) (Array Int String))
(declare-const null-var1080 var1080)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var3663 var3663)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3619 var1080) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var3619 null-var1080)))
(declare-const var3120 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var3120 null-ClassObject)))
(define-const var377 var2432 (var1080_get/1088891777 var3619 (cast-from-String-to-var2432 "interface"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var2119 String (cast-from-var2432-to-String var377)) ; Statement: r16 = (java.lang.String) $r1 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var2119 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto (branch) 
(assert (not (= var2119 null-String))) ; Cond: r16 != null 
 ; Statement: if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 
(assert (not (= var2119 null-String))) ; Cond: r16 != null 
;(assert (var670_notEmptyString/1687515918 var2119 "The interface class or name of reference was not found")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found") 

(declare-const var2119!1 String)
(declare-const var2778 String)
(define-const var164 var3663 null-var3663) ; Statement: r18 = null 
 ; Statement: if r2 == null goto (branch) 
(assert (= var3120 null-ClassObject)) ; Cond: r2 == null 
 ; Statement: if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 
(assert (= var164 null-var3663)) ; Cond: r18 == null 
;(assert (var1080_put/1464166817 var3619 (cast-from-String-to-var2432 "interface") (cast-from-String-to-var2432 var2119!1))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16) 

(declare-const var3619!1 var1080)
(declare-const var133 String)
(declare-const var2119!2 String)
;(assert (var1080_remove/-1201052315 var3619!1 (cast-from-String-to-var2432 "interfaceName"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName") 

(declare-const var3619!2 var1080)
(declare-const var3038 String)
;(assert (var1080_remove/-1201052315 var3619!2 (cast-from-String-to-var2432 "interfaceClass"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass") 

(declare-const var3619!3 var1080)
(declare-const var3137 String)
 ; Statement: if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0 
(assert (not (not (= var3120 var669!class)))) ; Negate: Cond: r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;"  
(define-const var2877 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
 ; Statement: goto [?= $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5)] 
(assert true) ; Non Conditional
(define-const var2249 String (String_valueOf/-1973653463 var2877)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5) 
(define-const var3709 Bool (var1080_containsValue/-75917476 var3619!3 (cast-from-String-to-var2432 "generic"))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic") 
 ; Statement: if $z0 == 0 goto $r21 = "false" 
(assert (= (ite var3709 1 0) 0)) ; Cond: $z0 == 0 
(define-const var152 String "false") ; Statement: $r21 = "false" 
(assert true) ; Non Conditional
(define-const var2450 Bool (var600_isEquals/882237642 var152 var2249)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6) 
 ; Statement: if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(assert (not (= (ite var2450 1 0) 0))) ; Cond: $z1 != 0 
(define-const var3665 var2432 (var1080_get/1088891777 var3619!3 (cast-from-String-to-var2432 "registry"))) ; Statement: $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(define-const var881 (Array Int String) (cast-from-var2432-to-__Array__Int__String__ var3665)) ; Statement: $r4 = (java.lang.String[]) $r3 
 ; Statement: if $r4 == null goto return 
(assert (= var881 null-__Array__Int__String__)) ; Cond: $r4 == null 
 ; Statement: return 
(check-sat)
; {var1080_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2432=([java.lang.String], java.lang.Object), cast-from-var2432-to-String=([java.lang.Object], java.lang.String), var670_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), var1080_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), var1080_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), String_valueOf/-1973653463=([boolean], java.lang.String), var1080_containsValue/-75917476=([java.util.Map, java.lang.Object], boolean), var600_isEquals/882237642=([java.lang.String, java.lang.String], boolean), cast-from-var2432-to-__Array__Int__String__=([java.lang.Object], java.lang.String[])}
; {var1080=java.util.Map, var3619=r0, var3120=r2, var2432=java.lang.Object, var377=$r1, var2119=r16, var487=null_type, var670=org.apache.dubbo.common.utils.Assert, var2778="The interface class or name of reference was not found", var3663=org.apache.dubbo.config.annotation.ProvidedBy, var164=r18, var133="interface", var3038="interfaceName", var3137="interfaceClass", var669=org.apache.dubbo.rpc.service.GenericService, var2877=$z5, var2249=$r6, var3709=$z0, var152=$r21, var600=org.apache.dubbo.common.utils.StringUtils, var2450=$z1, var3665=$r3, var881=$r4}
; {java.util.Map=var1080, r0=var3619, r2=var3120, java.lang.Object=var2432, $r1=var377, r16=var2119, null_type=var487, org.apache.dubbo.common.utils.Assert=var670, "The interface class or name of reference was not found"=var2778, org.apache.dubbo.config.annotation.ProvidedBy=var3663, r18=var164, "interface"=var133, "interfaceName"=var3038, "interfaceClass"=var3137, org.apache.dubbo.rpc.service.GenericService=var669, $z5=var2877, $r6=var2249, $z0=var3709, $r21=var152, org.apache.dubbo.common.utils.StringUtils=var600, $z1=var2450, $r3=var3665, $r4=var881}
;seq <java.lang.String: java.lang.String valueOf(boolean)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r2 := @parameter1: java.lang.Class;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	r16 = (java.lang.String) $r1;	if r16 != null goto (branch);	if r16 != null goto (branch);	if r16 != null goto staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r16, "The interface class or name of reference was not found");	r18 = null;	if r2 == null goto (branch);	if r18 == null goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", r16);	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceName");	interfaceinvoke r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("interfaceClass");	if r2 != class "Lorg/apache/dubbo/rpc/service/GenericService;" goto $z5 = 0;	$z5 = 1;	goto [?= $r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5)];	$r6 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>($z5);	$z0 = interfaceinvoke r0.<java.util.Map: boolean containsValue(java.lang.Object)>("generic");	if $z0 == 0 goto $r21 = "false";	$r21 = "false";	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r21, $r6);	if $z1 != 0 goto $r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r3 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r4 = (java.lang.String[]) $r3;	if $r4 == null goto return;	return
;block_num 12