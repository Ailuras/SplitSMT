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

(declare-sort var1430 0)
(declare-sort var2124 0)
(declare-sort var3320 0)
(declare-sort var262 0)
(declare-sort var2296 0)
(declare-sort var1708 0)
(declare-sort var90 0)
(declare-sort var2649 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/-514244350 (var1430) var3320)
(declare-fun getServiceInterface/-1311863806 (var3320) String)
(declare-fun var262_forName/-1763490630 (String) ClassObject)
(declare-fun var2296_isDefault/-1009400446 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1708_get/1088891777 (var1708 var90) var90)
(declare-fun cast-from-String-to-var90 (String) var90)
(declare-fun cast-from-var90-to-var2649 (var90) var2649)
(declare-const null-var1430 var1430)
(declare-const null-String String)
(declare-const var1430-MOCK_MAP var1708)
(declare-const null-var2649 var2649)
(declare-const var1737 var1430) ; Statement: r0 := @this: org.apache.dubbo.rpc.support.MockInvoker 
(assert (not (= var1737 null-var1430)))
(declare-const var1103 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var1103 null-String)))
(define-const var621 var3320 (url/-514244350 var1737)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var1952 String (getServiceInterface/-1311863806 var621)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var668 ClassObject (var262_forName/-1763490630 var1952)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(define-const var983 Bool (var2296_isDefault/-1009400446 var1103)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r20 = r4 
(assert (not (= (ite var983 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2678 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2678)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2678!1 String)
(assert (= var2678!1 ""))
(assert true)
(define-const var1546 String (getName/-1958580599 var668)) ; Statement: $r16 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var636 String (append/672562846 var2678!1 var1546)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var2678!2 String)
(assert (= var2678!2 (str.++ var2678!1 var1546)))
(assert true)
(define-const var1340 String (append/672562846 var636 "Mock")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Mock") 
(declare-const var636!1 String)
(assert (= var636!1 (str.++ var636 "Mock")))
(assert true)
(define-const var2414 String (toString/-2075883882 var1340)) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>] 
(assert true) ; Non Conditional
(define-const var3801 var1708 var1430-MOCK_MAP) ; Statement: $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP> 
(define-const var1404 var90 (var1708_get/1088891777 var3801 (cast-from-String-to-var90 var2414))) ; Statement: $r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20) 
(define-const var619 var2649 (cast-from-var90-to-var2649 var1404)) ; Statement: $r19 = (org.apache.dubbo.rpc.Invoker) $r6 
 ; Statement: if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert (not (= var619 null-var2649))) ; Negate: Cond: $r19 == null  
 ; Statement: return $r19 
(check-sat)
; {url/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.common.URL), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var262_forName/-1763490630=([java.lang.String], java.lang.Class), var2296_isDefault/-1009400446=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1708_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var90=([java.lang.String], java.lang.Object), cast-from-var90-to-var2649=([java.lang.Object], org.apache.dubbo.rpc.Invoker)}
; {var1430=org.apache.dubbo.rpc.support.MockInvoker, var1737=r0, var1103=r4, var2124=null_type, var3320=org.apache.dubbo.common.URL, var621=$r1, var1952=$r2, var262=org.apache.dubbo.common.utils.ReflectUtils, var668=r3, var2296=org.apache.dubbo.common.utils.ConfigUtils, var983=$z0, var2678=$r15, var1546=$r16, var636=$r17, var1340=$r18, var2414=$r20, var1708=java.util.Map, var3801=$r5, var90=java.lang.Object, var1404=$r6, var2649=org.apache.dubbo.rpc.Invoker, var619=$r19}
; {org.apache.dubbo.rpc.support.MockInvoker=var1430, r0=var1737, r4=var1103, null_type=var2124, org.apache.dubbo.common.URL=var3320, $r1=var621, $r2=var1952, org.apache.dubbo.common.utils.ReflectUtils=var262, r3=var668, org.apache.dubbo.common.utils.ConfigUtils=var2296, $z0=var983, $r15=var2678, $r16=var1546, $r17=var636, $r18=var1340, $r20=var2414, java.util.Map=var1708, $r5=var3801, java.lang.Object=var90, $r6=var1404, org.apache.dubbo.rpc.Invoker=var2649, $r19=var619}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.support.MockInvoker;	r4 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4);	if $z0 == 0 goto $r20 = r4;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Mock");	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>];	$r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>;	$r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20);	$r19 = (org.apache.dubbo.rpc.Invoker) $r6;	if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	return $r19
;block_num 4