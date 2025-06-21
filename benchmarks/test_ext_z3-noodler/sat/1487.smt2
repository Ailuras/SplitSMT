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

(declare-sort var54 0)
(declare-sort var1689 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var54 var54)
(declare-const null-String String)
(declare-const var811 var54) ; Statement: r2 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var811 null-var54)))
(declare-const var488 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var488 null-String)))
(define-const var3257 String ".") ; Statement: $r1 = "." 
(assert true)
(define-const var2137 Bool (= var3257 var488)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>() 
(assert (not (= (ite var2137 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "_wild" 
(check-sat)
; {}
; {var54=org.antlr.v4.codegen.Target, var811=r2, var488=r0, var1689=null_type, var3257=$r1, var2137=$z0}
; {org.antlr.v4.codegen.Target=var54, r2=var811, r0=var488, null_type=var1689, $r1=var3257, $z0=var2137}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.antlr.v4.codegen.Target;	r0 := @parameter0: java.lang.String;	$r1 = ".";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.antlr.v4.codegen.Target: org.antlr.v4.codegen.CodeGenerator getCodeGenerator()>();	return "_wild"
;block_num 2