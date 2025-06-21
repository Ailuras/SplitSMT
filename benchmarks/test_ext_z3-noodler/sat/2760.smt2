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

(declare-sort var3051 0)
(declare-sort var384 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var384-init () (Array Int var384))
(declare-fun type/-670994832 (var3051) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var384 (String) var384)
(declare-fun String_format/1339386452 (String (Array Int var384)) String)
(declare-const null-var3051 var3051)
(declare-const null-__Array__Int__var384__ (Array Int var384))
(declare-const var3790 var3051) ; Statement: r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var3790 null-var3051)))
(define-const var3876 (Array Int var384) arr-var384-init) ; Statement: $r0 = newarray (java.lang.Object)[2] 
(define-const var3663 ClassObject (type/-670994832 var3790)) ; Statement: $r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var243 String (getName/-1958580599 var3663)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3876!1 (Array Int var384))
(assert (not (= var3876!1 null-__Array__Int__var384__)))
(assert (= (select var3876!1 0) (cast-from-String-to-var384 var243))) ; Statement: $r0[0] = $r3 
(define-const var3791 ClassObject (type/-670994832 var3790)) ; Statement: $r4 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var123 String (getName/-1958580599 var3791)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3876!2 (Array Int var384))
(assert (not (= var3876!2 null-__Array__Int__var384__)))
(assert (= (select var3876!2 1) (cast-from-String-to-var384 var123))) ; Statement: $r0[1] = $r5 
(define-const var2436 String (String_format/1339386452 "%s extension = (%<s)scopeModel.getExtensionLoader(%s.class).getExtension(extName);\n" var3876!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s extension = (%<s)scopeModel.getExtensionLoader(%s.class).getExtension(extName);\n", $r0) 
 ; Statement: return $r6 
(check-sat)
; {arr-var384-init=([], java.lang.Object[]), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var384=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3051=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var3790=r1, var384=java.lang.Object, var3876=$r0, var3663=$r2, var243=$r3, var3791=$r4, var123=$r5, var2436=$r6}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var3051, r1=var3790, java.lang.Object=var384, $r0=var3876, $r2=var3663, $r3=var243, $r4=var3791, $r5=var123, $r6=var2436}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	$r0 = newarray (java.lang.Object)[2];	$r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r0[0] = $r3;	$r4 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>();	$r0[1] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s extension = (%<s)scopeModel.getExtensionLoader(%s.class).getExtension(extName);\n", $r0);	return $r6
;block_num 1