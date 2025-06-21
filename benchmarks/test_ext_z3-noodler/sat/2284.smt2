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

(declare-sort var2652 0)
(declare-sort var282 0)
(declare-sort var2502 0)
(declare-sort var477 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2652_getExtensionLoader/-514331157 (var2652 ClassObject) var282)
(declare-fun var2502-init () var2502)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var477) String)
(declare-fun cast-from-ClassObject-to-var477 (ClassObject) var477)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2502 String) void)
(declare-const null-var2652 var2652)
(declare-const null-ClassObject ClassObject)
(declare-const null-var282 var282)
(declare-const var1506 var2652) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionAccessor 
(assert (not (= var1506 null-var2652)))
(declare-const var631 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var631 null-ClassObject)))
(define-const var2520 var282 (var2652_getExtensionLoader/-514331157 var1506 var631)) ; Statement: r2 = interfaceinvoke r0.<org.apache.dubbo.common.extension.ExtensionAccessor: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(r1) 
 ; Statement: if r2 != null goto r3 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtensions()>() 
(assert (not (not (= var2520 null-var282)))) ; Negate: Cond: r2 != null  
(define-const var2682 var2502 var2502-init) ; Statement: $r11 = new java.lang.IllegalArgumentException 
(define-const var1013 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1013)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1013!1 String)
(assert (= var1013!1 ""))
(assert true)
(define-const var3107 String (append/672562846 var1013!1 "ExtensionLoader for [")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExtensionLoader for [") 
(declare-const var1013!2 String)
(assert (= var1013!2 (str.++ var1013!1 "ExtensionLoader for [")))
(assert true)
(define-const var2536 String (append/-1031950772 var3107 (cast-from-ClassObject-to-var477 var631))) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3107!1 String)
(assert (str.prefixof var3107 var3107!1))
(assert true)
(define-const var971 String (append/672562846 var2536 "] is not found")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] is not found") 
(declare-const var2536!1 String)
(assert (= var2536!1 (str.++ var2536 "] is not found")))
(assert true)
(define-const var2831 String (toString/-2075883882 var971)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2682 var2831)) ; Statement: specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r16) 

(declare-const var2682!1 var2502)
(declare-const var2831!1 String)
 ; Statement: throw $r11 
(check-sat)
; {var2652_getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), var2502-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var477=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2652=org.apache.dubbo.common.extension.ExtensionAccessor, var1506=r0, var631=r1, var282=org.apache.dubbo.common.extension.ExtensionLoader, var2520=r2, var2502=java.lang.IllegalArgumentException, var2682=$r11, var1013=$r12, var3107=$r13, var477=java.lang.Object, var2536=$r14, var971=$r15, var2831=$r16}
; {org.apache.dubbo.common.extension.ExtensionAccessor=var2652, r0=var1506, r1=var631, org.apache.dubbo.common.extension.ExtensionLoader=var282, r2=var2520, java.lang.IllegalArgumentException=var2502, $r11=var2682, $r12=var1013, $r13=var3107, java.lang.Object=var477, $r14=var2536, $r15=var971, $r16=var2831}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionAccessor;	r1 := @parameter0: java.lang.Class;	r2 = interfaceinvoke r0.<org.apache.dubbo.common.extension.ExtensionAccessor: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(r1);	if r2 != null goto r3 = virtualinvoke r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtensions()>();	$r11 = new java.lang.IllegalArgumentException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExtensionLoader for [");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] is not found");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r16);	throw $r11
;block_num 2