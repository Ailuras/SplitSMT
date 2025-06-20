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

(declare-sort var2195 0)
(declare-sort var1442 0)
(declare-sort var1542 0)
(declare-sort var2589 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun typeToTokenList/976633046 (var2195) var1542)
(declare-fun var1542_size/-959786421 (var1542) Int)
(declare-fun var1542_get/-1216255739 (var1542 Int) var2589)
(declare-fun cast-from-var2589-to-String (var2589) String)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-const null-var2195 var2195)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var3898 var2195) ; Statement: r0 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3898 null-var2195)))
(declare-const var3002 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3002 null-Int)))
(declare-const var2169 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var2169 null-String)))
(define-const var1934 Int (cast-from-Int-to-Int -1)) ; Statement: $i5 = (int) -1 
 ; Statement: if i0 != $i5 goto $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(assert (not (= var3002 var1934))) ; Cond: i0 != $i5 
(define-const var2207 var1542 (typeToTokenList/976633046 var3898)) ; Statement: $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(define-const var768 Int (var1542_size/-959786421 var2207)) ; Statement: $i1 = interfaceinvoke $r1.<java.util.List: int size()>() 
 ; Statement: if i0 < $i1 goto $r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(assert (< var3002 var768)) ; Cond: i0 < $i1 
(define-const var93 var1542 (typeToTokenList/976633046 var3898)) ; Statement: $r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(define-const var607 var2589 (var1542_get/-1216255739 var93 var3002)) ; Statement: $r3 = interfaceinvoke $r2.<java.util.List: java.lang.Object get(int)>(i0) 
(define-const var3081 String (cast-from-var2589-to-String var607)) ; Statement: $r7 = (java.lang.String) $r3 
 ; Statement: if $r7 == null goto $r5 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList> 
(assert (not (= var3081 null-String))) ; Negate: Cond: $r7 == null  
(assert (and true (and (> (str.len var3081) 0) (<= 0 0))))
(define-const var1267 Int (charAt/698050440 var3081 0)) ; Statement: $c2 = virtualinvoke $r7.<java.lang.String: char charAt(int)>(0) 
(define-const var1691 Int (cast-from-Int-to-Int var1267)) ; Statement: $i6 = (int) $c2 
 ; Statement: if $i6 != 39 goto return 
(assert (not (= var1691 39))) ; Cond: $i6 != 39 
 ; Statement: return 
(check-sat)
; {cast-from-Int-to-Int=([int], int), typeToTokenList/976633046=([org.antlr.v4.tool.Grammar], java.util.List), var1542_size/-959786421=([java.util.List], int), var1542_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var2589-to-String=([java.lang.Object], java.lang.String), charAt/698050440=([java.lang.String, int], char)}
; {var2195=org.antlr.v4.tool.Grammar, var3898=r0, var3002=i0, var2169=r4, var1442=null_type, var1934=$i5, var1542=java.util.List, var2207=$r1, var768=$i1, var93=$r2, var2589=java.lang.Object, var607=$r3, var3081=$r7, var1267=$c2, var1691=$i6}
; {org.antlr.v4.tool.Grammar=var2195, r0=var3898, i0=var3002, r4=var2169, null_type=var1442, $i5=var1934, java.util.List=var1542, $r1=var2207, $i1=var768, $r2=var93, java.lang.Object=var2589, $r3=var607, $r7=var3081, $c2=var1267, $i6=var1691}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Grammar;	i0 := @parameter0: int;	r4 := @parameter1: java.lang.String;	$i5 = (int) -1;	if i0 != $i5 goto $r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r1 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$i1 = interfaceinvoke $r1.<java.util.List: int size()>();	if i0 < $i1 goto $r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r2 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$r3 = interfaceinvoke $r2.<java.util.List: java.lang.Object get(int)>(i0);	$r7 = (java.lang.String) $r3;	if $r7 == null goto $r5 = r0.<org.antlr.v4.tool.Grammar: java.util.List typeToTokenList>;	$c2 = virtualinvoke $r7.<java.lang.String: char charAt(int)>(0);	$i6 = (int) $c2;	if $i6 != 39 goto return;	return
;block_num 5