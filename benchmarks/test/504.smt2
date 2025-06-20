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

(declare-sort var1358 0)
(declare-sort var3777 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getTokenName/-1751753211 (var3777 Int) String)
(declare-fun escapeIfNeeded/119062879 (var1358 String) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var1358 var1358)
(declare-const null-var3777 var3777)
(declare-const null-Int Int)
(declare-const var3051 var1358) ; Statement: r0 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var3051 null-var1358)))
(declare-const var1956 var3777) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Grammar 
(assert (not (= var1956 null-var3777)))
(declare-const var3964 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3964 null-Int)))
(assert true)
(define-const var741 String (getTokenName/-1751753211 var1956 var3964)) ; Statement: $r2 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String getTokenName(int)>(i0) 
(assert true)
(define-const var635 String (escapeIfNeeded/119062879 var3051 var741)) ; Statement: r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String escapeIfNeeded(java.lang.String)>($r2) 
(define-const var3242 String "<INVALID>") ; Statement: $r4 = "<INVALID>" 
(assert true)
(define-const var967 Bool (= var3242 var635)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3) 
 ; Statement: if $z0 == 0 goto return r3 
(assert (not (= (ite var967 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2721 String (String_valueOf/1240665136 var3964)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
 ; Statement: return $r5 
(check-sat)
; {getTokenName/-1751753211=([org.antlr.v4.tool.Grammar, int], java.lang.String), escapeIfNeeded/119062879=([org.antlr.v4.codegen.Target, java.lang.String], java.lang.String), String_valueOf/1240665136=([int], java.lang.String)}
; {var1358=org.antlr.v4.codegen.Target, var3051=r0, var3777=org.antlr.v4.tool.Grammar, var1956=r1, var3964=i0, var741=$r2, var635=r3, var3242=$r4, var967=$z0, var2721=$r5}
; {org.antlr.v4.codegen.Target=var1358, r0=var3051, org.antlr.v4.tool.Grammar=var3777, r1=var1956, i0=var3964, $r2=var741, r3=var635, $r4=var3242, $z0=var967, $r5=var2721}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.Target;	r1 := @parameter0: org.antlr.v4.tool.Grammar;	i0 := @parameter1: int;	$r2 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String getTokenName(int)>(i0);	r3 = virtualinvoke r0.<org.antlr.v4.codegen.Target: java.lang.String escapeIfNeeded(java.lang.String)>($r2);	$r4 = "<INVALID>";	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r3);	if $z0 == 0 goto return r3;	$r5 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	return $r5
;block_num 2