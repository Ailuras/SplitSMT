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

(declare-sort var3264 0)
(declare-sort var1622 0)
(declare-sort var3487 0)
(declare-sort var3961 0)
(declare-sort var2865 0)
(declare-sort var3190 0)
(declare-sort var453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getType/-1080442783 (var1622) String)
(declare-fun var2865_isNotEmpty/-1251449450 (String) Bool)
(declare-fun findArgumentIndexIndexWithGivenType/-612452316 (var3264 var1622 var3487) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/1227988463 (var3487) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3190) String)
(declare-fun cast-from-Int-to-var3190 (Int) var3190)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var453_appendParameters/-1651738593 (var3961 var3190 String) void)
(declare-fun cast-from-var1622-to-var3190 (var1622) var3190)
(declare-const null-var3264 var3264)
(declare-const null-var1622 var1622)
(declare-const null-var3487 var3487)
(declare-const null-var3961 var3961)
(declare-const var68 var3264) ; Statement: r2 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var68 null-var3264)))
(declare-const var184 var1622) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ArgumentConfig 
(assert (not (= var184 null-var1622)))
(declare-const var3695 var3487) ; Statement: r6 := @parameter1: java.lang.reflect.Method 
(assert (not (= var3695 null-var3487)))
(declare-const var1972 var3961) ; Statement: r4 := @parameter2: java.util.Map 
(assert (not (= var1972 null-var3961)))
(assert true)
(define-const var1404 String (getType/-1080442783 var184)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>() 
(define-const var2353 Bool (var2865_isNotEmpty/-1251449450 var1404)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $z1 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r0) 
(assert (not (= (ite var2353 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1539 Int (findArgumentIndexIndexWithGivenType/-612452316 var68 var184 var3695)) ; Statement: r13 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: java.lang.Integer findArgumentIndexIndexWithGivenType(org.apache.dubbo.config.ArgumentConfig,java.lang.reflect.Method)>(r0, r6) 
(define-const var1143 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1143)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1143!1 String)
(assert (= var1143!1 ""))
(assert true)
(define-const var1918 String (getName/1227988463 var3695)) ; Statement: $r15 = virtualinvoke r6.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var1013 String (append/672562846 var1143!1 var1918)) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1143!2 String)
(assert (= var1143!2 (str.++ var1143!1 var1918)))
(assert true)
(define-const var300 String (append/672562846 var1013 ".")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1013!1 String)
(assert (= var1013!1 (str.++ var1013 ".")))
(assert true)
(define-const var358 String (append/-1031950772 var300 (cast-from-Int-to-var3190 var1539))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r13) 
(declare-const var300!1 String)
(assert (str.prefixof var300 var300!1))
(assert true)
(define-const var3921 String (toString/-2075883882 var358)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var453_appendParameters/-1651738593 var1972 (cast-from-var1622-to-var3190 var184) var3921)) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object,java.lang.String)>(r4, r0, $r19) 

(declare-const var1972!1 var3961)
(declare-const var184!1 var1622)
(declare-const var3921!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getType/-1080442783=([org.apache.dubbo.config.ArgumentConfig], java.lang.String), var2865_isNotEmpty/-1251449450=([java.lang.String], boolean), findArgumentIndexIndexWithGivenType/-612452316=([org.apache.dubbo.config.ServiceConfig, org.apache.dubbo.config.ArgumentConfig, java.lang.reflect.Method], java.lang.Integer), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/1227988463=([java.lang.reflect.Method], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var3190=([java.lang.Integer], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var453_appendParameters/-1651738593=([java.util.Map, java.lang.Object, java.lang.String], void), cast-from-var1622-to-var3190=([org.apache.dubbo.config.ArgumentConfig], java.lang.Object)}
; {var3264=org.apache.dubbo.config.ServiceConfig, var68=r2, var1622=org.apache.dubbo.config.ArgumentConfig, var184=r0, var3487=java.lang.reflect.Method, var3695=r6, var3961=java.util.Map, var1972=r4, var1404=$r1, var2865=org.apache.dubbo.common.utils.StringUtils, var2353=$z0, var1539=r13, var1143=$r14, var1918=$r15, var1013=$r16, var300=$r17, var3190=java.lang.Object, var358=$r18, var3921=$r19, var453=org.apache.dubbo.config.AbstractConfig}
; {org.apache.dubbo.config.ServiceConfig=var3264, r2=var68, org.apache.dubbo.config.ArgumentConfig=var1622, r0=var184, java.lang.reflect.Method=var3487, r6=var3695, java.util.Map=var3961, r4=var1972, $r1=var1404, org.apache.dubbo.common.utils.StringUtils=var2865, $z0=var2353, r13=var1539, $r14=var1143, $r15=var1918, $r16=var1013, $r17=var300, java.lang.Object=var3190, $r18=var358, $r19=var3921, org.apache.dubbo.config.AbstractConfig=var453}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ServiceConfig;	r0 := @parameter0: org.apache.dubbo.config.ArgumentConfig;	r6 := @parameter1: java.lang.reflect.Method;	r4 := @parameter2: java.util.Map;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $z1 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r0);	r13 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: java.lang.Integer findArgumentIndexIndexWithGivenType(org.apache.dubbo.config.ArgumentConfig,java.lang.reflect.Method)>(r0, r6);	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke r6.<java.lang.reflect.Method: java.lang.String getName()>();	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r13);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object,java.lang.String)>(r4, r0, $r19);	goto [?= return];	return
;block_num 3