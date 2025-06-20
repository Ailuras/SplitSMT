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

(declare-sort var203 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun SLL_ATNTransitions/1639276216 (var203) Int)
(declare-fun LL_ATNTransitions/1639276216 (var203) Int)
(declare-fun Int_valueOf/-1102777585 (Int) Int)
(declare-const null-var203 var203)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const var36 var203) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var36 null-var203)))
(declare-const var3225 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var3225 null-__Array__Int__String__)))
(declare-const var3694 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var3694 null-Int)))
(declare-const var1603 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var1603 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var1603 6) (and (not (= var1603 5)) (and (not (= var1603 4)) (and (not (= var1603 3)) (and (not (= var1603 2)) (and (not (= var1603 1)) (and (not (= var1603 0)) true)))))))) ; Intersect: Cond: i0 == 6  and Intersect: Negate: Cond: i0 == 5   and Intersect: Negate: Cond: i0 == 4   and Intersect: Negate: Cond: i0 == 3   and Intersect: Negate: Cond: i0 == 2   and Intersect: Negate: Cond: i0 == 1   and Intersect: Negate: Cond: i0 == 0   and Non Conditional       
(define-const var3556 Int (SLL_ATNTransitions/1639276216 var36)) ; Statement: $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions> 
(define-const var3085 Int (LL_ATNTransitions/1639276216 var36)) ; Statement: $l1 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_ATNTransitions> 
(define-const var3464 Int (+ var3556 var3085)) ; Statement: $l3 = $l2 + $l1 
(define-const var1909 Int (Int_valueOf/-1102777585 var3464)) ; Statement: $r1 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l3) 
 ; Statement: return $r1 
(check-sat)
; {SLL_ATNTransitions/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), LL_ATNTransitions/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), Int_valueOf/-1102777585=([long], java.lang.Long)}
; {var203=org.antlr.v4.runtime.atn.DecisionInfo, var36=r0, var3225=r9, var3694=i13, var1603=i0, var3556=$l2, var3085=$l1, var3464=$l3, var1909=$r1}
; {org.antlr.v4.runtime.atn.DecisionInfo=var203, r0=var36, r9=var3225, i13=var3694, i0=var1603, $l2=var3556, $l1=var3085, $l3=var3464, $r1=var1909}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;	$l1 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_ATNTransitions>;	$l3 = $l2 + $l1;	$r1 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l3);	return $r1
;block_num 2