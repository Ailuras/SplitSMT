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

(declare-sort var2256 0)
(declare-sort var479 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getTokenName/-1751753211 (var479 Int) String)
(declare-fun escapeIfNeeded/119062879 (var2256 String) String)
(declare-const null-var2256 var2256)
(declare-const null-var479 var479)
(declare-const null-Int Int)
(declare-const var1775 var2256) ; Statement: r0 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var1775 null-var2256)))
(declare-const var2457 var479) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Grammar 
(assert (not (= var2457 null-var479)))
(declare-const var1924 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1924 null-Int)))
(assert true)
(define-const var936 String (getTokenName/-1751753211 var2457 var1924)) ; Statement: $r2 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String getTokenName(int)>(i0) 
(assert true)
(define-const var3909 String (escapeIfNeeded/119062879 var1775 var936)) ; Statement: r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String escapeIfNeeded(java.lang.String)>($r2) 
(define-const var1549 String "<INVALID>") ; Statement: $r4 = "<INVALID>" 
(assert true)
(define-const var3793 Bool (= var1549 var3909)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3) 
 ; Statement: if $z0 == 0 goto return r3 
(assert (= (ite var3793 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r3 
(check-sat)
; {getTokenName/-1751753211=([org.antlr.v4.tool.Grammar, int], java.lang.String), escapeIfNeeded/119062879=([org.antlr.v4.codegen.Target, java.lang.String], java.lang.String)}
; {var2256=org.antlr.v4.codegen.Target, var1775=r0, var479=org.antlr.v4.tool.Grammar, var2457=r1, var1924=i0, var936=$r2, var3909=r3, var1549=$r4, var3793=$z0}
; {org.antlr.v4.codegen.Target=var2256, r0=var1775, org.antlr.v4.tool.Grammar=var479, r1=var2457, i0=var1924, $r2=var936, r3=var3909, $r4=var1549, $z0=var3793}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.Target;	r1 := @parameter0: org.antlr.v4.tool.Grammar;	i0 := @parameter1: int;	$r2 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String getTokenName(int)>(i0);	r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String escapeIfNeeded(java.lang.String)>($r2);	$r4 = "<INVALID>";	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3);	if $z0 == 0 goto return r3;	return r3
;block_num 2