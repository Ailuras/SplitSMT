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

(declare-sort var1321 0)
(declare-sort var3652 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1321-to-var3652 (var1321) var3652)
(declare-fun name/1577871405 (var1321) String)
(declare-fun cast-from-var3652-to-var1321 (var3652) var1321)
(declare-const null-var1321 var1321)
(declare-const null-var3652 var3652)
(declare-const var3221 var1321) ; Statement: r0 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var3221 null-var1321)))
(declare-const var1227 var3652) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var1227 null-var3652)))
 ; Statement: if r0 != r1 goto $z0 = r1 instanceof org.antlr.v4.tool.Rule 
(assert (not (= (cast-from-var1321-to-var3652 var3221) var1227))) ; Cond: r0 != r1 
(define-const var573 Bool false) ; Statement: $z0 = r1 instanceof org.antlr.v4.tool.Rule 
 ; Statement: if $z0 != 0 goto $r4 = r0.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert (not (= (ite var573 1 0) 0))) ; Cond: $z0 != 0 
(define-const var749 String (name/1577871405 var3221)) ; Statement: $r4 = r0.<org.antlr.v4.tool.Rule: java.lang.String name> 
(define-const var1936 var1321 (cast-from-var3652-to-var1321 var1227)) ; Statement: $r2 = (org.antlr.v4.tool.Rule) r1 
(define-const var3334 String (name/1577871405 var1936)) ; Statement: $r3 = $r2.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
(define-const var587 Bool (= var749 var3334)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: return $z1 
(check-sat)
; {cast-from-var1321-to-var3652=([org.antlr.v4.tool.Rule], java.lang.Object), name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String), cast-from-var3652-to-var1321=([java.lang.Object], org.antlr.v4.tool.Rule)}
; {var1321=org.antlr.v4.tool.Rule, var3221=r0, var3652=java.lang.Object, var1227=r1, var573=$z0, var749=$r4, var1936=$r2, var3334=$r3, var587=$z1}
; {org.antlr.v4.tool.Rule=var1321, r0=var3221, java.lang.Object=var3652, r1=var1227, $z0=var573, $r4=var749, $r2=var1936, $r3=var3334, $z1=var587}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Rule;	r1 := @parameter0: java.lang.Object;	if r0 != r1 goto $z0 = r1 instanceof org.antlr.v4.tool.Rule;	$z0 = r1 instanceof org.antlr.v4.tool.Rule;	if $z0 != 0 goto $r4 = r0.<org.antlr.v4.tool.Rule: java.lang.String name>;	$r4 = r0.<org.antlr.v4.tool.Rule: java.lang.String name>;	$r2 = (org.antlr.v4.tool.Rule) r1;	$r3 = $r2.<org.antlr.v4.tool.Rule: java.lang.String name>;	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	return $z1
;block_num 3