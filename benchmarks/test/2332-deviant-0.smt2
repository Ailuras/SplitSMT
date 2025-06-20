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

(declare-sort var2876 0)
(declare-sort var2913 0)
(declare-sort var210 0)
(declare-sort var245 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun tokenNameToTypeMap/976633046 (var2876) var210)
(declare-fun var210_get/1088891777 (var210 var245) var245)
(declare-fun cast-from-String-to-var245 (String) var245)
(declare-fun cast-from-var245-to-Int (var245) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-const null-var2876 var2876)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1586 var2876) ; Statement: r1 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var1586 null-var2876)))
(declare-const var3128 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3128 null-String)))
(assert (not (and true (and (> (str.len var3128) 0) (<= 0 0)))))
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), tokenNameToTypeMap/976633046=([org.antlr.v4.tool.Grammar], java.util.Map), var210_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var245=([java.lang.String], java.lang.Object), cast-from-var245-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int)}
; {var2876=org.antlr.v4.tool.Grammar, var1586=r1, var3128=r0, var2913=null_type, var2036=$c0, var3628=$i2, var210=java.util.Map, var3005=$r2, var245=java.lang.Object, var1073=$r3, var3755=r6, var1371=$i1}
; {org.antlr.v4.tool.Grammar=var2876, r1=var1586, r0=var3128, null_type=var2913, $c0=var2036, $i2=var3628, java.util.Map=var210, $r2=var3005, java.lang.Object=var245, $r3=var1073, r6=var3755, $i1=var1371}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Grammar;	r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i2 = (int) $c0;	if $i2 != 39 goto $r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap>;	$r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0);	r6 = (java.lang.Integer) $r3;	if r6 == null goto $i1 = 0;	$i1 = virtualinvoke r6.<java.lang.Integer: int intValue()>();	goto [?= return $i1];	return $i1
;block_num 5