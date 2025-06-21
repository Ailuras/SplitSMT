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

(declare-sort var2288 0)
(declare-sort var2649 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1577871405 (var2288) String)
(declare-const null-var2288 var2288)
(declare-const null-String String)
(declare-const var1727 var2288) ; Statement: r1 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var1727 null-var2288)))
(declare-const var2657 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2657 null-String)))
(define-const var76 String (name/1577871405 var1727)) ; Statement: $r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
(define-const var1822 Bool (= var2657 var76)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z0 == 0 goto r3 = virtualinvoke r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.LabelElementPair getAnyLabelDef(java.lang.String)>(r0) 
(assert (not (= (ite var1822 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String)}
; {var2288=org.antlr.v4.tool.Rule, var1727=r1, var2657=r0, var2649=null_type, var76=$r2, var1822=$z0}
; {org.antlr.v4.tool.Rule=var2288, r1=var1727, r0=var2657, null_type=var2649, $r2=var76, $z0=var1822}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Rule;	r0 := @parameter0: java.lang.String;	$r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name>;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z0 == 0 goto r3 = virtualinvoke r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.LabelElementPair getAnyLabelDef(java.lang.String)>(r0);	return r1
;block_num 2