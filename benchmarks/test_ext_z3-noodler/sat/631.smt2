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

(declare-sort var1140 0)
(declare-sort var1171 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ambiguities/1639276216 (var1140) var1171)
(declare-fun var1171_size/-959786421 (var1171) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-const null-var1140 var1140)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const var3650 var1140) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var3650 null-var1140)))
(declare-const var407 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var407 null-__Array__Int__String__)))
(declare-const var1232 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var1232 null-Int)))
(declare-const var2847 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var2847 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var2847 5) (and (not (= var2847 4)) (and (not (= var2847 3)) (and (not (= var2847 2)) (and (not (= var2847 1)) (and (not (= var2847 0)) true))))))) ; Intersect: Cond: i0 == 5  and Intersect: Negate: Cond: i0 == 4   and Intersect: Negate: Cond: i0 == 3   and Intersect: Negate: Cond: i0 == 2   and Intersect: Negate: Cond: i0 == 1   and Intersect: Negate: Cond: i0 == 0   and Non Conditional      
(define-const var1906 var1171 (ambiguities/1639276216 var3650)) ; Statement: $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities> 
(define-const var165 Int (var1171_size/-959786421 var1906)) ; Statement: $i4 = interfaceinvoke $r2.<java.util.List: int size()>() 
(define-const var3194 Int (Int_valueOf/-1371140006 var165)) ; Statement: $r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i4) 
 ; Statement: return $r3 
(check-sat)
; {ambiguities/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], java.util.List), var1171_size/-959786421=([java.util.List], int), Int_valueOf/-1371140006=([int], java.lang.Integer)}
; {var1140=org.antlr.v4.runtime.atn.DecisionInfo, var3650=r0, var407=r9, var1232=i13, var2847=i0, var1171=java.util.List, var1906=$r2, var165=$i4, var3194=$r3}
; {org.antlr.v4.runtime.atn.DecisionInfo=var1140, r0=var3650, r9=var407, i13=var1232, i0=var2847, java.util.List=var1171, $r2=var1906, $i4=var165, $r3=var3194}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;	$i4 = interfaceinvoke $r2.<java.util.List: int size()>();	$r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i4);	return $r3
;block_num 2