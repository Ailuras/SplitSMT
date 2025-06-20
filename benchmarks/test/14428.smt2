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

(declare-sort var2196 0)
(declare-sort var3315 0)
(declare-sort var2555 0)
(declare-sort var150 0)
(declare-sort var3930 0)
(declare-sort var3599 0)
(declare-sort var1418 0)
(declare-sort var1419 0)
(declare-sort var492 0)
(declare-sort var3256 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3930_toJson/-637920053 (var3599) String)
(declare-fun cast-from-var150-to-var3599 (var150) var3599)
(declare-fun var1418_calRevision/2060062488 (String) String)
(declare-fun serviceInstanceRevisionMap/-1558756437 (var2196) var1419)
(declare-fun put/-1753019971 (var1419 var3599 var3599) var3599)
(declare-fun cast-from-String-to-var3599 (String) var3599)
(declare-fun cast-from-var3599-to-String (var3599) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-fun logger/-1558756437 (var2196) var492)
(declare-fun var3256_isDebugEnabled/-823448366 (var3256) Bool)
(declare-fun cast-from-var492-to-var3256 (var492) var3256)
(declare-const null-var2196 var2196)
(declare-const null-String String)
(declare-const null-var2555 var2555)
(declare-const null-var150 var150)
(declare-const var1300 var2196) ; Statement: r3 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var1300 null-var2196)))
(declare-const var3793 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3793 null-String)))
(declare-const var1554 var2555) ; Statement: r17 := @parameter1: org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener 
(assert (not (= var1554 null-var2555)))
(declare-const var317 var150) ; Statement: r0 := @parameter2: java.util.List 
(assert (not (= var317 null-var150)))
(define-const var1150 String (var3930_toJson/-637920053 (cast-from-var150-to-var3599 var317))) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>(r0) 
(define-const var2926 String (var1418_calRevision/2060062488 var1150)) ; Statement: r2 = staticinvoke <org.apache.dubbo.metadata.RevisionResolver: java.lang.String calRevision(java.lang.String)>($r1) 
(define-const var3092 var1419 (serviceInstanceRevisionMap/-1558756437 var1300)) ; Statement: $r5 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap serviceInstanceRevisionMap> 
(assert true)
(define-const var3827 var3599 (put/-1753019971 var3092 (cast-from-String-to-var3599 var3793) (cast-from-String-to-var3599 var2926))) ; Statement: $r6 = virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r4, r2) 
(define-const var1996 String (cast-from-var3599-to-String var3827)) ; Statement: $r7 = (java.lang.String) $r6 
(assert true)
(define-const var1911 Bool (equalsIgnoreCase/-92311102 var2926 var1996)) ; Statement: $z0 = virtualinvoke r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r7) 
 ; Statement: if $z0 != 0 goto $z5 = 0 
(assert (not (not (= (ite var1911 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2146 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
(define-const var739 Bool (ite (= 1 1) true false)) ; Statement: $z4 = 1 
 ; Statement: goto [?= z1 = $z5] 
(assert true) ; Non Conditional
(define-const var1042 Bool var2146) ; Statement: z1 = $z5 
(define-const var1862 var492 (logger/-1558756437 var1300)) ; Statement: $r8 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var558 Bool (var3256_isDebugEnabled/-823448366 (cast-from-var492-to-var3256 var1862))) ; Statement: $z2 = interfaceinvoke $r8.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z2 == 0 goto (branch) 
(assert (= (ite var558 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: if z1 == 0 goto return 
(assert (= (ite var1042 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: return 
(check-sat)
; {var3930_toJson/-637920053=([java.lang.Object], java.lang.String), cast-from-var150-to-var3599=([java.util.List], java.lang.Object), var1418_calRevision/2060062488=([java.lang.String], java.lang.String), serviceInstanceRevisionMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), put/-1753019971=([java.util.concurrent.ConcurrentHashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3599=([java.lang.String], java.lang.Object), cast-from-var3599-to-String=([java.lang.Object], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean), logger/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var3256_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var492-to-var3256=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var2196=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var1300=r3, var3793=r4, var3315=null_type, var2555=org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener, var1554=r17, var150=java.util.List, var317=r0, var3930=org.apache.dubbo.common.utils.JsonUtils, var3599=java.lang.Object, var1150=$r1, var1418=org.apache.dubbo.metadata.RevisionResolver, var2926=r2, var1419=java.util.concurrent.ConcurrentHashMap, var3092=$r5, var3827=$r6, var1996=$r7, var1911=$z0, var2146=$z5, var739=$z4, var1042=z1, var492=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1862=$r8, var3256=org.apache.dubbo.common.logger.Logger, var558=$z2}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var2196, r3=var1300, r4=var3793, null_type=var3315, org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener=var2555, r17=var1554, java.util.List=var150, r0=var317, org.apache.dubbo.common.utils.JsonUtils=var3930, java.lang.Object=var3599, $r1=var1150, org.apache.dubbo.metadata.RevisionResolver=var1418, r2=var2926, java.util.concurrent.ConcurrentHashMap=var1419, $r5=var3092, $r6=var3827, $r7=var1996, $z0=var1911, $z5=var2146, $z4=var739, z1=var1042, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var492, $r8=var1862, org.apache.dubbo.common.logger.Logger=var3256, $z2=var558}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r4 := @parameter0: java.lang.String;	r17 := @parameter1: org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener;	r0 := @parameter2: java.util.List;	$r1 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>(r0);	r2 = staticinvoke <org.apache.dubbo.metadata.RevisionResolver: java.lang.String calRevision(java.lang.String)>($r1);	$r5 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap serviceInstanceRevisionMap>;	$r6 = virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r4, r2);	$r7 = (java.lang.String) $r6;	$z0 = virtualinvoke r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r7);	if $z0 != 0 goto $z5 = 0;	$z5 = 1;	$z4 = 1;	goto [?= z1 = $z5];	z1 = $z5;	$r8 = r3.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z2 = interfaceinvoke $r8.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z2 == 0 goto (branch);	if z1 == 0 goto return;	return
;block_num 5