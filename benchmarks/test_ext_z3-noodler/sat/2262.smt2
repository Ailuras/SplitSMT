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

(declare-sort var1765 0)
(declare-sort var3187 0)
(declare-sort var962 0)
(declare-sort var170 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1577871405 (var1765) String)
(declare-fun getAnyLabelDef/-836633635 (var1765 String) var962)
(declare-fun g/1577871405 (var1765) var170)
(declare-fun getRule/544933603 (var170 String) var1765)
(declare-const null-var1765 var1765)
(declare-const null-String String)
(declare-const null-var962 var962)
(declare-const var3627 var1765) ; Statement: r1 := @this: org.antlr.v4.tool.Rule 
(assert (not (= var3627 null-var1765)))
(declare-const var2939 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2939 null-String)))
(define-const var2047 String (name/1577871405 var3627)) ; Statement: $r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name> 
(assert true)
(define-const var1884 Bool (= var2939 var2047)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z0 == 0 goto r3 = virtualinvoke r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.LabelElementPair getAnyLabelDef(java.lang.String)>(r0) 
(assert (= (ite var1884 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1727 var962 (getAnyLabelDef/-836633635 var3627 var2939)) ; Statement: r3 = virtualinvoke r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.LabelElementPair getAnyLabelDef(java.lang.String)>(r0) 
 ; Statement: if r3 == null goto $r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.Grammar g> 
(assert (= var1727 null-var962)) ; Cond: r3 == null 
(define-const var521 var170 (g/1577871405 var3627)) ; Statement: $r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.Grammar g> 
(assert true)
(define-const var1068 var1765 (getRule/544933603 var521 var2939)) ; Statement: $r5 = virtualinvoke $r4.<org.antlr.v4.tool.Grammar: org.antlr.v4.tool.Rule getRule(java.lang.String)>(r0) 
 ; Statement: return $r5 
(check-sat)
; {name/1577871405=([org.antlr.v4.tool.Rule], java.lang.String), getAnyLabelDef/-836633635=([org.antlr.v4.tool.Rule, java.lang.String], org.antlr.v4.tool.LabelElementPair), g/1577871405=([org.antlr.v4.tool.Rule], org.antlr.v4.tool.Grammar), getRule/544933603=([org.antlr.v4.tool.Grammar, java.lang.String], org.antlr.v4.tool.Rule)}
; {var1765=org.antlr.v4.tool.Rule, var3627=r1, var2939=r0, var3187=null_type, var2047=$r2, var1884=$z0, var962=org.antlr.v4.tool.LabelElementPair, var1727=r3, var170=org.antlr.v4.tool.Grammar, var521=$r4, var1068=$r5}
; {org.antlr.v4.tool.Rule=var1765, r1=var3627, r0=var2939, null_type=var3187, $r2=var2047, $z0=var1884, org.antlr.v4.tool.LabelElementPair=var962, r3=var1727, org.antlr.v4.tool.Grammar=var170, $r4=var521, $r5=var1068}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Rule;	r0 := @parameter0: java.lang.String;	$r2 = r1.<org.antlr.v4.tool.Rule: java.lang.String name>;	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z0 == 0 goto r3 = virtualinvoke r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.LabelElementPair getAnyLabelDef(java.lang.String)>(r0);	r3 = virtualinvoke r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.LabelElementPair getAnyLabelDef(java.lang.String)>(r0);	if r3 == null goto $r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.Grammar g>;	$r4 = r1.<org.antlr.v4.tool.Rule: org.antlr.v4.tool.Grammar g>;	$r5 = virtualinvoke $r4.<org.antlr.v4.tool.Grammar: org.antlr.v4.tool.Rule getRule(java.lang.String)>(r0);	return $r5
;block_num 3