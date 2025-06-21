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

(declare-sort var359 0)
(declare-sort var1195 0)
(declare-sort var1690 0)
(declare-sort var1783 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun stringLiteralToTypeMap/976633046 (var359) var1690)
(declare-fun var1690_get/1088891777 (var1690 var1783) var1783)
(declare-fun cast-from-String-to-var1783 (String) var1783)
(declare-fun cast-from-var1783-to-Int (var1783) Int)
(declare-const null-var359 var359)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2919 var359) ; Statement: r1 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var2919 null-var359)))
(declare-const var899 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var899 null-String)))
(assert (not (and true (and (> (str.len var899) 0) (<= 0 0)))))
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), stringLiteralToTypeMap/976633046=([org.antlr.v4.tool.Grammar], java.util.Map), var1690_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1783=([java.lang.String], java.lang.Object), cast-from-var1783-to-Int=([java.lang.Object], java.lang.Integer)}
; {var359=org.antlr.v4.tool.Grammar, var2919=r1, var899=r0, var1195=null_type, var2025=$c0, var3215=$i2, var1690=java.util.Map, var2742=$r4, var1783=java.lang.Object, var3925=$r5, var649=r6, var1191=$i1}
; {org.antlr.v4.tool.Grammar=var359, r1=var2919, r0=var899, null_type=var1195, $c0=var2025, $i2=var3215, java.util.Map=var1690, $r4=var2742, java.lang.Object=var1783, $r5=var3925, r6=var649, $i1=var1191}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Grammar;	r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i2 = (int) $c0;	if $i2 != 39 goto $r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap>;	$r4 = r1.<org.antlr.v4.tool.Grammar: java.util.Map stringLiteralToTypeMap>;	$r5 = interfaceinvoke $r4.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0);	r6 = (java.lang.Integer) $r5;	goto [?= (branch)];	if r6 == null goto $i1 = 0;	$i1 = 0;	return $i1
;block_num 5