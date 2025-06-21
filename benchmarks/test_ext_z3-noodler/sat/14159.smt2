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

(declare-sort var2642 0)
(declare-sort var2030 0)
(declare-sort var851 0)
(declare-sort var3255 0)
(declare-sort var3260 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/-180586411 (var2642) var851)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3255) String)
(declare-fun cast-from-var2030-to-var3255 (var2030) var3255)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3260_info/484404803 (var3260 String) void)
(declare-fun cast-from-var851-to-var3260 (var851) var3260)
(declare-fun stopped/-180586411 (var2642) Bool)
(declare-fun var851_warn/1431914100 (var851 String String String String) void)
(declare-const null-var2642 var2642)
(declare-const null-var2030 var2030)
(declare-const var1303 var2642) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener 
(assert (not (= var1303 null-var2642)))
(declare-const var10 var2030) ; Statement: r3 := @parameter0: org.apache.dubbo.metadata.MappingChangedEvent 
(assert (not (= var10 null-var2030)))
(define-const var331 var851 (logger/-180586411 var1303)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var927 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var927)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var927!1 String)
(assert (= var927!1 ""))
(assert true)
(define-const var1759 String (append/672562846 var927!1 "Received mapping notification from meta server, ")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received mapping notification from meta server, ") 
(declare-const var927!2 String)
(assert (= var927!2 (str.++ var927!1 "Received mapping notification from meta server, ")))
(assert true)
(define-const var2220 String (append/-1031950772 var1759 (cast-from-var2030-to-var3255 var10))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var1759!1 String)
(assert (str.prefixof var1759 var1759!1))
(assert true)
(define-const var567 String (toString/-2075883882 var2220)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3260_info/484404803 (cast-from-var851-to-var3260 var331) var567)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r6) 

(declare-const var331!1 var851)
(declare-const var567!1 String)
(define-const var1919 Bool (stopped/-180586411 var1303)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener: boolean stopped> 
 ; Statement: if $z0 == 0 goto r7 = virtualinvoke r3.<org.apache.dubbo.metadata.MappingChangedEvent: java.util.Set getApps()>() 
(assert (not (= (ite var1919 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1988 var851 (logger/-180586411 var1303)) ; Statement: $r56 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var851_warn/1431914100 var1988 "99-0" "" "" "Listener has been stopped, ignore mapping notification, check why listener is not removed.")) ; Statement: interfaceinvoke $r56.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "", "", "Listener has been stopped, ignore mapping notification, check why listener is not removed.") 

(declare-const var1988!1 var851)
(declare-const var709 String)
(declare-const var2372 String)
(declare-const var2372!1 String)
(declare-const var3881 String)
 ; Statement: return 
(check-sat)
; {logger/-180586411=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2030-to-var3255=([org.apache.dubbo.metadata.MappingChangedEvent], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3260_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var851-to-var3260=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), stopped/-180586411=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener], boolean), var851_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2642=org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener, var1303=r0, var2030=org.apache.dubbo.metadata.MappingChangedEvent, var10=r3, var851=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var331=$r2, var927=$r1, var1759=$r4, var3255=java.lang.Object, var2220=$r5, var567=$r6, var3260=org.apache.dubbo.common.logger.Logger, var1919=$z0, var1988=$r56, var709="99-0", var2372="", var3881="Listener has been stopped, ignore mapping notification, check why listener is not removed."}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener=var2642, r0=var1303, org.apache.dubbo.metadata.MappingChangedEvent=var2030, r3=var10, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var851, $r2=var331, $r1=var927, $r4=var1759, java.lang.Object=var3255, $r5=var2220, $r6=var567, org.apache.dubbo.common.logger.Logger=var3260, $z0=var1919, $r56=var1988, "99-0"=var709, ""=var2372, "Listener has been stopped, ignore mapping notification, check why listener is not removed."=var3881}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener;	r3 := @parameter0: org.apache.dubbo.metadata.MappingChangedEvent;	$r2 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received mapping notification from meta server, ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r6);	$z0 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener: boolean stopped>;	if $z0 == 0 goto r7 = virtualinvoke r3.<org.apache.dubbo.metadata.MappingChangedEvent: java.util.Set getApps()>();	$r56 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry$DefaultMappingListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r56.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "", "", "Listener has been stopped, ignore mapping notification, check why listener is not removed.");	return
;block_num 2