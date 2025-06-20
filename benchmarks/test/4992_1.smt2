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

(declare-sort var2475 0)
(declare-sort var1487 0)
(declare-sort var1154 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun classHolder/1192063995 (var2475) var1487)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun serializeSecurityManager/1192063995 (var2475) var1154)
(declare-fun addToAllowed/-770664525 (var1154 String) void)
(declare-const null-var2475 var2475)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1487 var1487)
(declare-const var981 var2475) ; Statement: r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator 
(assert (not (= var981 null-var2475)))
(declare-const var1392 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var1392 null-ClassObject)))
(define-const var516 var1487 (classHolder/1192063995 var981)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.common.serialization.ClassHolder classHolder> 
 ; Statement: if $r1 == null goto $r16 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert (= var516 null-var1487)) ; Cond: $r1 == null 
(assert true)
(define-const var493 String (getName/-1958580599 var1392)) ; Statement: $r16 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3119 Bool (startsWith/-1785782452 var493 "java.")) ; Statement: $z0 = virtualinvoke $r16.<java.lang.String: boolean startsWith(java.lang.String)>("java.") 
 ; Statement: if $z0 != 0 goto $r17 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.common.utils.SerializeSecurityManager serializeSecurityManager> 
(assert (not (= (ite var3119 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2384 var1154 (serializeSecurityManager/1192063995 var981)) ; Statement: $r17 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.common.utils.SerializeSecurityManager serializeSecurityManager> 
(assert true)
;(assert (addToAllowed/-770664525 var2384 var493)) ; Statement: virtualinvoke $r17.<org.apache.dubbo.common.utils.SerializeSecurityManager: void addToAllowed(java.lang.String)>($r16) 

(declare-const var2384!1 var1154)
(declare-const var493!1 String)
 ; Statement: return 
(check-sat)
; {classHolder/1192063995=([org.apache.dubbo.common.utils.SerializeSecurityConfigurator], org.apache.dubbo.common.serialization.ClassHolder), getName/-1958580599=([java.lang.Class], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), serializeSecurityManager/1192063995=([org.apache.dubbo.common.utils.SerializeSecurityConfigurator], org.apache.dubbo.common.utils.SerializeSecurityManager), addToAllowed/-770664525=([org.apache.dubbo.common.utils.SerializeSecurityManager, java.lang.String], void)}
; {var2475=org.apache.dubbo.common.utils.SerializeSecurityConfigurator, var981=r0, var1392=r2, var1487=org.apache.dubbo.common.serialization.ClassHolder, var516=$r1, var493=$r16, var3119=$z0, var1154=org.apache.dubbo.common.utils.SerializeSecurityManager, var2384=$r17}
; {org.apache.dubbo.common.utils.SerializeSecurityConfigurator=var2475, r0=var981, r2=var1392, org.apache.dubbo.common.serialization.ClassHolder=var1487, $r1=var516, $r16=var493, $z0=var3119, org.apache.dubbo.common.utils.SerializeSecurityManager=var1154, $r17=var2384}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityConfigurator;	r2 := @parameter0: java.lang.Class;	$r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.common.serialization.ClassHolder classHolder>;	if $r1 == null goto $r16 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r16 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$z0 = virtualinvoke $r16.<java.lang.String: boolean startsWith(java.lang.String)>("java.");	if $z0 != 0 goto $r17 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.common.utils.SerializeSecurityManager serializeSecurityManager>;	$r17 = r0.<org.apache.dubbo.common.utils.SerializeSecurityConfigurator: org.apache.dubbo.common.utils.SerializeSecurityManager serializeSecurityManager>;	virtualinvoke $r17.<org.apache.dubbo.common.utils.SerializeSecurityManager: void addToAllowed(java.lang.String)>($r16);	return
;block_num 3