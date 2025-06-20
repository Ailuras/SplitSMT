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

(declare-sort var3532 0)
(declare-sort var778 0)
(declare-sort var3901 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var778-init () (Array Int var778))
(declare-fun type/-670994832 (var3532) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var778 (String) var778)
(declare-fun var3901_toString/-575966009 ((Array Int var778)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var778__ ((Array Int String)) (Array Int var778))
(declare-fun String_format/1339386452 (String (Array Int var778)) String)
(declare-const null-var3532 var3532)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-__Array__Int__var778__ (Array Int var778))
(declare-const var2895 var3532) ; Statement: r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var2895 null-var3532)))
(declare-const var1348 (Array Int String)) ; Statement: r4 := @parameter0: java.lang.String[] 
(assert (not (= var1348 null-__Array__Int__String__)))
(define-const var409 (Array Int var778) arr-var778-init) ; Statement: $r0 = newarray (java.lang.Object)[2] 
(define-const var2159 ClassObject (type/-670994832 var2895)) ; Statement: $r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var394 String (getName/-1958580599 var2159)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(declare-const var409!1 (Array Int var778))
(assert (not (= var409!1 null-__Array__Int__var778__)))
(assert (= (select var409!1 0) (cast-from-String-to-var778 var394))) ; Statement: $r0[0] = $r3 
(define-const var3660 String (var3901_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var778__ var1348))) ; Statement: $r5 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r4) 
(declare-const var409!2 (Array Int var778))
(assert (not (= var409!2 null-__Array__Int__var778__)))
(assert (= (select var409!2 1) (cast-from-String-to-var778 var3660))) ; Statement: $r0[1] = $r5 
(define-const var990 String (String_format/1339386452 "if(extName == null) throw new IllegalStateException(\u0022Failed to get extension (%s) name from url (\u0022 + url.toString() + \u0022) use keys(%s)\u0022);\n" var409!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if(extName == null) throw new IllegalStateException(\"Failed to get extension (%s) name from url (\" + url.toString() + \") use keys(%s)\");\n", $r0) 
 ; Statement: return $r6 
(check-sat)
; {arr-var778-init=([], java.lang.Object[]), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var778=([java.lang.String], java.lang.Object), var3901_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var778__=([java.lang.String[]], java.lang.Object[]), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3532=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var2895=r1, var1348=r4, var778=java.lang.Object, var409=$r0, var2159=$r2, var394=$r3, var3901=java.util.Arrays, var3660=$r5, var990=$r6}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var3532, r1=var2895, r4=var1348, java.lang.Object=var778, $r0=var409, $r2=var2159, $r3=var394, java.util.Arrays=var3901, $r5=var3660, $r6=var990}
;seq <java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r4 := @parameter0: java.lang.String[];	$r0 = newarray (java.lang.Object)[2];	$r2 = r1.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r0[0] = $r3;	$r5 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r4);	$r0[1] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if(extName == null) throw new IllegalStateException(\"Failed to get extension (%s) name from url (\" + url.toString() + \") use keys(%s)\");\n", $r0);	return $r6
;block_num 1