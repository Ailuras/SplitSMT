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

(declare-sort var874 0)
(declare-sort var2022 0)
(declare-sort var1115 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2022-init () (Array Int var2022))
(declare-fun type/-670994832 (var874) ClassObject)
(declare-fun getPackage/-1841711535 (ClassObject) var1115)
(declare-fun getName/-900081029 (var1115) String)
(declare-fun cast-from-String-to-var2022 (String) var2022)
(declare-fun String_format/1339386452 (String (Array Int var2022)) String)
(declare-const null-var874 var874)
(declare-const null-__Array__Int__var2022__ (Array Int var2022))
(declare-const var565 var874) ; Statement: r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var565 null-var874)))
(define-const var2050 (Array Int var2022) arr-var2022-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var3427 ClassObject (type/-670994832 var565)) ; Statement: $r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var1338 var1115 (getPackage/-1841711535 var3427)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.Package getPackage()>() 
(assert true)
(define-const var2057 String (getName/-900081029 var1338)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Package: java.lang.String getName()>() 
(declare-const var2050!1 (Array Int var2022))
(assert (not (= var2050!1 null-__Array__Int__var2022__)))
(assert (= (select var2050!1 0) (cast-from-String-to-var2022 var2057))) ; Statement: $r0[0] = $r4 
(define-const var1029 String (String_format/1339386452 "package %s;\n" var2050!1)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("package %s;\n", $r0) 
 ; Statement: return $r5 
(check-sat)
; {arr-var2022-init=([], java.lang.Object[]), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getPackage/-1841711535=([java.lang.Class], java.lang.Package), getName/-900081029=([java.lang.Package], java.lang.String), cast-from-String-to-var2022=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var874=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var565=r1, var2022=java.lang.Object, var2050=$r0, var3427=$r2, var1115=java.lang.Package, var1338=$r3, var2057=$r4, var1029=$r5}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var874, r1=var565, java.lang.Object=var2022, $r0=var2050, $r2=var3427, java.lang.Package=var1115, $r3=var1338, $r4=var2057, $r5=var1029}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	$r0 = newarray (java.lang.Object)[1];	$r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.Package getPackage()>();	$r4 = virtualinvoke $r3.<java.lang.Package: java.lang.String getName()>();	$r0[0] = $r4;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("package %s;\n", $r0);	return $r5
;block_num 1