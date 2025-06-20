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

(declare-sort var459 0)
(declare-sort var1924 0)
(declare-sort var1191 0)
(declare-sort var1928 0)
(declare-sort var997 0)
(declare-sort var3758 0)
(declare-sort var3027 0)
(declare-sort var2042 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-1558756437 (var459) var1928)
(declare-fun var997_isDebugEnabled/-823448366 (var997) Bool)
(declare-fun cast-from-var1928-to-var997 (var1928) var997)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3758) String)
(declare-fun cast-from-var1924-to-var3758 (var1924) var3758)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var997_debug/470264832 (var997 String) void)
(declare-fun var3027_isEmpty/-813097145 (String) Bool)
(declare-fun metadataMap/-1558756437 (var459) var2042)
(declare-fun put/-1753019971 (var2042 var3758 var3758) var3758)
(declare-fun cast-from-String-to-var3758 (String) var3758)
(declare-const null-var459 var459)
(declare-const null-var1924 var1924)
(declare-const null-String String)
(declare-const var2976 var459) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var2976 null-var459)))
(declare-const var3821 var1924) ; Statement: r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var3821 null-var1924)))
(declare-const var2434 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2434 null-String)))
(declare-const var302 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var302 null-String)))
(define-const var2120 var1928 (logger/-1558756437 var2976)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1750 Bool (var997_isDebugEnabled/-823448366 (cast-from-var1928-to-var997 var2120))) ; Statement: $z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
(assert (not (= (ite var1750 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var392 var1928 (logger/-1558756437 var2976)) ; Statement: $r7 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3673 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3673)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3673!1 String)
(assert (= var3673!1 ""))
(assert true)
(define-const var1031 String (append/672562846 var3673!1 "Receive callback: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Receive callback: ") 
(declare-const var3673!2 String)
(assert (= var3673!2 (str.++ var3673!1 "Receive callback: ")))
(assert true)
(define-const var179 String (append/672562846 var1031 var302)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1031!1 String)
(assert (= var1031!1 (str.++ var1031 var302)))
(assert true)
(define-const var3472 String (append/-1031950772 var179 (cast-from-var1924-to-var3758 var3821))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r9) 
(declare-const var179!1 String)
(assert (str.prefixof var179 var179!1))
(assert true)
(define-const var1824 String (toString/-2075883882 var3472)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var997_debug/470264832 (cast-from-var1928-to-var997 var392) var1824)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12) 

(declare-const var392!1 var1928)
(declare-const var1824!1 String)
(assert true) ; Non Conditional
(define-const var891 Bool (var3027_isEmpty/-813097145 var302)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert (= (ite var891 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2818 var2042 (metadataMap/-1558756437 var2976)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert true)
;(assert (put/-1753019971 var2818 (cast-from-String-to-var3758 var2434) (cast-from-String-to-var3758 var302))) ; Statement: virtualinvoke $r4.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, r2) 

(declare-const var2818!1 var2042)
(declare-const var2434!1 String)
(declare-const var302!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {logger/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var997_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1928-to-var997=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1924-to-var3758=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var997_debug/470264832=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var3027_isEmpty/-813097145=([java.lang.String], boolean), metadataMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), put/-1753019971=([java.util.concurrent.ConcurrentHashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3758=([java.lang.String], java.lang.Object)}
; {var459=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var2976=r0, var1924=org.apache.dubbo.registry.client.DefaultServiceInstance, var3821=r9, var2434=r3, var1191=null_type, var302=r2, var1928=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2120=$r1, var997=org.apache.dubbo.common.logger.Logger, var1750=$z0, var392=$r7, var3673=$r6, var1031=$r8, var179=$r10, var3758=java.lang.Object, var3472=$r11, var1824=$r12, var3027=org.apache.dubbo.common.utils.StringUtils, var891=$z1, var2042=java.util.concurrent.ConcurrentHashMap, var2818=$r4}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var459, r0=var2976, org.apache.dubbo.registry.client.DefaultServiceInstance=var1924, r9=var3821, r3=var2434, null_type=var1191, r2=var302, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1928, $r1=var2120, org.apache.dubbo.common.logger.Logger=var997, $z0=var1750, $r7=var392, $r6=var3673, $r8=var1031, $r10=var179, java.lang.Object=var3758, $r11=var3472, $r12=var1824, org.apache.dubbo.common.utils.StringUtils=var3027, $z1=var891, java.util.concurrent.ConcurrentHashMap=var2042, $r4=var2818}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r9 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance;	r3 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	$r7 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Receive callback: ");	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	$r4 = r0.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	virtualinvoke $r4.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, r2);	return
;block_num 5