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

(declare-sort var3340 0)
(declare-sort var2761 0)
(declare-sort var3316 0)
(declare-sort var2141 0)
(declare-sort var1677 0)
(declare-sort var3842 0)
(declare-sort var1675 0)
(declare-sort var3410 0)
(declare-sort var2594 0)
(declare-sort var2448 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2141!class ClassObject)
(declare-fun var3316-init () var3316)
(declare-fun <init>/-201242697 (var3316) void)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var1677_put/1464166817 (var1677 var3842 var3842) var3842)
(declare-fun cast-from-var3316-to-var1677 (var3316) var1677)
(declare-fun cast-from-String-to-var3842 (String) var3842)
(declare-fun var3340_appendRuntimeParameters/596205890 (var1677) void)
(declare-fun var1675_getSystemProperty/1777521604 (String) String)
(declare-fun var3410_isEmpty/-813097145 (String) Bool)
(declare-fun var2594_isInvalidLocalHost/244948788 (String) Bool)
(declare-fun var2448-init () var2448)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2448 String) void)
(declare-const null-var3340 var3340)
(declare-const null-var2761 var2761)
(declare-const var1849 var3340) ; Statement: r3 := @parameter0: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var1849 null-var3340)))
(declare-const var780 var2761) ; Statement: r9 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var780 null-var2761)))
(define-const var1848 var3316 var3316-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1848)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var1848!1 var3316)
(define-const var2324 ClassObject var2141!class) ; Statement: $r1 = class "Lorg/apache/dubbo/monitor/MonitorService;" 
(assert true)
(define-const var3464 String (getName/-1958580599 var2324)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>() 
;(assert (var1677_put/1464166817 (cast-from-var3316-to-var1677 var1848!1) (cast-from-String-to-var3842 "interface") (cast-from-String-to-var3842 var3464))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r2) 

(declare-const var1848!2 var3316)
(declare-const var2308 String)
(declare-const var3464!1 String)
;(assert (var3340_appendRuntimeParameters/596205890 (cast-from-var3316-to-var1677 var1848!2))) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractInterfaceConfig: void appendRuntimeParameters(java.util.Map)>($r0) 

(declare-const var1848!3 var3316)
(define-const var885 String (var1675_getSystemProperty/1777521604 "DUBBO_IP_TO_REGISTRY")) ; Statement: r24 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("DUBBO_IP_TO_REGISTRY") 
(define-const var181 Bool (var3410_isEmpty/-813097145 var885)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r24) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>(r24) 
(assert (= (ite var181 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3947 Bool (var2594_isInvalidLocalHost/244948788 var885)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>(r24) 
 ; Statement: if $z1 == 0 goto interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("register.ip", r24) 
(assert (not (= (ite var3947 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2992 var2448 var2448-init) ; Statement: $r16 = new java.lang.IllegalArgumentException 
(define-const var2443 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2443)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2443!1 String)
(assert (= var2443!1 ""))
(assert true)
(define-const var1490 String (append/672562846 var2443!1 "Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:") 
(declare-const var2443!2 String)
(assert (= var2443!2 (str.++ var2443!1 "Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:")))
(assert true)
(define-const var2514 String (append/672562846 var1490 var885)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r24) 
(declare-const var1490!1 String)
(assert (= var1490!1 (str.++ var1490 var885)))
(assert true)
(define-const var830 String (toString/-2075883882 var2514)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2992 var830)) ; Statement: specialinvoke $r16.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r20) 

(declare-const var2992!1 var2448)
(declare-const var830!1 String)
 ; Statement: throw $r16 
(check-sat)
; {var3316-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), getName/-1958580599=([java.lang.Class], java.lang.String), var1677_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var3316-to-var1677=([java.util.HashMap], java.util.Map), cast-from-String-to-var3842=([java.lang.String], java.lang.Object), var3340_appendRuntimeParameters/596205890=([java.util.Map], void), var1675_getSystemProperty/1777521604=([java.lang.String], java.lang.String), var3410_isEmpty/-813097145=([java.lang.String], boolean), var2594_isInvalidLocalHost/244948788=([java.lang.String], boolean), var2448-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3340=org.apache.dubbo.config.AbstractInterfaceConfig, var1849=r3, var2761=org.apache.dubbo.common.URL, var780=r9, var3316=java.util.HashMap, var1848=$r0, var2141=org.apache.dubbo.monitor.MonitorService, var2324=$r1, var3464=$r2, var1677=java.util.Map, var3842=java.lang.Object, var2308="interface", var1675=org.apache.dubbo.common.utils.ConfigUtils, var885=r24, var3410=org.apache.dubbo.common.utils.StringUtils, var181=$z0, var2594=org.apache.dubbo.common.utils.NetUtils, var3947=$z1, var2448=java.lang.IllegalArgumentException, var2992=$r16, var2443=$r17, var1490=$r18, var2514=$r19, var830=$r20}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var3340, r3=var1849, org.apache.dubbo.common.URL=var2761, r9=var780, java.util.HashMap=var3316, $r0=var1848, org.apache.dubbo.monitor.MonitorService=var2141, $r1=var2324, $r2=var3464, java.util.Map=var1677, java.lang.Object=var3842, "interface"=var2308, org.apache.dubbo.common.utils.ConfigUtils=var1675, r24=var885, org.apache.dubbo.common.utils.StringUtils=var3410, $z0=var181, org.apache.dubbo.common.utils.NetUtils=var2594, $z1=var3947, java.lang.IllegalArgumentException=var2448, $r16=var2992, $r17=var2443, $r18=var1490, $r19=var2514, $r20=var830}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: org.apache.dubbo.config.AbstractInterfaceConfig;	r9 := @parameter1: org.apache.dubbo.common.URL;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = class "Lorg/apache/dubbo/monitor/MonitorService;";	$r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r2);	staticinvoke <org.apache.dubbo.config.AbstractInterfaceConfig: void appendRuntimeParameters(java.util.Map)>($r0);	r24 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("DUBBO_IP_TO_REGISTRY");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r24);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>(r24);	$z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>(r24);	if $z1 == 0 goto interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("register.ip", r24);	$r16 = new java.lang.IllegalArgumentException;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r24);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r16.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r20);	throw $r16
;block_num 3