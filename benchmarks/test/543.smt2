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

(declare-sort var3272 0)
(declare-sort var1310 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1310-init () (Array Int var1310))
(declare-fun cast-from-String-to-var1310 (String) var1310)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1310 (Int) var1310)
(declare-fun String_format/1339386452 (String (Array Int var1310)) String)
(declare-const null-var3272 var3272)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1310__ (Array Int var1310))
(declare-const var3624 var3272) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo 
(assert (not (= var3624 null-var3272)))
(declare-const var3421 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var3421 null-__Array__Int__String__)))
(declare-const var306 Int) ; Statement: i13 := @parameter2: int 
(assert (not (= var306 null-Int)))
(declare-const var389 Int) ; Statement: i0 := @parameter3: int 
(assert (not (= var389 null-Int)))
 ; Statement: tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; } 
(assert (and (= var389 0) true)) ; Intersect: Cond: i0 == 0  and Non Conditional 
(define-const var313 (Array Int var1310) arr-var1310-init) ; Statement: $r8 = newarray (java.lang.Object)[2] 
(define-const var3508 String (select var3421 var306)) ; Statement: $r10 = r9[i13] 
(declare-const var313!1 (Array Int var1310))
(assert (not (= var313!1 null-__Array__Int__var1310__)))
(assert (= (select var313!1 0) (cast-from-String-to-var1310 var3508))) ; Statement: $r8[0] = $r10 
(define-const var3566 Int (Int_valueOf/-1371140006 var306)) ; Statement: $r11 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i13) 
(declare-const var313!2 (Array Int var1310))
(assert (not (= var313!2 null-__Array__Int__var1310__)))
(assert (= (select var313!2 1) (cast-from-Int-to-var1310 var3566))) ; Statement: $r8[1] = $r11 
(define-const var12 String (String_format/1339386452 "%s:%d" var313!2)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s:%d", $r8) 
 ; Statement: return $r12 
(check-sat)
; {arr-var1310-init=([], java.lang.Object[]), cast-from-String-to-var1310=([java.lang.String], java.lang.Object), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1310=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3272=org.antlr.v4.runtime.atn.DecisionInfo, var3624=r0, var3421=r9, var306=i13, var389=i0, var1310=java.lang.Object, var313=$r8, var3508=$r10, var3566=$r11, var12=$r12}
; {org.antlr.v4.runtime.atn.DecisionInfo=var3272, r0=var3624, r9=var3421, i13=var306, i0=var389, java.lang.Object=var1310, $r8=var313, $r10=var3508, $r11=var3566, $r12=var12}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: org.antlr.v4.runtime.atn.DecisionInfo;	r9 := @parameter1: java.lang.String[];	i13 := @parameter2: int;	i0 := @parameter3: int;	tableswitch(i0) {     case 0: goto $r8 = newarray (java.lang.Object)[2];     case 1: goto $l12 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long invocations>;     case 2: goto $l11 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long timeInPrediction>;     case 3: goto $l9 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_TotalLook>;     case 4: goto $l6 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long LL_MaxLook>;     case 5: goto $r2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: java.util.List ambiguities>;     case 6: goto $l2 = r0.<org.antlr.v4.runtime.atn.DecisionInfo: long SLL_ATNTransitions>;     default: goto return "n/a"; };	$r8 = newarray (java.lang.Object)[2];	$r10 = r9[i13];	$r8[0] = $r10;	$r11 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i13);	$r8[1] = $r11;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s:%d", $r8);	return $r12
;block_num 2