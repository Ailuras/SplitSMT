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

(declare-sort var750 0)
(declare-sort var3466 0)
(declare-sort var1902 0)
(declare-sort var3327 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun importedGrammars/976633046 (var750) var1902)
(declare-fun var1902_iterator/-912451715 (var1902) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun Iterator_next/-1124697587 (Iterator) var3327)
(declare-fun cast-from-var3327-to-var750 (var3327) var750)
(declare-fun name/976633046 (var750) String)
(declare-const null-var750 var750)
(declare-const null-String String)
(declare-const var561 var750) ; Statement: r0 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var561 null-var750)))
(declare-const var2467 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var2467 null-String)))
(define-const var1247 var1902 (importedGrammars/976633046 var561)) ; Statement: $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List importedGrammars> 
(define-const var2166 Iterator (var1902_iterator/-912451715 var1247)) ; Statement: r2 = interfaceinvoke $r1.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1099 Bool (Iterator_hasNext/-1669924200 var2166)) ; Statement: $z0 = interfaceinvoke r2.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return null 
(assert (not (= (ite var1099 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var481 var3327 (Iterator_next/-1124697587 var2166)) ; Statement: $r3 = interfaceinvoke r2.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var2166!1 Iterator)
(define-const var623 var750 (cast-from-var3327-to-var750 var481)) ; Statement: r4 = (org.antlr.v4.tool.Grammar) $r3 
(define-const var1347 String (name/976633046 var623)) ; Statement: $r6 = r4.<org.antlr.v4.tool.Grammar: java.lang.String name> 
(assert true)
(define-const var3426 Bool (= var1347 var2467)) ; Statement: $z1 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r5) 
 ; Statement: if $z1 == 0 goto (branch) 
(assert (not (= (ite var3426 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return r4 
(check-sat)
; {importedGrammars/976633046=([org.antlr.v4.tool.Grammar], java.util.List), var1902_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var3327-to-var750=([java.lang.Object], org.antlr.v4.tool.Grammar), name/976633046=([org.antlr.v4.tool.Grammar], java.lang.String)}
; {var750=org.antlr.v4.tool.Grammar, var561=r0, var2467=r5, var3466=null_type, var1902=java.util.List, var1247=$r1, var2166=r2, var1099=$z0, var3327=java.lang.Object, var481=$r3, var623=r4, var1347=$r6, var3426=$z1}
; {org.antlr.v4.tool.Grammar=var750, r0=var561, r5=var2467, null_type=var3466, java.util.List=var1902, $r1=var1247, r2=var2166, $z0=var1099, java.lang.Object=var3327, $r3=var481, r4=var623, $r6=var1347, $z1=var3426}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Grammar;	r5 := @parameter0: java.lang.String;	$r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List importedGrammars>;	r2 = interfaceinvoke $r1.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r2.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return null;	$r3 = interfaceinvoke r2.<java.util.Iterator: java.lang.Object next()>();	r4 = (org.antlr.v4.tool.Grammar) $r3;	$r6 = r4.<org.antlr.v4.tool.Grammar: java.lang.String name>;	$z1 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r5);	if $z1 == 0 goto (branch);	return r4
;block_num 4