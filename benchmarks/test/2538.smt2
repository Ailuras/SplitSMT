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

(declare-sort var430 0)
(declare-sort var673 0)
(declare-sort var1811 0)
(declare-sort var2598 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getOperands/270673544 (var673) var2598)
(declare-fun var2598_iterator/-1617794947 (var2598) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var430 var430)
(declare-const null-var673 var673)
(declare-const null-String String)
(declare-const var2309 var430) ; Statement: r7 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var2309 null-var430)))
(declare-const var3544 var673) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.atn.SemanticContext$Operator 
(assert (not (= var3544 null-var673)))
(declare-const var1740 String) ; Statement: r9 := @parameter1: java.lang.String 
(assert (not (= var1740 null-String)))
(define-const var603 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var603)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var603!1 String)
(assert (= var603!1 ""))
(assert true)
(define-const var1145 var2598 (getOperands/270673544 var3544)) ; Statement: $r2 = virtualinvoke r1.<org.antlr.v4.runtime.atn.SemanticContext$Operator: java.util.Collection getOperands()>() 
(define-const var2788 Iterator (var2598_iterator/-1617794947 var1145)) ; Statement: r3 = interfaceinvoke $r2.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var567 Bool (Iterator_hasNext/-1669924200 var2788)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var567 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1834 String (toString/-2075883882 var603!1)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getOperands/270673544=([org.antlr.v4.runtime.atn.SemanticContext$Operator], java.util.Collection), var2598_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var430=org.antlr.v4.tool.Grammar, var2309=r7, var673=org.antlr.v4.runtime.atn.SemanticContext$Operator, var3544=r1, var1740=r9, var1811=null_type, var603=$r0, var2598=java.util.Collection, var1145=$r2, var2788=r3, var567=$z0, var1834=$r4}
; {org.antlr.v4.tool.Grammar=var430, r7=var2309, org.antlr.v4.runtime.atn.SemanticContext$Operator=var673, r1=var3544, r9=var1740, null_type=var1811, $r0=var603, java.util.Collection=var2598, $r2=var1145, r3=var2788, $z0=var567, $r4=var1834}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.antlr.v4.tool.Grammar;	r1 := @parameter0: org.antlr.v4.runtime.atn.SemanticContext$Operator;	r9 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.antlr.v4.runtime.atn.SemanticContext$Operator: java.util.Collection getOperands()>();	r3 = interfaceinvoke $r2.<java.util.Collection: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3