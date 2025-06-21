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

(declare-sort var3647 0)
(declare-sort var2055 0)
(declare-sort var1974 0)
(declare-sort var1559 0)
(declare-sort var3544 0)
(declare-sort var607 0)
(declare-sort var3715 0)
(declare-sort var2150 0)
(declare-sort var1326 0)
(declare-sort var99 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkRegistry/-1349273017 (var1974) void)
(declare-fun cast-from-var3647-to-var1974 (var3647) var1974)
(declare-fun var3544_loadRegistries/-1857565534 (var1974 Bool) var1559)
(declare-fun var607_isNotEmpty/-572947236 (var3715) Bool)
(declare-fun cast-from-var1559-to-var3715 (var1559) var3715)
(declare-fun urls/2049477907 (var1974) var1559)
(declare-fun var1559_isEmpty/-153543822 (var1559) Bool)
(declare-fun var2150-init () var2150)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceName/2049477907 (var1974) String)
(declare-fun var1326_getLocalHost/-1653363627 () String)
(declare-fun var99_getVersion/310196261 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2150 String) void)
(declare-const null-var3647 var3647)
(declare-const null-var2055 var2055)
(declare-const var1931 var3647) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1931 null-var3647)))
(declare-const var2398 var2055) ; Statement: r16 := @parameter0: java.util.Map 
(assert (not (= var2398 null-var2055)))
(assert true)
;(assert (checkRegistry/-1349273017 (cast-from-var3647-to-var1974 var1931))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void checkRegistry()>() 

(declare-const var1931!1 var3647)
(define-const var1888 var1559 (var3544_loadRegistries/-1857565534 (cast-from-var3647-to-var1974 var1931!1) (ite (= 1 0) true false))) ; Statement: r1 = staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: java.util.List loadRegistries(org.apache.dubbo.config.AbstractInterfaceConfig,boolean)>(r0, 0) 
(define-const var2370 Bool (var607_isNotEmpty/-572947236 (cast-from-var1559-to-var3715 var1888))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(assert (= (ite var2370 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2201 var1559 (urls/2049477907 (cast-from-var3647-to-var1974 var1931!1))) ; Statement: $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(define-const var3571 Bool (var1559_isEmpty/-153543822 var2201)) ; Statement: $z1 = interfaceinvoke $r2.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z1 == 0 goto $r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(assert (= (ite var3571 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1666 var1559 (urls/2049477907 (cast-from-var3647-to-var1974 var1931!1))) ; Statement: $r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(define-const var1904 Bool (var1559_isEmpty/-153543822 var1666)) ; Statement: $z5 = interfaceinvoke $r40.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z5 == 0 goto return 
(assert (not (= (ite var1904 1 0) 0))) ; Negate: Cond: $z5 == 0  
(define-const var2448 var2150 var2150-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var3440 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3440)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3440!1 String)
(assert (= var3440!1 ""))
(assert true)
(define-const var745 String (append/672562846 var3440!1 "No such any registry to reference ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such any registry to reference ") 
(declare-const var3440!2 String)
(assert (= var3440!2 (str.++ var3440!1 "No such any registry to reference ")))
(define-const var3455 String (interfaceName/2049477907 (cast-from-var3647-to-var1974 var1931!1))) ; Statement: $r5 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String interfaceName> 
(assert true)
(define-const var3546 String (append/672562846 var745 var3455)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var745!1 String)
(assert (= var745!1 (str.++ var745 var3455)))
(assert true)
(define-const var3150 String (append/672562846 var3546 " on the consumer ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on the consumer ") 
(declare-const var3546!1 String)
(assert (= var3546!1 (str.++ var3546 " on the consumer ")))
(define-const var2592 String var1326_getLocalHost/-1653363627) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var827 String (append/672562846 var3150 var2592)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var3150!1 String)
(assert (= var3150!1 (str.++ var3150 var2592)))
(assert true)
(define-const var118 String (append/672562846 var827 " use dubbo version ")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" use dubbo version ") 
(declare-const var827!1 String)
(assert (= var827!1 (str.++ var827 " use dubbo version ")))
(define-const var1129 String var99_getVersion/310196261) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
(define-const var1282 String (append/672562846 var118 var1129)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var118!1 String)
(assert (= var118!1 (str.++ var118 var1129)))
(assert true)
(define-const var1480 String (append/672562846 var1282 ", please config <dubbo:registry address=\u0022...\u0022 /> to your spring config.")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please config <dubbo:registry address=\"...\" /> to your spring config.") 
(declare-const var1282!1 String)
(assert (= var1282!1 (str.++ var1282 ", please config <dubbo:registry address=\u0022...\u0022 /> to your spring config.")))
(assert true)
(define-const var422 String (toString/-2075883882 var1480)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2448 var422)) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r15) 

(declare-const var2448!1 var2150)
(declare-const var422!1 String)
 ; Statement: throw $r3 
(check-sat)
; {checkRegistry/-1349273017=([org.apache.dubbo.config.AbstractInterfaceConfig], void), cast-from-var3647-to-var1974=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var3544_loadRegistries/-1857565534=([org.apache.dubbo.config.AbstractInterfaceConfig, boolean], java.util.List), var607_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var1559-to-var3715=([java.util.List], java.util.Collection), urls/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.util.List), var1559_isEmpty/-153543822=([java.util.List], boolean), var2150-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var1326_getLocalHost/-1653363627=([], java.lang.String), var99_getVersion/310196261=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3647=org.apache.dubbo.config.ReferenceConfig, var1931=r0, var2055=java.util.Map, var2398=r16, var1974=org.apache.dubbo.config.AbstractInterfaceConfig, var1559=java.util.List, var3544=org.apache.dubbo.config.utils.ConfigValidationUtils, var1888=r1, var607=org.apache.dubbo.common.utils.CollectionUtils, var3715=java.util.Collection, var2370=$z0, var2201=$r2, var3571=$z1, var1666=$r40, var1904=$z5, var2150=java.lang.IllegalStateException, var2448=$r3, var3440=$r4, var745=$r6, var3455=$r5, var3546=$r7, var3150=$r9, var1326=org.apache.dubbo.common.utils.NetUtils, var2592=$r8, var827=$r10, var118=$r12, var99=org.apache.dubbo.common.Version, var1129=$r11, var1282=$r13, var1480=$r14, var422=$r15}
; {org.apache.dubbo.config.ReferenceConfig=var3647, r0=var1931, java.util.Map=var2055, r16=var2398, org.apache.dubbo.config.AbstractInterfaceConfig=var1974, java.util.List=var1559, org.apache.dubbo.config.utils.ConfigValidationUtils=var3544, r1=var1888, org.apache.dubbo.common.utils.CollectionUtils=var607, java.util.Collection=var3715, $z0=var2370, $r2=var2201, $z1=var3571, $r40=var1666, $z5=var1904, java.lang.IllegalStateException=var2150, $r3=var2448, $r4=var3440, $r6=var745, $r5=var3455, $r7=var3546, $r9=var3150, org.apache.dubbo.common.utils.NetUtils=var1326, $r8=var2592, $r10=var827, $r12=var118, org.apache.dubbo.common.Version=var99, $r11=var1129, $r13=var1282, $r14=var1480, $r15=var422}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	r16 := @parameter0: java.util.Map;	virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void checkRegistry()>();	r1 = staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: java.util.List loadRegistries(org.apache.dubbo.config.AbstractInterfaceConfig,boolean)>(r0, 0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$z1 = interfaceinvoke $r2.<java.util.List: boolean isEmpty()>();	if $z1 == 0 goto $r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$z5 = interfaceinvoke $r40.<java.util.List: boolean isEmpty()>();	if $z5 == 0 goto return;	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such any registry to reference ");	$r5 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String interfaceName>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on the consumer ");	$r8 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" use dubbo version ");	$r11 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please config <dubbo:registry address=\"...\" /> to your spring config.");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r15);	throw $r3
;block_num 4