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

(declare-sort var3568 0)
(declare-sort var108 0)
(declare-sort var1345 0)
(declare-sort var374 0)
(declare-sort var3177 0)
(declare-sort var325 0)
(declare-sort var1429 0)
(declare-sort var359 0)
(declare-sort var3756 0)
(declare-sort var1937 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3177_toJson/-637920053 (var325) String)
(declare-fun cast-from-var374-to-var325 (var374) var325)
(declare-fun var1429_calRevision/2060062488 (String) String)
(declare-fun serviceInstanceRevisionMap/-1558756437 (var3568) var359)
(declare-fun put/-1753019971 (var359 var325 var325) var325)
(declare-fun cast-from-String-to-var325 (String) var325)
(declare-fun cast-from-var325-to-String (var325) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-fun logger/-1558756437 (var3568) var3756)
(declare-fun var1937_isDebugEnabled/-823448366 (var1937) Bool)
(declare-fun cast-from-var3756-to-var1937 (var3756) var1937)
(declare-const null-var3568 var3568)
(declare-const null-String String)
(declare-const null-var1345 var1345)
(declare-const null-var374 var374)
(declare-const var1821 var3568) ; Statement: r3 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var1821 null-var3568)))
(declare-const var506 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var506 null-String)))
(declare-const var3047 var1345) ; Statement: r17 := @parameter1: org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener 
(assert (not (= var3047 null-var1345)))
(declare-const var3039 var374) ; Statement: r0 := @parameter2: java.util.List 
(assert (not (= var3039 null-var374)))
(define-const var55 String (var3177_toJson/-637920053 (cast-from-var374-to-var325 var3039))) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>(r0) 
(define-const var1420 String (var1429_calRevision/2060062488 var55)) ; Statement: r2 = staticinvoke <org.apache.dubbo.metadata.RevisionResolver: java.lang.String calRevision(java.lang.String)>($r1) 
(define-const var1497 var359 (serviceInstanceRevisionMap/-1558756437 var1821)) ; Statement: $r5 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap serviceInstanceRevisionMap> 
(assert true)
(define-const var2593 var325 (put/-1753019971 var1497 (cast-from-String-to-var325 var506) (cast-from-String-to-var325 var1420))) ; Statement: $r6 = virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r4, r2) 
(define-const var741 String (cast-from-var325-to-String var2593)) ; Statement: $r7 = (java.lang.String) $r6 
(assert true)
(define-const var3497 Bool (equalsIgnoreCase/-92311102 var1420 var741)) ; Statement: $z0 = virtualinvoke r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r7) 
 ; Statement: if $z0 != 0 goto $z5 = 0 
(assert (not (= (ite var3497 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3802 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(define-const var1871 Bool (ite (= 1 0) true false)) ; Statement: $z4 = 0 
(assert true) ; Non Conditional
(define-const var1865 Bool var3802) ; Statement: z1 = $z5 
(define-const var795 var3756 (logger/-1558756437 var1821)) ; Statement: $r8 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1971 Bool (var1937_isDebugEnabled/-823448366 (cast-from-var3756-to-var1937 var795))) ; Statement: $z2 = interfaceinvoke $r8.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z2 == 0 goto (branch) 
(assert (= (ite var1971 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: if z1 == 0 goto return 
(assert (= (ite var1865 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: return 
(check-sat)
; {var3177_toJson/-637920053=([java.lang.Object], java.lang.String), cast-from-var374-to-var325=([java.util.List], java.lang.Object), var1429_calRevision/2060062488=([java.lang.String], java.lang.String), serviceInstanceRevisionMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), put/-1753019971=([java.util.concurrent.ConcurrentHashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var325=([java.lang.String], java.lang.Object), cast-from-var325-to-String=([java.lang.Object], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean), logger/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var1937_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var3756-to-var1937=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var3568=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var1821=r3, var506=r4, var108=null_type, var1345=org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener, var3047=r17, var374=java.util.List, var3039=r0, var3177=org.apache.dubbo.common.utils.JsonUtils, var325=java.lang.Object, var55=$r1, var1429=org.apache.dubbo.metadata.RevisionResolver, var1420=r2, var359=java.util.concurrent.ConcurrentHashMap, var1497=$r5, var2593=$r6, var741=$r7, var3497=$z0, var3802=$z5, var1871=$z4, var1865=z1, var3756=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var795=$r8, var1937=org.apache.dubbo.common.logger.Logger, var1971=$z2}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var3568, r3=var1821, r4=var506, null_type=var108, org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener=var1345, r17=var3047, java.util.List=var374, r0=var3039, org.apache.dubbo.common.utils.JsonUtils=var3177, java.lang.Object=var325, $r1=var55, org.apache.dubbo.metadata.RevisionResolver=var1429, r2=var1420, java.util.concurrent.ConcurrentHashMap=var359, $r5=var1497, $r6=var2593, $r7=var741, $z0=var3497, $z5=var3802, $z4=var1871, z1=var1865, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3756, $r8=var795, org.apache.dubbo.common.logger.Logger=var1937, $z2=var1971}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r4 := @parameter0: java.lang.String;	r17 := @parameter1: org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener;	r0 := @parameter2: java.util.List;	$r1 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>(r0);	r2 = staticinvoke <org.apache.dubbo.metadata.RevisionResolver: java.lang.String calRevision(java.lang.String)>($r1);	$r5 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap serviceInstanceRevisionMap>;	$r6 = virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r4, r2);	$r7 = (java.lang.String) $r6;	$z0 = virtualinvoke r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r7);	if $z0 != 0 goto $z5 = 0;	$z5 = 0;	$z4 = 0;	z1 = $z5;	$r8 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z2 = interfaceinvoke $r8.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z2 == 0 goto (branch);	if z1 == 0 goto return;	return
;block_num 5