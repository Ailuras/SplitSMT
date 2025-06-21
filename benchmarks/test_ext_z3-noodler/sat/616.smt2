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

(declare-sort var710 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun LL_TotalLook/1639276216 (var710) Int)
(declare-fun SLL_TotalLook/1639276216 (var710) Int)
(declare-fun Int_valueOf/-1102777585 (Int) Int)
(declare-const null-var710 var710)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const var2282 var710) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var2282 null-var710)))
(declare-const var2033 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var2033 null-__Array__Int__String__)))
(declare-const var3081 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var3081 null-Int)))
(declare-const var3714 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var3714 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var3714 3) (and (not (= var3714 2)) (and (not (= var3714 1)) (and (not (= var3714 0)) true))))) ; Intersect: Cond: i0 == 3  and Intersect: Negate: Cond: i0 == 2   and Intersect: Negate: Cond: i0 == 1   and Intersect: Negate: Cond: i0 == 0   and Non Conditional    
(define-const var3337 Int (LL_TotalLook/1639276216 var2282)) ; Statement: $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook> 
(define-const var3138 Int (SLL_TotalLook/1639276216 var2282)) ; Statement: $l8 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_TotalLook> 
(define-const var2617 Int (+ var3337 var3138)) ; Statement: $l10 = $l9 + $l8 
(define-const var2215 Int (Int_valueOf/-1102777585 var2617)) ; Statement: $r5 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l10) 
 ; Statement: return $r5 
(check-sat)
; {LL_TotalLook/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), SLL_TotalLook/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), Int_valueOf/-1102777585=([long], java.lang.Long)}
; {var710=org.antlr.v4.runtime.atn.DecisionInfo, var2282=r0, var2033=r9, var3081=i13, var3714=i0, var3337=$l9, var3138=$l8, var2617=$l10, var2215=$r5}
; {org.antlr.v4.runtime.atn.DecisionInfo=var710, r0=var2282, r9=var2033, i13=var3081, i0=var3714, $l9=var3337, $l8=var3138, $l10=var2617, $r5=var2215}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;	$l8 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_TotalLook>;	$l10 = $l9 + $l8;	$r5 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l10);	return $r5
;block_num 2