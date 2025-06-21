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

(declare-sort var3678 0)
(declare-sort var2374 0)
(declare-sort var2512 0)
(declare-sort var1456 0)
(declare-sort var2833 0)
(declare-sort var852 0)
(declare-sort var3696 0)
(declare-sort var2753 0)
(declare-sort var3927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/824650316 (var2374) String)
(declare-fun var2512_isEmpty/-813097145 (String) Bool)
(declare-fun getMethods/-297347657 (ClassObject) (Array Int var1456))
(declare-fun var852_stream/-1757820 ((Array Int var3696)) var2833)
(declare-fun cast-from-__Array__Int__var1456__-to-__Array__Int__var3696__ ((Array Int var1456)) (Array Int var3696))
(declare-fun var3927_bootstrap$/270663309 (String) var2753)
(declare-fun var2833_anyMatch/-1059037355 (var2833 var2753) Bool)
(declare-const null-var3678 var3678)
(declare-const null-var2374 var2374)
(declare-const null-ClassObject ClassObject)
(declare-const null-Bool Bool)
(declare-const var662 var3678) ; Statement: r15 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var662 null-var3678)))
(declare-const var2483 var2374) ; Statement: r0 := @parameter0: org.apache.dubbo.config.MethodConfig 
(assert (not (= var2483 null-var2374)))
(declare-const var3750 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var3750 null-ClassObject)))
(declare-const var1931 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var1931 null-Bool)))
(assert true)
(define-const var1758 String (getName/824650316 var2483)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
(define-const var1935 Bool (var2512_isEmpty/-813097145 var1758)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
(assert (= (ite var1935 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2059 (Array Int var1456) (getMethods/-297347657 var3750)) ; Statement: $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
(define-const var3300 var2833 (var852_stream/-1757820 (cast-from-__Array__Int__var1456__-to-__Array__Int__var3696__ var2059))) ; Statement: $r5 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r3) 
(define-const var2747 var2753 (var3927_bootstrap$/270663309 var1758)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.config.AbstractInterfaceConfig$lambda_verifyMethodConfig_3__335: java.util.function.Predicate bootstrap$(java.lang.String)>(r1) 
(define-const var703 Bool (var2833_anyMatch/-1059037355 var3300 var2747)) ; Statement: z3 = interfaceinvoke $r5.<java.util.stream.Stream: boolean anyMatch(java.util.function.Predicate)>($r4) 
 ; Statement: if z3 != 0 goto return 1 
(assert (not (= (ite var703 1 0) 0))) ; Cond: z3 != 0 
 ; Statement: return 1 
(check-sat)
; {getName/824650316=([org.apache.dubbo.config.MethodConfig], java.lang.String), var2512_isEmpty/-813097145=([java.lang.String], boolean), getMethods/-297347657=([java.lang.Class], java.lang.reflect.Method[]), var852_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__var1456__-to-__Array__Int__var3696__=([java.lang.reflect.Method[]], java.lang.Object[]), var3927_bootstrap$/270663309=([java.lang.String], java.util.function.Predicate), var2833_anyMatch/-1059037355=([java.util.stream.Stream, java.util.function.Predicate], boolean)}
; {var3678=org.apache.dubbo.config.AbstractInterfaceConfig, var662=r15, var2374=org.apache.dubbo.config.MethodConfig, var2483=r0, var3750=r2, var1931=z1, var1758=r1, var2512=org.apache.dubbo.common.utils.StringUtils, var1935=$z0, var1456=java.lang.reflect.Method, var2059=$r3, var2833=java.util.stream.Stream, var852=java.util.Arrays, var3696=java.lang.Object, var3300=$r5, var2753=java.util.function.Predicate, var3927=org.apache.dubbo.config.AbstractInterfaceConfig$lambda_verifyMethodConfig_3__335, var2747=$r4, var703=z3}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var3678, r15=var662, org.apache.dubbo.config.MethodConfig=var2374, r0=var2483, r2=var3750, z1=var1931, r1=var1758, org.apache.dubbo.common.utils.StringUtils=var2512, $z0=var1935, java.lang.reflect.Method=var1456, $r3=var2059, java.util.stream.Stream=var2833, java.util.Arrays=var852, java.lang.Object=var3696, $r5=var3300, java.util.function.Predicate=var2753, org.apache.dubbo.config.AbstractInterfaceConfig$lambda_verifyMethodConfig_3__335=var3927, $r4=var2747, z3=var703}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r15 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r0 := @parameter0: org.apache.dubbo.config.MethodConfig;	r2 := @parameter1: java.lang.Class;	z1 := @parameter2: boolean;	r1 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	$r3 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	$r5 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r3);	$r4 = staticinvoke <org.apache.dubbo.config.AbstractInterfaceConfig$lambda_verifyMethodConfig_3__335: java.util.function.Predicate bootstrap$(java.lang.String)>(r1);	z3 = interfaceinvoke $r5.<java.util.stream.Stream: boolean anyMatch(java.util.function.Predicate)>($r4);	if z3 != 0 goto return 1;	return 1
;block_num 3