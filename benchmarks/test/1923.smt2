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

(declare-sort var3029 0)
(declare-sort var1505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var3029 var3029)
(declare-const null-String String)
(declare-const var953 var3029) ; Statement: r7 := @this: org.antlr.v4.tool.BuildDependencyGenerator 
(assert (not (= var953 null-var3029)))
(declare-const var3294 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3294 null-String)))
(declare-const var2723 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2723 null-String)))
(assert true)
(define-const var1422 Bool (= var3294 ".")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>(".") 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(32) 
(assert (not (= (ite var1422 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {}
; {var3029=org.antlr.v4.tool.BuildDependencyGenerator, var953=r7, var3294=r0, var1505=null_type, var2723=r1, var1422=$z0}
; {org.antlr.v4.tool.BuildDependencyGenerator=var3029, r7=var953, r0=var3294, null_type=var1505, r1=var2723, $z0=var1422}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.antlr.v4.tool.BuildDependencyGenerator;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>(".");	if $z0 == 0 goto $i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(32);	return r1
;block_num 2