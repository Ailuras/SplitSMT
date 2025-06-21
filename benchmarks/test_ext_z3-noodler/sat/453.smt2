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

(declare-sort var3938 0)
(declare-sort var1044 0)
(declare-sort var286 0)
(declare-sort var3170 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getTargetStringLiteralFromANTLRStringLiteral/-1319431774 (var3170 var1044 String Bool Bool) String)
(declare-fun cast-from-var3938-to-var3170 (var3938) var3170)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3938 var3938)
(declare-const null-var1044 var1044)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2982 var3938) ; Statement: r0 := @this: org.antlr.v4.codegen.target.PHPTarget 
(assert (not (= var2982 null-var3938)))
(declare-const var2208 var1044) ; Statement: r1 := @parameter0: org.antlr.v4.codegen.CodeGenerator 
(assert (not (= var2208 null-var1044)))
(declare-const var196 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var196 null-String)))
(declare-const var1733 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var1733 null-Bool)))
(declare-const var2419 Bool) ; Statement: z1 := @parameter3: boolean 
(assert (not (= var2419 null-Bool)))
(assert true)
(define-const var2762 String (getTargetStringLiteralFromANTLRStringLiteral/-1319431774 (cast-from-var3938-to-var3170 var2982) var2208 var196 var1733 var2419)) ; Statement: r3 = specialinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String getTargetStringLiteralFromANTLRStringLiteral(org.antlr.v4.codegen.CodeGenerator,java.lang.String,boolean,boolean)>(r1, r2, z0, z1) 
(assert true)
(define-const var1529 String (replace/2138489945 var2762 (cast-from-String-to-String "$") (cast-from-String-to-String "\u005c$"))) ; Statement: r4 = virtualinvoke r3.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "\\$") 
 ; Statement: return r4 
(check-sat)
; {getTargetStringLiteralFromANTLRStringLiteral/-1319431774=([org.antlr.v4.codegen.Target, org.antlr.v4.codegen.CodeGenerator, java.lang.String, boolean, boolean], java.lang.String), cast-from-var3938-to-var3170=([org.antlr.v4.codegen.target.PHPTarget], org.antlr.v4.codegen.Target), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3938=org.antlr.v4.codegen.target.PHPTarget, var2982=r0, var1044=org.antlr.v4.codegen.CodeGenerator, var2208=r1, var196=r2, var286=null_type, var1733=z0, var2419=z1, var3170=org.antlr.v4.codegen.Target, var2762=r3, var1529=r4}
; {org.antlr.v4.codegen.target.PHPTarget=var3938, r0=var2982, org.antlr.v4.codegen.CodeGenerator=var1044, r1=var2208, r2=var196, null_type=var286, z0=var1733, z1=var2419, org.antlr.v4.codegen.Target=var3170, r3=var2762, r4=var1529}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.target.PHPTarget;	r1 := @parameter0: org.antlr.v4.codegen.CodeGenerator;	r2 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	z1 := @parameter3: boolean;	r3 = specialinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String getTargetStringLiteralFromANTLRStringLiteral(org.antlr.v4.codegen.CodeGenerator,java.lang.String,boolean,boolean)>(r1, r2, z0, z1);	r4 = virtualinvoke r3.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "\\$");	return r4
;block_num 1