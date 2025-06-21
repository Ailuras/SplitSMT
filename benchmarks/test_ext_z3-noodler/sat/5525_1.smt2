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

(declare-sort var3456 0)
(declare-sort var667 0)
(declare-sort var1595 0)
(declare-sort var3145 0)
(declare-sort var1970 0)
(declare-sort var3119 0)
(declare-sort var2934 0)
(declare-sort var2711 0)
(declare-sort var2060 0)
(declare-sort var1723 0)
(declare-sort var3245 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun computeValidRegistryIds/-1727795882 (var3456) void)
(declare-fun registryIds/2049477907 (var3456) String)
(declare-fun var667_isEmpty/-813097145 (String) Bool)
(declare-fun split/1265909012 (var1595 String) (Array Int String))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1970-init () var1970)
(declare-fun <init>/-325640736 (var1970) void)
(declare-fun var2934_stream/-1757820 ((Array Int var2711)) var3119)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2711__ ((Array Int String)) (Array Int var2711))
(declare-fun var1723_bootstrap$/-1620006195 (var3456 var3245) var2060)
(declare-fun cast-from-var1970-to-var3245 (var1970) var3245)
(declare-fun var3119_forEach/1037804367 (var3119 var2060) void)
(declare-fun setRegistries/1848601197 (var3456 var3245) void)
(declare-const null-var3456 var3456)
(declare-const var3145-COMMA_SPLIT_PATTERN var1595)
(declare-const var2893 var3456) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var2893 null-var3456)))
(assert true)
;(assert (computeValidRegistryIds/-1727795882 var2893)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void computeValidRegistryIds()>() 

(declare-const var2893!1 var3456)
(define-const var2595 String (registryIds/2049477907 var2893!1)) ; Statement: $r1 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String registryIds> 
(define-const var3551 Bool (var667_isEmpty/-813097145 var2595)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (= (ite var3551 1 0) 0)) ; Cond: $z0 == 0 
(define-const var309 var1595 var3145-COMMA_SPLIT_PATTERN) ; Statement: $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(define-const var3882 String (registryIds/2049477907 var2893!1)) ; Statement: $r2 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String registryIds> 
(assert true)
(define-const var1162 (Array Int String) (split/1265909012 var309 (cast-from-String-to-String var3882))) ; Statement: r11 = virtualinvoke $r3.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>($r2) 
(define-const var2996 var1970 var1970-init) ; Statement: $r4 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2996)) ; Statement: specialinvoke $r4.<java.util.ArrayList: void <init>()>() 

(declare-const var2996!1 var1970)
(define-const var96 var3119 (var2934_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var2711__ var1162))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r11) 
(define-const var180 var2060 (var1723_bootstrap$/-1620006195 var2893!1 (cast-from-var1970-to-var3245 var2996!1))) ; Statement: $r5 = staticinvoke <org.apache.dubbo.config.AbstractInterfaceConfig$lambda_convertRegistryIdsToRegistries_5__336: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.AbstractInterfaceConfig,java.util.List)>(r0, $r4) 
;(assert (var3119_forEach/1037804367 var96 var180)) ; Statement: interfaceinvoke $r6.<java.util.stream.Stream: void forEach(java.util.function.Consumer)>($r5) 

(declare-const var96!1 var3119)
(declare-const var180!1 var2060)
(assert true)
;(assert (setRegistries/1848601197 var2893!1 (cast-from-var1970-to-var3245 var2996!1))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void setRegistries(java.util.List)>($r4) 

(declare-const var2893!2 var3456)
(declare-const var2996!2 var1970)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {computeValidRegistryIds/-1727795882=([org.apache.dubbo.config.AbstractInterfaceConfig], void), registryIds/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var667_isEmpty/-813097145=([java.lang.String], boolean), split/1265909012=([java.util.regex.Pattern, java.lang.CharSequence], java.lang.String[]), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1970-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var2934_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var2711__=([java.lang.String[]], java.lang.Object[]), var1723_bootstrap$/-1620006195=([org.apache.dubbo.config.AbstractInterfaceConfig, java.util.List], java.util.function.Consumer), cast-from-var1970-to-var3245=([java.util.ArrayList], java.util.List), var3119_forEach/1037804367=([java.util.stream.Stream, java.util.function.Consumer], void), setRegistries/1848601197=([org.apache.dubbo.config.AbstractInterfaceConfig, java.util.List], void)}
; {var3456=org.apache.dubbo.config.AbstractInterfaceConfig, var2893=r0, var2595=$r1, var667=org.apache.dubbo.common.utils.StringUtils, var3551=$z0, var1595=java.util.regex.Pattern, var3145=org.apache.dubbo.common.constants.CommonConstants, var309=$r3, var3882=$r2, var1162=r11, var1970=java.util.ArrayList, var2996=$r4, var3119=java.util.stream.Stream, var2934=java.util.Arrays, var2711=java.lang.Object, var96=$r6, var2060=java.util.function.Consumer, var1723=org.apache.dubbo.config.AbstractInterfaceConfig$lambda_convertRegistryIdsToRegistries_5__336, var3245=java.util.List, var180=$r5}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var3456, r0=var2893, $r1=var2595, org.apache.dubbo.common.utils.StringUtils=var667, $z0=var3551, java.util.regex.Pattern=var1595, org.apache.dubbo.common.constants.CommonConstants=var3145, $r3=var309, $r2=var3882, r11=var1162, java.util.ArrayList=var1970, $r4=var2996, java.util.stream.Stream=var3119, java.util.Arrays=var2934, java.lang.Object=var2711, $r6=var96, java.util.function.Consumer=var2060, org.apache.dubbo.config.AbstractInterfaceConfig$lambda_convertRegistryIdsToRegistries_5__336=var1723, java.util.List=var3245, $r5=var180}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void computeValidRegistryIds()>();	$r1 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String registryIds>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r2 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String registryIds>;	r11 = virtualinvoke $r3.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>($r2);	$r4 = new java.util.ArrayList;	specialinvoke $r4.<java.util.ArrayList: void <init>()>();	$r6 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r11);	$r5 = staticinvoke <org.apache.dubbo.config.AbstractInterfaceConfig$lambda_convertRegistryIdsToRegistries_5__336: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.AbstractInterfaceConfig,java.util.List)>(r0, $r4);	interfaceinvoke $r6.<java.util.stream.Stream: void forEach(java.util.function.Consumer)>($r5);	virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void setRegistries(java.util.List)>($r4);	return
;block_num 3