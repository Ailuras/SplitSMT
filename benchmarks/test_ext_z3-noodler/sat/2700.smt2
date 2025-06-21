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

(declare-sort var808 0)
(declare-sort var1383 0)
(declare-sort var3213 0)
(declare-sort var611 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun typeToTokenList/976633046 (var808) var3213)
(declare-fun var3213_size/-959786421 (var3213) Int)
(declare-fun var3213_get/-1216255739 (var3213 Int) var611)
(declare-fun cast-from-var611-to-String (var611) String)
(declare-fun var3213_set/-1241329960 (var3213 Int var611) var611)
(declare-fun cast-from-String-to-var611 (String) var611)
(declare-const null-var808 var808)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var3742 var808) ; Statement: r0 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3742 null-var808)))
(declare-const var1049 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1049 null-Int)))
(declare-const var487 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var487 null-String)))
(define-const var619 Int (cast-from-Int-to-Int -1)) ; Statement: $i5 = (int) -1 
 ; Statement: if i0 != $i5 goto $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(assert (not (= var1049 var619))) ; Cond: i0 != $i5 
(define-const var733 var3213 (typeToTokenList/976633046 var3742)) ; Statement: $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(define-const var2600 Int (var3213_size/-959786421 var733)) ; Statement: $i1 = interfaceinvoke $r1.<java.util.List: int size()>() 
 ; Statement: if i0 < $i1 goto $r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(assert (< var1049 var2600)) ; Cond: i0 < $i1 
(define-const var90 var3213 (typeToTokenList/976633046 var3742)) ; Statement: $r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(define-const var2296 var611 (var3213_get/-1216255739 var90 var1049)) ; Statement: $r3 = interfaceinvoke $r2.<java.util.List: java.lang.Object get(int)>(i0) 
(define-const var2685 String (cast-from-var611-to-String var2296)) ; Statement: $r7 = (java.lang.String) $r3 
 ; Statement: if $r7 == null goto $r5 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(assert (= var2685 null-String)) ; Cond: $r7 == null 
(define-const var3672 var3213 (typeToTokenList/976633046 var3742)) ; Statement: $r5 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
;(assert (var3213_set/-1241329960 var3672 var1049 (cast-from-String-to-var611 var487))) ; Statement: interfaceinvoke $r5.<java.util.List: java.lang.Object set(int,java.lang.Object)>(i0, r4) 

(declare-const var3672!1 var3213)
(declare-const var1049!1 Int)
(declare-const var487!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {cast-from-Int-to-Int=([int], int), typeToTokenList/976633046=([org.antlr.v4.tool.Grammar], java.util.List), var3213_size/-959786421=([java.util.List], int), var3213_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var611-to-String=([java.lang.Object], java.lang.String), var3213_set/-1241329960=([java.util.List, int, java.lang.Object], java.lang.Object), cast-from-String-to-var611=([java.lang.String], java.lang.Object)}
; {var808=org.antlr.v4.tool.Grammar, var3742=r0, var1049=i0, var487=r4, var1383=null_type, var619=$i5, var3213=java.util.List, var733=$r1, var2600=$i1, var90=$r2, var611=java.lang.Object, var2296=$r3, var2685=$r7, var3672=$r5}
; {org.antlr.v4.tool.Grammar=var808, r0=var3742, i0=var1049, r4=var487, null_type=var1383, $i5=var619, java.util.List=var3213, $r1=var733, $i1=var2600, $r2=var90, java.lang.Object=var611, $r3=var2296, $r7=var2685, $r5=var3672}
;seq 
;cnt {}
;stmts r0 := @this: org.antlr.v4.tool.Grammar;	i0 := @parameter0: int;	r4 := @parameter1: java.lang.String;	$i5 = (int) -1;	if i0 != $i5 goto $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$i1 = interfaceinvoke $r1.<java.util.List: int size()>();	if i0 < $i1 goto $r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r3 = interfaceinvoke $r2.<java.util.List: java.lang.Object get(int)>(i0);	$r7 = (java.lang.String) $r3;	if $r7 == null goto $r5 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r5 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	interfaceinvoke $r5.<java.util.List: java.lang.Object set(int,java.lang.Object)>(i0, r4);	return
;block_num 5