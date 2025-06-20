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

(declare-sort var2086 0)
(declare-sort var457 0)
(declare-sort var47 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var47!class ClassObject)
(declare-fun arr-var457-init () (Array Int var457))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var457 (Int) var457)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var457 (String) var457)
(declare-fun String_format/1339386452 (String (Array Int var457)) String)
(declare-const null-var2086 var2086)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var457__ (Array Int var457))
(declare-const var133 var2086) ; Statement: r6 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var133 null-var2086)))
(declare-const var676 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var676 null-Int)))
(define-const var3942 (Array Int var457) arr-var457-init) ; Statement: $r0 = newarray (java.lang.Object)[3] 
(define-const var233 Int (Int_valueOf/-1371140006 var676)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var3942!1 (Array Int var457))
(assert (not (= var3942!1 null-__Array__Int__var457__)))
(assert (= (select var3942!1 0) (cast-from-Int-to-var457 var233))) ; Statement: $r0[0] = $r1 
(define-const var2017 ClassObject var47!class) ; Statement: $r2 = class "Lorg/apache/dubbo/common/URL;" 
(assert true)
(define-const var786 String (getName/-1958580599 var2017)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3942!2 (Array Int var457))
(assert (not (= var3942!2 null-__Array__Int__var457__)))
(assert (= (select var3942!2 1) (cast-from-String-to-var457 var786))) ; Statement: $r0[1] = $r3 
(define-const var3785 Int (Int_valueOf/-1371140006 var676)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var3942!3 (Array Int var457))
(assert (not (= var3942!3 null-__Array__Int__var457__)))
(assert (= (select var3942!3 2) (cast-from-Int-to-var457 var3785))) ; Statement: $r0[2] = $r4 
(define-const var379 String (String_format/1339386452 "if (arg%d == null) throw new IllegalArgumentException(\u0022url == null\u0022);\n%s url = arg%d;\n" var3942!3)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d == null) throw new IllegalArgumentException(\"url == null\");\n%s url = arg%d;\n", $r0) 
 ; Statement: return $r5 
(check-sat)
; {arr-var457-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var457=([java.lang.Integer], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var457=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var2086=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var133=r6, var676=i0, var457=java.lang.Object, var3942=$r0, var233=$r1, var47=org.apache.dubbo.common.URL, var2017=$r2, var786=$r3, var3785=$r4, var379=$r5}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var2086, r6=var133, i0=var676, java.lang.Object=var457, $r0=var3942, $r1=var233, org.apache.dubbo.common.URL=var47, $r2=var2017, $r3=var786, $r4=var3785, $r5=var379}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r6 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[3];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = class "Lorg/apache/dubbo/common/URL;";	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r0[1] = $r3;	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[2] = $r4;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d == null) throw new IllegalArgumentException(\"url == null\");\n%s url = arg%d;\n", $r0);	return $r5
;block_num 1