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

(declare-sort var2549 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun timeInPrediction/1639276216 (var2549) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun Float64_valueOf/679560954 (Float64) Float64)
(declare-const null-var2549 var2549)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const var181 var2549) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var181 null-var2549)))
(declare-const var2103 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var2103 null-__Array__Int__String__)))
(declare-const var3260 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var3260 null-Int)))
(declare-const var1227 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var1227 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var1227 2) (and (not (= var1227 1)) (and (not (= var1227 0)) true)))) ; Intersect: Cond: i0 == 2  and Intersect: Negate: Cond: i0 == 1   and Intersect: Negate: Cond: i0 == 0   and Non Conditional   
(define-const var723 Int (timeInPrediction/1639276216 var181)) ; Statement: $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction> 
(define-const var1711 Float64 (cast-from-Int-to-Float64 var723)) ; Statement: $d0 = (double) $l11 
(define-const var2972 Float64 (fp.div roundNearestTiesToEven var1711 ((_ to_fp 11 53) #x412e848000000000))) ; Statement: $d1 = $d0 / 1000000.0 
(define-const var2958 Float64 (Float64_valueOf/679560954 var2972)) ; Statement: $r6 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>($d1) 
 ; Statement: return $r6 
(check-sat)
; {timeInPrediction/1639276216=([org.antlr.v4.runtime.atn.DecisionInfo], long), cast-from-Int-to-Float64=([long], double), Float64_valueOf/679560954=([double], java.lang.Double)}
; {var2549=org.antlr.v4.runtime.atn.DecisionInfo, var181=r0, var2103=r9, var3260=i13, var1227=i0, var723=$l11, var1711=$d0, var2972=$d1, var2958=$r6}
; {org.antlr.v4.runtime.atn.DecisionInfo=var2549, r0=var181, r9=var2103, i13=var3260, i0=var1227, $l11=var723, $d0=var1711, $d1=var2972, $r6=var2958}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;	$d0 = (double) $l11;	$d1 = $d0 / 1000000.0;	$r6 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>($d1);	return $r6
;block_num 2