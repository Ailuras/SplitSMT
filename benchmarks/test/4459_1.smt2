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

(declare-sort var3155 0)
(declare-sort var2224 0)
(declare-sort var93 0)
(declare-sort var3476 0)
(declare-sort var2073 0)
(declare-sort var290 0)
(declare-sort var1221 0)
(declare-sort var2923 0)
(declare-sort var3086 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun disAllowedPrefix/-647195865 (var3155) var93)
(declare-fun var93_add/-1142548109 (var93 var3476) Bool)
(declare-fun cast-from-String-to-var3476 (String) var3476)
(declare-fun allowedPrefix/-647195865 (var3155) var93)
(declare-fun var290_bootstrap$/978986990 (String) var2073)
(declare-fun var1221_removeIf/1897619365 (var1221 var2073) Bool)
(declare-fun cast-from-var93-to-var1221 (var93) var1221)
(declare-fun toLowerCase/1946809429 (String var2923) String)
(declare-fun var3086_equals/1031735566 (var3476 var3476) Bool)
(declare-const null-var3155 var3155)
(declare-const null-String String)
(declare-const var2923-ROOT var2923)
(declare-const var1517 var3155) ; Statement: r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager 
(assert (not (= var1517 null-var3155)))
(declare-const var3325 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3325 null-String)))
(define-const var3958 var93 (disAllowedPrefix/-647195865 var1517)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.util.Set disAllowedPrefix> 
(define-const var3478 Bool (var93_add/-1142548109 var3958 (cast-from-String-to-var3476 var3325))) ; Statement: z2 = interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>(r1) 
(define-const var1216 var93 (allowedPrefix/-647195865 var1517)) ; Statement: $r3 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.util.Set allowedPrefix> 
(define-const var2712 var2073 (var290_bootstrap$/978986990 var3325)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.SerializeSecurityManager$lambda_addToDisAllowed_0__292: java.util.function.Predicate bootstrap$(java.lang.String)>(r1) 
(define-const var1483 Bool (var1221_removeIf/1897619365 (cast-from-var93-to-var1221 var1216) var2712)) ; Statement: $z0 = interfaceinvoke $r3.<java.util.Set: boolean removeIf(java.util.function.Predicate)>($r4) 
 ; Statement: if $z0 != 0 goto $z3 = 1 
(assert (not (= (ite var1483 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3118 Bool (ite (= 1 1) true false)) ; Statement: $z3 = 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $z3 == 0 goto $r5 = <java.util.Locale: java.util.Locale ROOT> 
(assert (= (ite var3118 1 0) 0)) ; Cond: $z3 == 0 
(define-const var771 var2923 var2923-ROOT) ; Statement: $r5 = <java.util.Locale: java.util.Locale ROOT> 
(assert true)
(define-const var184 String (toLowerCase/1946809429 var3325 var771)) ; Statement: $r6 = virtualinvoke r1.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r5) 
(define-const var526 Bool (var3086_equals/1031735566 (cast-from-String-to-var3476 var184) (cast-from-String-to-var3476 var3325))) ; Statement: $z1 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>($r6, r1) 
 ; Statement: if $z1 != 0 goto return 
(assert (not (= (ite var526 1 0) 0))) ; Cond: $z1 != 0 
 ; Statement: return 
(check-sat)
; {disAllowedPrefix/-647195865=([org.apache.dubbo.common.utils.SerializeSecurityManager], java.util.Set), var93_add/-1142548109=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var3476=([java.lang.String], java.lang.Object), allowedPrefix/-647195865=([org.apache.dubbo.common.utils.SerializeSecurityManager], java.util.Set), var290_bootstrap$/978986990=([java.lang.String], java.util.function.Predicate), var1221_removeIf/1897619365=([java.util.Collection, java.util.function.Predicate], boolean), cast-from-var93-to-var1221=([java.util.Set], java.util.Collection), toLowerCase/1946809429=([java.lang.String, java.util.Locale], java.lang.String), var3086_equals/1031735566=([java.lang.Object, java.lang.Object], boolean)}
; {var3155=org.apache.dubbo.common.utils.SerializeSecurityManager, var1517=r0, var3325=r1, var2224=null_type, var93=java.util.Set, var3958=$r2, var3476=java.lang.Object, var3478=z2, var1216=$r3, var2073=java.util.function.Predicate, var290=org.apache.dubbo.common.utils.SerializeSecurityManager$lambda_addToDisAllowed_0__292, var2712=$r4, var1221=java.util.Collection, var1483=$z0, var3118=$z3, var2923=java.util.Locale, var771=$r5, var184=$r6, var3086=java.util.Objects, var526=$z1}
; {org.apache.dubbo.common.utils.SerializeSecurityManager=var3155, r0=var1517, r1=var3325, null_type=var2224, java.util.Set=var93, $r2=var3958, java.lang.Object=var3476, z2=var3478, $r3=var1216, java.util.function.Predicate=var2073, org.apache.dubbo.common.utils.SerializeSecurityManager$lambda_addToDisAllowed_0__292=var290, $r4=var2712, java.util.Collection=var1221, $z0=var1483, $z3=var3118, java.util.Locale=var2923, $r5=var771, $r6=var184, java.util.Objects=var3086, $z1=var526}
;seq <java.lang.String: java.lang.String toLowerCase(java.util.Locale)>
;cnt {"<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.util.Set disAllowedPrefix>;	z2 = interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>(r1);	$r3 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: java.util.Set allowedPrefix>;	$r4 = staticinvoke <org.apache.dubbo.common.utils.SerializeSecurityManager$lambda_addToDisAllowed_0__292: java.util.function.Predicate bootstrap$(java.lang.String)>(r1);	$z0 = interfaceinvoke $r3.<java.util.Set: boolean removeIf(java.util.function.Predicate)>($r4);	if $z0 != 0 goto $z3 = 1;	$z3 = 1;	goto [?= (branch)];	if $z3 == 0 goto $r5 = <java.util.Locale: java.util.Locale ROOT>;	$r5 = <java.util.Locale: java.util.Locale ROOT>;	$r6 = virtualinvoke r1.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r5);	$z1 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>($r6, r1);	if $z1 != 0 goto return;	return
;block_num 5