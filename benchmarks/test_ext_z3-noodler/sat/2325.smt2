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

(declare-sort var873 0)
(declare-sort var1136 0)
(declare-sort var3956 0)
(declare-sort var1033 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun stringLiteralToTypeMap/976633046 (var873) var3956)
(declare-fun var3956_get/1088891777 (var3956 var1033) var1033)
(declare-fun cast-from-String-to-var1033 (String) var1033)
(declare-fun cast-from-var1033-to-Int (var1033) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-const null-var873 var873)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3335 var873) ; Statement: r1 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3335 null-var873)))
(declare-const var490 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var490 null-String)))
(assert (and true (and (> (str.len var490) 0) (<= 0 0))))
(define-const var3928 Int (charAt/698050440 var490 0)) ; Statement: $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var3498 Int (cast-from-Int-to-Int var3928)) ; Statement: $i2 = (int) $c0 
 ; Statement: if $i2 != 39 goto $r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap> 
(assert (not (not (= var3498 39)))) ; Negate: Cond: $i2 != 39  
(define-const var2044 var3956 (stringLiteralToTypeMap/976633046 var3335)) ; Statement: $r4 = r1.<org.antlr.v4.tool.Grammar: java.util.Map stringLiteralToTypeMap> 
(define-const var731 var1033 (var3956_get/1088891777 var2044 (cast-from-String-to-var1033 var490))) ; Statement: $r5 = interfaceinvoke $r4.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0) 
(define-const var3568 Int (cast-from-var1033-to-Int var731)) ; Statement: r6 = (java.lang.Integer) $r5 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r6 == null goto $i1 = 0 
(assert (not (= var3568 null-Int))) ; Negate: Cond: r6 == null  
(assert true)
(define-const var1340 Int (intValue/-1815674922 var3568)) ; Statement: $i1 = virtualinvoke r6.<java.lang.Integer: int intValue()>() 
 ; Statement: goto [?= return $i1] 
(assert true) ; Non Conditional
 ; Statement: return $i1 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), stringLiteralToTypeMap/976633046=([org.antlr.v4.tool.Grammar], java.util.Map), var3956_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1033=([java.lang.String], java.lang.Object), cast-from-var1033-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int)}
; {var873=org.antlr.v4.tool.Grammar, var3335=r1, var490=r0, var1136=null_type, var3928=$c0, var3498=$i2, var3956=java.util.Map, var2044=$r4, var1033=java.lang.Object, var731=$r5, var3568=r6, var1340=$i1}
; {org.antlr.v4.tool.Grammar=var873, r1=var3335, r0=var490, null_type=var1136, $c0=var3928, $i2=var3498, java.util.Map=var3956, $r4=var2044, java.lang.Object=var1033, $r5=var731, r6=var3568, $i1=var1340}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Grammar;	r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i2 = (int) $c0;	if $i2 != 39 goto $r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap>;	$r4 = r1.<org.antlr.v4.tool.Grammar: java.util.Map stringLiteralToTypeMap>;	$r5 = interfaceinvoke $r4.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0);	r6 = (java.lang.Integer) $r5;	goto [?= (branch)];	if r6 == null goto $i1 = 0;	$i1 = virtualinvoke r6.<java.lang.Integer: int intValue()>();	goto [?= return $i1];	return $i1
;block_num 5