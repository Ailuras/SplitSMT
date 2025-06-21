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

(declare-sort var822 0)
(declare-sort var3949 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var3949-init () (Array Int var3949))
(declare-fun type/-670994832 (var822) ClassObject)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun cast-from-String-to-var3949 (String) var3949)
(declare-fun getCanonicalName/935544231 (ClassObject) String)
(declare-fun String_format/1339386452 (String (Array Int var3949)) String)
(declare-const null-var822 var822)
(declare-const null-__Array__Int__var3949__ (Array Int var3949))
(declare-const var171 var822) ; Statement: r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var171 null-var822)))
(define-const var765 (Array Int var3949) arr-var3949-init) ; Statement: $r0 = newarray (java.lang.Object)[2] 
(define-const var3527 ClassObject (type/-670994832 var171)) ; Statement: $r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var3410 String (getSimpleName/-390194377 var3527)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(declare-const var765!1 (Array Int var3949))
(assert (not (= var765!1 null-__Array__Int__var3949__)))
(assert (= (select var765!1 0) (cast-from-String-to-var3949 var3410))) ; Statement: $r0[0] = $r3 
(define-const var3533 ClassObject (type/-670994832 var171)) ; Statement: $r4 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var887 String (getCanonicalName/935544231 var3533)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getCanonicalName()>() 
(declare-const var765!2 (Array Int var3949))
(assert (not (= var765!2 null-__Array__Int__var3949__)))
(assert (= (select var765!2 1) (cast-from-String-to-var3949 var887))) ; Statement: $r0[1] = $r5 
(define-const var2728 String (String_format/1339386452 "public class %s$Adaptive implements %s {\n" var765!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("public class %s$Adaptive implements %s {\n", $r0) 
 ; Statement: return $r6 
(check-sat)
; {arr-var3949-init=([], java.lang.Object[]), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getSimpleName/-390194377=([java.lang.Class], java.lang.String), cast-from-String-to-var3949=([java.lang.String], java.lang.Object), getCanonicalName/935544231=([java.lang.Class], java.lang.String), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var822=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var171=r1, var3949=java.lang.Object, var765=$r0, var3527=$r2, var3410=$r3, var3533=$r4, var887=$r5, var2728=$r6}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var822, r1=var171, java.lang.Object=var3949, $r0=var765, $r2=var3527, $r3=var3410, $r4=var3533, $r5=var887, $r6=var2728}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	$r0 = newarray (java.lang.Object)[2];	$r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>();	$r0[0] = $r3;	$r4 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getCanonicalName()>();	$r0[1] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("public class %s$Adaptive implements %s {\n", $r0);	return $r6
;block_num 1