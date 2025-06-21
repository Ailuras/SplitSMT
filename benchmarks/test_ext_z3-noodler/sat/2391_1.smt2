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

(declare-sort var3033 0)
(declare-sort var3235 0)
(declare-sort var2911 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2911-init () (Array Int var2911))
(declare-fun cast-from-var3235-to-var2911 (var3235) var2911)
(declare-fun type/-670994832 (var3033) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var2911 (String) var2911)
(declare-fun String_format/1339386452 (String (Array Int var2911)) String)
(declare-const null-var3033 var3033)
(declare-const null-var3235 var3235)
(declare-const null-__Array__Int__var2911__ (Array Int var2911))
(declare-const var2215 var3033) ; Statement: r2 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var2215 null-var3033)))
(declare-const var3002 var3235) ; Statement: r1 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3002 null-var3235)))
(define-const var1063 (Array Int var2911) arr-var2911-init) ; Statement: $r0 = newarray (java.lang.Object)[2] 
(declare-const var1063!1 (Array Int var2911))
(assert (not (= var1063!1 null-__Array__Int__var2911__)))
(assert (= (select var1063!1 0) (cast-from-var3235-to-var2911 var3002))) ; Statement: $r0[0] = r1 
(define-const var3727 ClassObject (type/-670994832 var2215)) ; Statement: $r3 = r2.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var3981 String (getName/-1958580599 var3727)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
(declare-const var1063!2 (Array Int var2911))
(assert (not (= var1063!2 null-__Array__Int__var2911__)))
(assert (= (select var1063!2 1) (cast-from-String-to-var2911 var3981))) ; Statement: $r0[1] = $r4 
(define-const var1510 String (String_format/1339386452 "throw new UnsupportedOperationException(\u0022The method %s of interface %s is not adaptive method!\u0022);\n" var1063!2)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("throw new UnsupportedOperationException(\"The method %s of interface %s is not adaptive method!\");\n", $r0) 
 ; Statement: return $r5 
(check-sat)
; {arr-var2911-init=([], java.lang.Object[]), cast-from-var3235-to-var2911=([java.lang.reflect.Method], java.lang.Object), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var2911=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3033=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var2215=r2, var3235=java.lang.reflect.Method, var3002=r1, var2911=java.lang.Object, var1063=$r0, var3727=$r3, var3981=$r4, var1510=$r5}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var3033, r2=var2215, java.lang.reflect.Method=var3235, r1=var3002, java.lang.Object=var2911, $r0=var1063, $r3=var3727, $r4=var3981, $r5=var1510}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r2 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r1 := @parameter0: java.lang.reflect.Method;	$r0 = newarray (java.lang.Object)[2];	$r0[0] = r1;	$r3 = r2.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	$r0[1] = $r4;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("throw new UnsupportedOperationException(\"The method %s of interface %s is not adaptive method!\");\n", $r0);	return $r5
;block_num 1