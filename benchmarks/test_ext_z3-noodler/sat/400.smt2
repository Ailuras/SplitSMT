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

(declare-sort var1033 0)
(declare-sort var2653 0)
(declare-sort var919 0)
(declare-sort var3653 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getTargetStringLiteralFromANTLRStringLiteral/-1319431774 (var3653 var2653 String Bool Bool) String)
(declare-fun cast-from-var1033-to-var3653 (var1033) var3653)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1033 var1033)
(declare-const null-var2653 var2653)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var118 var1033) ; Statement: r0 := @this: org.antlr.v4.codegen.target.DartTarget 
(assert (not (= var118 null-var1033)))
(declare-const var2960 var2653) ; Statement: r1 := @parameter0: org.antlr.v4.codegen.CodeGenerator 
(assert (not (= var2960 null-var2653)))
(declare-const var2976 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2976 null-String)))
(declare-const var906 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var906 null-Bool)))
(declare-const var1638 Bool) ; Statement: z1 := @parameter3: boolean 
(assert (not (= var1638 null-Bool)))
(assert true)
(define-const var365 String (getTargetStringLiteralFromANTLRStringLiteral/-1319431774 (cast-from-var1033-to-var3653 var118) var2960 var2976 var906 var1638)) ; Statement: $r3 = specialinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String getTargetStringLiteralFromANTLRStringLiteral(org.antlr.v4.codegen.CodeGenerator,java.lang.String,boolean,boolean)>(r1, r2, z0, z1) 
(assert true)
(define-const var3335 String (replace/2138489945 var365 (cast-from-String-to-String "$") (cast-from-String-to-String "\u005c$"))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "\\$") 
 ; Statement: return $r4 
(check-sat)
; {getTargetStringLiteralFromANTLRStringLiteral/-1319431774=([org.antlr.v4.codegen.Target, org.antlr.v4.codegen.CodeGenerator, java.lang.String, boolean, boolean], java.lang.String), cast-from-var1033-to-var3653=([org.antlr.v4.codegen.target.DartTarget], org.antlr.v4.codegen.Target), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1033=org.antlr.v4.codegen.target.DartTarget, var118=r0, var2653=org.antlr.v4.codegen.CodeGenerator, var2960=r1, var2976=r2, var919=null_type, var906=z0, var1638=z1, var3653=org.antlr.v4.codegen.Target, var365=$r3, var3335=$r4}
; {org.antlr.v4.codegen.target.DartTarget=var1033, r0=var118, org.antlr.v4.codegen.CodeGenerator=var2653, r1=var2960, r2=var2976, null_type=var919, z0=var906, z1=var1638, org.antlr.v4.codegen.Target=var3653, $r3=var365, $r4=var3335}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.DartTarget;	r1 := @parameter0: org.antlr.v4.codegen.CodeGenerator;	r2 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	z1 := @parameter3: boolean;	$r3 = specialinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String getTargetStringLiteralFromANTLRStringLiteral(org.antlr.v4.codegen.CodeGenerator,java.lang.String,boolean,boolean)>(r1, r2, z0, z1);	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "\\$");	return $r4
;block_num 1