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

(declare-sort var994 0)
(declare-sort var2029 0)
(declare-sort var1739 0)
(declare-sort var3907 0)
(declare-sort var1576 0)
(declare-sort var1525 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun instance/507655048 (var994) var1739)
(declare-fun var1739_getMetadata/1968437424 (var1739) var3907)
(declare-fun var3907_get/1088891777 (var3907 var1576) var1576)
(declare-fun cast-from-String-to-var1576 (String) var1576)
(declare-fun cast-from-var1576-to-String (var1576) String)
(declare-fun var1525_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var1739_getExtendParam/301965854 (var1739 String) String)
(declare-const null-var994 var994)
(declare-const null-String String)
(declare-const var3919 var994) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var3919 null-var994)))
(declare-const var1474 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1474 null-String)))
(define-const var629 var1739 (instance/507655048 var3919)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance> 
(define-const var325 var3907 (var1739_getMetadata/1968437424 var629)) ; Statement: $r3 = interfaceinvoke $r1.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var477 var1576 (var3907_get/1088891777 var325 (cast-from-String-to-var1576 var1474))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var1772 String (cast-from-var1576-to-String var477)) ; Statement: r5 = (java.lang.String) $r4 
(define-const var2067 Bool (var1525_isNotEmpty/-1251449450 var1772)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance> 
(assert (= (ite var2067 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2211 var1739 (instance/507655048 var3919)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance> 
(define-const var2089 String (var1739_getExtendParam/301965854 var2211 var1474)) ; Statement: $r7 = interfaceinvoke $r6.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getExtendParam(java.lang.String)>(r2) 
 ; Statement: return $r7 
(check-sat)
; {instance/507655048=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.registry.client.ServiceInstance), var1739_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var3907_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1576=([java.lang.String], java.lang.Object), cast-from-var1576-to-String=([java.lang.Object], java.lang.String), var1525_isNotEmpty/-1251449450=([java.lang.String], boolean), var1739_getExtendParam/301965854=([org.apache.dubbo.registry.client.ServiceInstance, java.lang.String], java.lang.String)}
; {var994=org.apache.dubbo.registry.client.InstanceAddressURL, var3919=r0, var1474=r2, var2029=null_type, var1739=org.apache.dubbo.registry.client.ServiceInstance, var629=$r1, var3907=java.util.Map, var325=$r3, var1576=java.lang.Object, var477=$r4, var1772=r5, var1525=org.apache.dubbo.common.utils.StringUtils, var2067=$z0, var2211=$r6, var2089=$r7}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var994, r0=var3919, r2=var1474, null_type=var2029, org.apache.dubbo.registry.client.ServiceInstance=var1739, $r1=var629, java.util.Map=var3907, $r3=var325, java.lang.Object=var1576, $r4=var477, r5=var1772, org.apache.dubbo.common.utils.StringUtils=var1525, $z0=var2067, $r6=var2211, $r7=var2089}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance>;	$r3 = interfaceinvoke $r1.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	r5 = (java.lang.String) $r4;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance>;	$r6 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance>;	$r7 = interfaceinvoke $r6.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getExtendParam(java.lang.String)>(r2);	return $r7
;block_num 2