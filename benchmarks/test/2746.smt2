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

(declare-sort var1342 0)
(declare-sort var2972 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2972-init () (Array Int var2972))
(declare-fun type/-670994832 (var1342) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var2972 (String) var2972)
(declare-fun String_format/1339386452 (String (Array Int var2972)) String)
(declare-const null-var1342 var1342)
(declare-const null-__Array__Int__var2972__ (Array Int var2972))
(declare-const var283 var1342) ; Statement: r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var283 null-var1342)))
(define-const var3115 (Array Int var2972) arr-var2972-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var2407 ClassObject (type/-670994832 var283)) ; Statement: $r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var3120 String (getName/-1958580599 var2407)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3115!1 (Array Int var2972))
(assert (not (= var3115!1 null-__Array__Int__var2972__)))
(assert (= (select var3115!1 0) (cast-from-String-to-var2972 var3120))) ; Statement: $r0[0] = $r3 
(define-const var1517 String (String_format/1339386452 "ScopeModel scopeModel = ScopeModelUtil.getOrDefault(url.getScopeModel(), %s.class);\n" var3115!1)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("ScopeModel scopeModel = ScopeModelUtil.getOrDefault(url.getScopeModel(), %s.class);\n", $r0) 
 ; Statement: return $r4 
(check-sat)
; {arr-var2972-init=([], java.lang.Object[]), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var2972=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var1342=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var283=r1, var2972=java.lang.Object, var3115=$r0, var2407=$r2, var3120=$r3, var1517=$r4}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var1342, r1=var283, java.lang.Object=var2972, $r0=var3115, $r2=var2407, $r3=var3120, $r4=var1517}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	$r0 = newarray (java.lang.Object)[1];	$r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r0[0] = $r3;	$r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("ScopeModel scopeModel = ScopeModelUtil.getOrDefault(url.getScopeModel(), %s.class);\n", $r0);	return $r4
;block_num 1