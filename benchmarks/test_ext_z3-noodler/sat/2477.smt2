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

(declare-sort var2928 0)
(declare-sort var3850 0)
(declare-sort var2358 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getReturnType/-1494237887 (var3850) ClassObject)
(declare-fun getCanonicalName/935544231 (ClassObject) String)
(declare-fun getName/1227988463 (var3850) String)
(declare-fun generateMethodContent/187359337 (var2928 var3850) String)
(declare-fun generateMethodArguments/590622124 (var2928 var3850) String)
(declare-fun generateMethodThrows/2091205623 (var2928 var3850) String)
(declare-fun arr-var2358-init () (Array Int var2358))
(declare-fun cast-from-String-to-var2358 (String) var2358)
(declare-fun String_format/1339386452 (String (Array Int var2358)) String)
(declare-const null-var2928 var2928)
(declare-const null-var3850 var3850)
(declare-const null-__Array__Int__var2358__ (Array Int var2358))
(declare-const var3543 var2928) ; Statement: r4 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var3543 null-var2928)))
(declare-const var1431 var3850) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1431 null-var3850)))
(assert true)
(define-const var84 ClassObject (getReturnType/-1494237887 var1431)) ; Statement: $r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(assert true)
(define-const var683 String (getCanonicalName/935544231 var84)) ; Statement: r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getCanonicalName()>() 
(assert true)
(define-const var60 String (getName/1227988463 var1431)) ; Statement: r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2636 String (generateMethodContent/187359337 var3543 var1431)) ; Statement: r5 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateMethodContent(java.lang.reflect.Method)>(r0) 
(assert true)
(define-const var3509 String (generateMethodArguments/590622124 var3543 var1431)) ; Statement: r6 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateMethodArguments(java.lang.reflect.Method)>(r0) 
(assert true)
(define-const var317 String (generateMethodThrows/2091205623 var3543 var1431)) ; Statement: r7 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateMethodThrows(java.lang.reflect.Method)>(r0) 
(define-const var3730 (Array Int var2358) arr-var2358-init) ; Statement: $r8 = newarray (java.lang.Object)[5] 
(declare-const var3730!1 (Array Int var2358))
(assert (not (= var3730!1 null-__Array__Int__var2358__)))
(assert (= (select var3730!1 0) (cast-from-String-to-var2358 var683))) ; Statement: $r8[0] = r2 
(declare-const var3730!2 (Array Int var2358))
(assert (not (= var3730!2 null-__Array__Int__var2358__)))
(assert (= (select var3730!2 1) (cast-from-String-to-var2358 var60))) ; Statement: $r8[1] = r3 
(declare-const var3730!3 (Array Int var2358))
(assert (not (= var3730!3 null-__Array__Int__var2358__)))
(assert (= (select var3730!3 2) (cast-from-String-to-var2358 var3509))) ; Statement: $r8[2] = r6 
(declare-const var3730!4 (Array Int var2358))
(assert (not (= var3730!4 null-__Array__Int__var2358__)))
(assert (= (select var3730!4 3) (cast-from-String-to-var2358 var317))) ; Statement: $r8[3] = r7 
(declare-const var3730!5 (Array Int var2358))
(assert (not (= var3730!5 null-__Array__Int__var2358__)))
(assert (= (select var3730!5 4) (cast-from-String-to-var2358 var2636))) ; Statement: $r8[4] = r5 
(define-const var213 String (String_format/1339386452 "public %s %s(%s) %s {\n%s}\n" var3730!5)) ; Statement: $r9 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("public %s %s(%s) %s {\n%s}\n", $r8) 
 ; Statement: return $r9 
(check-sat)
; {getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), getCanonicalName/935544231=([java.lang.Class], java.lang.String), getName/1227988463=([java.lang.reflect.Method], java.lang.String), generateMethodContent/187359337=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, java.lang.reflect.Method], java.lang.String), generateMethodArguments/590622124=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, java.lang.reflect.Method], java.lang.String), generateMethodThrows/2091205623=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, java.lang.reflect.Method], java.lang.String), arr-var2358-init=([], java.lang.Object[]), cast-from-String-to-var2358=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var2928=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var3543=r4, var3850=java.lang.reflect.Method, var1431=r0, var84=$r1, var683=r2, var60=r3, var2636=r5, var3509=r6, var317=r7, var2358=java.lang.Object, var3730=$r8, var213=$r9}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var2928, r4=var3543, java.lang.reflect.Method=var3850, r0=var1431, $r1=var84, r2=var683, r3=var60, r5=var2636, r6=var3509, r7=var317, java.lang.Object=var2358, $r8=var3730, $r9=var213}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r4 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	$r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getCanonicalName()>();	r3 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.String getName()>();	r5 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateMethodContent(java.lang.reflect.Method)>(r0);	r6 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateMethodArguments(java.lang.reflect.Method)>(r0);	r7 = specialinvoke r4.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateMethodThrows(java.lang.reflect.Method)>(r0);	$r8 = newarray (java.lang.Object)[5];	$r8[0] = r2;	$r8[1] = r3;	$r8[2] = r6;	$r8[3] = r7;	$r8[4] = r5;	$r9 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("public %s %s(%s) %s {\n%s}\n", $r8);	return $r9
;block_num 1