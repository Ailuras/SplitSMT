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

(declare-sort var772 0)
(declare-sort var1765 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun LL_MaxLook/1639276216 (var772) Int)
(declare-fun SLL_MaxLook/1639276216 (var772) Int)
(declare-fun var1765_max/64066103 (Int Int) Int)
(declare-fun Int_valueOf/-1102777585 (Int) Int)
(declare-const null-var772 var772)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const var1643 var772) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var1643 null-var772)))
(declare-const var167 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var167 null-__Array__Int__String__)))
(declare-const var2061 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var2061 null-Int)))
(declare-const var1800 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var1800 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var1800 4) (and (not (= var1800 3)) (and (not (= var1800 2)) (and (not (= var1800 1)) (and (not (= var1800 0)) true)))))) ; Intersect: Cond: i0 == 4  and Intersect: Negate: Cond: i0 == 3   and Intersect: Negate: Cond: i0 == 2   and Intersect: Negate: Cond: i0 == 1   and Intersect: Negate: Cond: i0 == 0   and Non Conditional     
(define-const var2215 Int (LL_MaxLook/1639276216 var1643)) ; Statement: $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook> 
(define-const var3216 Int (SLL_MaxLook/1639276216 var1643)) ; Statement: $l5 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_MaxLook> 
(define-const var2562 Int (var1765_max/64066103 var2215 var3216)) ; Statement: $l7 = staticinvoke <java.lang.Math: long max(long,long)>($l6, $l5) 
(define-const var477 Int (Int_valueOf/-1102777585 var2562)) ; Statement: $r4 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l7) 
 ; Statement: return $r4 
(check-sat)
; {LL_MaxLook/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), SLL_MaxLook/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), var1765_max/64066103=([long, long], long), Int_valueOf/-1102777585=([long], java.lang.Long)}
; {var772=org.antlr.v4.runtime.atn.DecisionInfo, var1643=r0, var167=r9, var2061=i13, var1800=i0, var2215=$l6, var3216=$l5, var1765=java.lang.Math, var2562=$l7, var477=$r4}
; {org.antlr.v4.runtime.atn.DecisionInfo=var772, r0=var1643, r9=var167, i13=var2061, i0=var1800, $l6=var2215, $l5=var3216, java.lang.Math=var1765, $l7=var2562, $r4=var477}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;	$l5 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_MaxLook>;	$l7 = staticinvoke <java.lang.Math: long max(long,long)>($l6, $l5);	$r4 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l7);	return $r4
;block_num 2