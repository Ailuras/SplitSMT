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

(declare-sort var557 0)
(declare-sort var1276 0)
(declare-sort var889 0)
(declare-sort var3130 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun tokenNameToTypeMap/976633046 (var557) var889)
(declare-fun var889_get/1088891777 (var889 var3130) var3130)
(declare-fun cast-from-String-to-var3130 (String) var3130)
(declare-fun cast-from-var3130-to-Int (var3130) Int)
(declare-const null-var557 var557)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3777 var557) ; Statement: r1 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3777 null-var557)))
(declare-const var359 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var359 null-String)))
(assert (not (and true (and (> (str.len var359) 0) (<= 0 0)))))
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), tokenNameToTypeMap/976633046=([org.antlr.v4.tool.Grammar], java.util.Map), var889_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3130=([java.lang.String], java.lang.Object), cast-from-var3130-to-Int=([java.lang.Object], java.lang.Integer)}
; {var557=org.antlr.v4.tool.Grammar, var3777=r1, var359=r0, var1276=null_type, var3852=$c0, var3300=$i2, var889=java.util.Map, var506=$r2, var3130=java.lang.Object, var1017=$r3, var2804=r6, var1118=$i1}
; {org.antlr.v4.tool.Grammar=var557, r1=var3777, r0=var359, null_type=var1276, $c0=var3852, $i2=var3300, java.util.Map=var889, $r2=var506, java.lang.Object=var3130, $r3=var1017, r6=var2804, $i1=var1118}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r1 := @this: org.antlr.v4.tool.Grammar;	r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i2 = (int) $c0;	if $i2 != 39 goto $r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap>;	$r2 = r1.<org.antlr.v4.tool.Grammar: java.util.Map tokenNameToTypeMap>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0);	r6 = (java.lang.Integer) $r3;	if r6 == null goto $i1 = 0;	$i1 = 0;	return $i1
;block_num 5