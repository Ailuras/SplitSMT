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

(declare-sort var958 0)
(declare-sort var3297 0)
(declare-sort var1053 0)
(declare-sort var1537 0)
(declare-sort var2438 0)
(declare-sort var2301 0)
(declare-sort var3152 0)
(declare-sort var3946 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/-514244350 (var958) var1053)
(declare-fun getServiceInterface/-1311863806 (var1053) String)
(declare-fun var1537_forName/-1763490630 (String) ClassObject)
(declare-fun var2438_isDefault/-1009400446 (String) Bool)
(declare-fun var2301_get/1088891777 (var2301 var3152) var3152)
(declare-fun cast-from-String-to-var3152 (String) var3152)
(declare-fun cast-from-var3152-to-var3946 (var3152) var3946)
(declare-const null-var958 var958)
(declare-const null-String String)
(declare-const var958-MOCK_MAP var2301)
(declare-const null-var3946 var3946)
(declare-const var805 var958) ; Statement: r0 := @this: org.apache.dubbo.rpc.support.MockInvoker 
(assert (not (= var805 null-var958)))
(declare-const var446 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var446 null-String)))
(define-const var2323 var1053 (url/-514244350 var805)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2886 String (getServiceInterface/-1311863806 var2323)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var1583 ClassObject (var1537_forName/-1763490630 var2886)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(define-const var930 Bool (var2438_isDefault/-1009400446 var446)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r20 = r4 
(assert (= (ite var930 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1974 String var446) ; Statement: $r20 = r4 
(assert true) ; Non Conditional
(define-const var3169 var2301 var958-MOCK_MAP) ; Statement: $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP> 
(define-const var2770 var3152 (var2301_get/1088891777 var3169 (cast-from-String-to-var3152 var1974))) ; Statement: $r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20) 
(define-const var1417 var3946 (cast-from-var3152-to-var3946 var2770)) ; Statement: $r19 = (org.apache.dubbo.rpc.Invoker) $r6 
 ; Statement: if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert (not (= var1417 null-var3946))) ; Negate: Cond: $r19 == null  
 ; Statement: return $r19 
(check-sat)
; {url/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.common.URL), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var1537_forName/-1763490630=([java.lang.String], java.lang.Class), var2438_isDefault/-1009400446=([java.lang.String], boolean), var2301_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3152=([java.lang.String], java.lang.Object), cast-from-var3152-to-var3946=([java.lang.Object], org.apache.dubbo.rpc.Invoker)}
; {var958=org.apache.dubbo.rpc.support.MockInvoker, var805=r0, var446=r4, var3297=null_type, var1053=org.apache.dubbo.common.URL, var2323=$r1, var2886=$r2, var1537=org.apache.dubbo.common.utils.ReflectUtils, var1583=r3, var2438=org.apache.dubbo.common.utils.ConfigUtils, var930=$z0, var1974=$r20, var2301=java.util.Map, var3169=$r5, var3152=java.lang.Object, var2770=$r6, var3946=org.apache.dubbo.rpc.Invoker, var1417=$r19}
; {org.apache.dubbo.rpc.support.MockInvoker=var958, r0=var805, r4=var446, null_type=var3297, org.apache.dubbo.common.URL=var1053, $r1=var2323, $r2=var2886, org.apache.dubbo.common.utils.ReflectUtils=var1537, r3=var1583, org.apache.dubbo.common.utils.ConfigUtils=var2438, $z0=var930, $r20=var1974, java.util.Map=var2301, $r5=var3169, java.lang.Object=var3152, $r6=var2770, org.apache.dubbo.rpc.Invoker=var3946, $r19=var1417}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.support.MockInvoker;	r4 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4);	if $z0 == 0 goto $r20 = r4;	$r20 = r4;	$r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>;	$r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20);	$r19 = (org.apache.dubbo.rpc.Invoker) $r6;	if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	return $r19
;block_num 4