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

(declare-sort var1813 0)
(declare-sort var2438 0)
(declare-sort var2010 0)
(declare-sort var1264 0)
(declare-sort var184 0)
(declare-sort var3605 0)
(declare-sort var2895 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1264_getValueFromConfig/-1280208315 (var1813 String) String)
(declare-fun var184_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3605_isInvalidLocalHost/244948788 (String) Bool)
(declare-fun var2895-init () var2895)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2895 String) void)
(declare-const null-var1813 var1813)
(declare-const null-var2438 var2438)
(declare-const null-var2010 var2010)
(declare-const var1877 var1813) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var1877 null-var1813)))
(declare-const var932 var2438) ; Statement: r8 := @parameter1: org.apache.dubbo.config.ProviderConfig 
(assert (not (= var932 null-var2438)))
(declare-const var385 var2010) ; Statement: r1 := @parameter2: java.util.Map 
(assert (not (= var385 null-var2010)))
(define-const var273 Bool (ite (= 1 0) true false)) ; Statement: z7 = 0 
(define-const var3697 String (var1264_getValueFromConfig/-1280208315 var1877 "DUBBO_IP_TO_BIND")) ; Statement: r16 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String getValueFromConfig(org.apache.dubbo.config.ProtocolConfig,java.lang.String)>(r0, "DUBBO_IP_TO_BIND") 
(define-const var762 Bool (var184_isNotEmpty/-1251449450 var3697)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r16) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r16) 
(assert (not (= (ite var762 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1320 Bool (var3605_isInvalidLocalHost/244948788 var3697)) ; Statement: $z6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>(r16) 
 ; Statement: if $z6 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r16) 
(assert (not (= (ite var1320 1 0) 0))) ; Negate: Cond: $z6 == 0  
(define-const var173 var2895 var2895-init) ; Statement: $r11 = new java.lang.IllegalArgumentException 
(define-const var1681 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1681)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1681!1 String)
(assert (= var1681!1 ""))
(assert true)
(define-const var1896 String (append/672562846 var1681!1 "Specified invalid bind ip from property:DUBBO_IP_TO_BIND, value:")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid bind ip from property:DUBBO_IP_TO_BIND, value:") 
(declare-const var1681!2 String)
(assert (= var1681!2 (str.++ var1681!1 "Specified invalid bind ip from property:DUBBO_IP_TO_BIND, value:")))
(assert true)
(define-const var285 String (append/672562846 var1896 var3697)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r16) 
(declare-const var1896!1 String)
(assert (= var1896!1 (str.++ var1896 var3697)))
(assert true)
(define-const var537 String (toString/-2075883882 var285)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var173 var537)) ; Statement: specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15) 

(declare-const var173!1 var2895)
(declare-const var537!1 String)
 ; Statement: throw $r11 
(check-sat)
; {var1264_getValueFromConfig/-1280208315=([org.apache.dubbo.config.ProtocolConfig, java.lang.String], java.lang.String), var184_isNotEmpty/-1251449450=([java.lang.String], boolean), var3605_isInvalidLocalHost/244948788=([java.lang.String], boolean), var2895-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1813=org.apache.dubbo.config.ProtocolConfig, var1877=r0, var2438=org.apache.dubbo.config.ProviderConfig, var932=r8, var2010=java.util.Map, var385=r1, var273=z7, var1264=org.apache.dubbo.config.ServiceConfig, var3697=r16, var184=org.apache.dubbo.common.utils.StringUtils, var762=$z0, var3605=org.apache.dubbo.common.utils.NetUtils, var1320=$z6, var2895=java.lang.IllegalArgumentException, var173=$r11, var1681=$r12, var1896=$r13, var285=$r14, var537=$r15}
; {org.apache.dubbo.config.ProtocolConfig=var1813, r0=var1877, org.apache.dubbo.config.ProviderConfig=var2438, r8=var932, java.util.Map=var2010, r1=var385, z7=var273, org.apache.dubbo.config.ServiceConfig=var1264, r16=var3697, org.apache.dubbo.common.utils.StringUtils=var184, $z0=var762, org.apache.dubbo.common.utils.NetUtils=var3605, $z6=var1320, java.lang.IllegalArgumentException=var2895, $r11=var173, $r12=var1681, $r13=var1896, $r14=var285, $r15=var537}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig;	r8 := @parameter1: org.apache.dubbo.config.ProviderConfig;	r1 := @parameter2: java.util.Map;	z7 = 0;	r16 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String getValueFromConfig(org.apache.dubbo.config.ProtocolConfig,java.lang.String)>(r0, "DUBBO_IP_TO_BIND");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r16);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r16);	$z6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>(r16);	if $z6 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r16);	$r11 = new java.lang.IllegalArgumentException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid bind ip from property:DUBBO_IP_TO_BIND, value:");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r16);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15);	throw $r11
;block_num 3