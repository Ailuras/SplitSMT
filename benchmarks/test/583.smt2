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

(declare-sort var2007 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun invocations/1639276216 (var2007) Int)
(declare-fun Int_valueOf/-1102777585 (Int) Int)
(declare-const null-var2007 var2007)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const var2286 var2007) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var2286 null-var2007)))
(declare-const var808 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var808 null-__Array__Int__String__)))
(declare-const var1778 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var1778 null-Int)))
(declare-const var1117 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var1117 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var1117 1) (and (not (= var1117 0)) true))) ; Intersect: Cond: i0 == 1  and Intersect: Negate: Cond: i0 == 0   and Non Conditional  
(define-const var1700 Int (invocations/1639276216 var2286)) ; Statement: $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations> 
(define-const var721 Int (Int_valueOf/-1102777585 var1700)) ; Statement: $r7 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l12) 
 ; Statement: return $r7 
(check-sat)
; {invocations/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), Int_valueOf/-1102777585=([long], java.lang.Long)}
; {var2007=org.antlr.v4.runtime.atn.DecisionInfo, var2286=r0, var808=r9, var1778=i13, var1117=i0, var1700=$l12, var721=$r7}
; {org.antlr.v4.runtime.atn.DecisionInfo=var2007, r0=var2286, r9=var808, i13=var1778, i0=var1117, $l12=var1700, $r7=var721}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;	$r7 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l12);	return $r7
;block_num 2