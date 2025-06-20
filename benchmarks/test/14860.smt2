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

(declare-sort var2211 0)
(declare-sort var2224 0)
(declare-sort var170 0)
(declare-sort var1004 0)
(declare-sort var3420 0)
(declare-sort var8 0)
(declare-sort var3338 0)
(declare-sort var3979 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1558756437 (var2211) var1004)
(declare-fun var3420_isDebugEnabled/-823448366 (var3420) Bool)
(declare-fun cast-from-var1004-to-var3420 (var1004) var3420)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var8) String)
(declare-fun cast-from-var2224-to-var8 (var2224) var8)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3420_debug/470264832 (var3420 String) void)
(declare-fun var3338_isEmpty/-813097145 (String) Bool)
(declare-fun metadataMap/-1558756437 (var2211) var3979)
(declare-fun remove/583870081 (var3979 var8) var8)
(declare-fun cast-from-String-to-var8 (String) var8)
(declare-const null-var2211 var2211)
(declare-const null-var2224 var2224)
(declare-const null-String String)
(declare-const var3985 var2211) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var3985 null-var2211)))
(declare-const var1782 var2224) ; Statement: r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var1782 null-var2224)))
(declare-const var1878 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var1878 null-String)))
(declare-const var1726 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var1726 null-String)))
(define-const var3509 var1004 (logger/-1558756437 var3985)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1322 Bool (var3420_isDebugEnabled/-823448366 (cast-from-var1004-to-var3420 var3509))) ; Statement: $z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
(assert (not (= (ite var1322 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var788 var1004 (logger/-1558756437 var3985)) ; Statement: $r7 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1895 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1895)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1895!1 String)
(assert (= var1895!1 ""))
(assert true)
(define-const var2898 String (append/672562846 var1895!1 "Receive callback: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Receive callback: ") 
(declare-const var1895!2 String)
(assert (= var1895!2 (str.++ var1895!1 "Receive callback: ")))
(assert true)
(define-const var1095 String (append/672562846 var2898 var1726)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2898!1 String)
(assert (= var2898!1 (str.++ var2898 var1726)))
(assert true)
(define-const var779 String (append/-1031950772 var1095 (cast-from-var2224-to-var8 var1782))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r9) 
(declare-const var1095!1 String)
(assert (str.prefixof var1095 var1095!1))
(assert true)
(define-const var1855 String (toString/-2075883882 var779)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3420_debug/470264832 (cast-from-var1004-to-var3420 var788) var1855)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12) 

(declare-const var788!1 var1004)
(declare-const var1855!1 String)
(assert true) ; Non Conditional
(define-const var2877 Bool (var3338_isEmpty/-813097145 var1726)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert (not (= (ite var2877 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3437 var3979 (metadataMap/-1558756437 var3985)) ; Statement: $r5 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert true)
;(assert (remove/583870081 var3437 (cast-from-String-to-var8 var1878))) ; Statement: virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object remove(java.lang.Object)>(r3) 

(declare-const var3437!1 var3979)
(declare-const var1878!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {logger/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var3420_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1004-to-var3420=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2224-to-var8=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3420_debug/470264832=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var3338_isEmpty/-813097145=([java.lang.String], boolean), metadataMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), remove/583870081=([java.util.concurrent.ConcurrentHashMap, java.lang.Object], java.lang.Object), cast-from-String-to-var8=([java.lang.String], java.lang.Object)}
; {var2211=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var3985=r0, var2224=org.apache.dubbo.registry.client.DefaultServiceInstance, var1782=r9, var1878=r3, var170=null_type, var1726=r2, var1004=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3509=$r1, var3420=org.apache.dubbo.common.logger.Logger, var1322=$z0, var788=$r7, var1895=$r6, var2898=$r8, var1095=$r10, var8=java.lang.Object, var779=$r11, var1855=$r12, var3338=org.apache.dubbo.common.utils.StringUtils, var2877=$z1, var3979=java.util.concurrent.ConcurrentHashMap, var3437=$r5}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var2211, r0=var3985, org.apache.dubbo.registry.client.DefaultServiceInstance=var2224, r9=var1782, r3=var1878, null_type=var170, r2=var1726, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1004, $r1=var3509, org.apache.dubbo.common.logger.Logger=var3420, $z0=var1322, $r7=var788, $r6=var1895, $r8=var2898, $r10=var1095, java.lang.Object=var8, $r11=var779, $r12=var1855, org.apache.dubbo.common.utils.StringUtils=var3338, $z1=var2877, java.util.concurrent.ConcurrentHashMap=var3979, $r5=var3437}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance;	r3 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	$r7 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Receive callback: ");	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	$r5 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	virtualinvoke $r5.<java.util.concurrent.ConcurrentHashMap: java.lang.Object remove(java.lang.Object)>(r3);	goto [?= return];	return
;block_num 5