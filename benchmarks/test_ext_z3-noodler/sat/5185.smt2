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

(declare-sort var2740 0)
(declare-sort var960 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var960_isNumber/1050655655 (String) Bool)
(declare-fun Int_parseLong/-436876155 (String) Int)
(declare-const null-String String)
(declare-const var1190 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1190 null-String)))
(define-const var2306 Bool (var960_isNumber/1050655655 var1190)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $l0 = 0L 
(assert (not (= (ite var2306 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2252 Int (Int_parseLong/-436876155 var1190)) ; Statement: $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r0) 
 ; Statement: goto [?= return $l0] 
(assert true) ; Non Conditional
 ; Statement: return $l0 
(check-sat)
; {var960_isNumber/1050655655=([java.lang.String], boolean), Int_parseLong/-436876155=([java.lang.String], long)}
; {var1190=r0, var2740=null_type, var960=org.apache.dubbo.common.utils.StringUtils, var2306=$z0, var2252=$l0}
; {r0=var1190, null_type=var2740, org.apache.dubbo.common.utils.StringUtils=var960, $z0=var2306, $l0=var2252}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 == 0 goto $l0 = 0L;	$l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r0);	goto [?= return $l0];	return $l0
;block_num 3